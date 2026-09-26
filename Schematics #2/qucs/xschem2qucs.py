#!/usr/bin/env python3
"""xschem -> Qucs-S converter for the bias-other cells and testbenches.

    python3 qucs/xschem2qucs.py

Reads xschem/*.sch + *.sym (the cells) and sims/tb/*.sch (the
testbenches) and writes the Qucs-S schematics into qucs/.  xschem stays
the source of truth: re-run this after changing a schematic.

How things map
  GF180 devices (nfet3/pfet3_06v0, ppolyf_u_1k, nwell, cap_mim_2f0fF)
      -> "SPICE library device" (SpLib) with a symbol drawn from the PDK's own
         xschem symbol, so pins sit where xschem has them and the wires carry
         over unchanged.  The instance netlists exactly as xschem's does
         (XM1 d g s b nfet_06v0 L=.. W=.. ad=..).  The body of a 3-pin MOS
         becomes a 4th pin with a net label (vdd / gnd).
  cell symbols (xschem/<cell>.sym)
      -> the <Symbol> of <cell>.sch; pin order = xschem's, parameters (wn, wp,
         ...) = the symbol template's.
  ipin / opin / iopin -> Port;  lab_pin / lab_wire -> net label;
  0 / gnd / GND labels, gnd.sym -> GND
  code_shown .param -> .PARAM;  .ic -> .IC;  B-sources -> SPICE generic device;
  .control ... .endc -> Nutmeg custom simulation (outputs = the 'write' vectors)
  vsource / isource / capa -> SPICE V / SPICE I / C
Dropped: the MODELS code blocks (every device includes gf180mcu_models.spice),
xschem launchers and graphs.
"""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PRJ = ROOT / 'qucs'
CELLS = ['inv', 'inv_cs', 'ota5', 'beta_mult', 'vref', 'ringosci']
QUCS_VERSION = '26.1.1'
MODELS = 'gf180mcu_models.spice'


# ------------------------------------------------------------ xschem parser --
def _brace(text, i):
    """text[i] == '{'; return (content, index after the closing brace)."""
    depth, j, out = 0, i, []
    while j < len(text):
        c = text[j]
        if c == '\\' and j + 1 < len(text):
            out.append(text[j + 1])
            j += 2
            continue
        if c == '{':
            depth += 1
            if depth > 1:
                out.append(c)
        elif c == '}':
            depth -= 1
            if depth == 0:
                return ''.join(out), j + 1
            out.append(c)
        else:
            out.append(c)
        j += 1
    raise ValueError('unbalanced brace')


def parse_xschem(path):
    """List of (kind, [tokens]); brace groups are single tokens."""
    text = Path(path).read_text()
    elems, i, n = [], 0, len(text)
    while i < n:
        while i < n and text[i] in ' \t\r\n':
            i += 1
        if i >= n:
            break
        kind, i = text[i], i + 1
        toks = []
        while i < n and text[i] != '\n':
            if text[i] in ' \t\r':
                i += 1
            elif text[i] == '{':
                tok, i = _brace(text, i)
                toks.append(tok)
            else:
                j = i
                while j < n and text[j] not in ' \t\r\n{':
                    j += 1
                toks.append(text[i:j])
                i = j
        elems.append((kind, toks))
    return elems


def parse_props(s):
    """xschem attribute string -> dict (quotes stripped, \\" unescaped)."""
    props, i, n = {}, 0, len(s)
    while i < n:
        while i < n and s[i] in ' \t\r\n':
            i += 1
        j = i
        while j < n and s[j] not in '= \t\r\n':
            j += 1
        key, i = s[i:j], j
        if not key:
            break
        if i < n and s[i] == '=':
            i += 1
            if i < n and s[i] == '"':
                i += 1
                val = []
                while i < n and s[i] != '"':
                    if s[i] == '\\' and i + 1 < n:
                        i += 1
                    val.append(s[i])
                    i += 1
                i += 1
                props[key] = ''.join(val)
            else:
                j = i
                while j < n and s[j] not in ' \t\r\n':
                    j += 1
                props[key] = s[i:j]
                i = j
        else:
            props[key] = ''
    return props


def num(s):
    v = float(s)
    return int(round(v))


# ---------------------------------------------------------------- geometry --
def xs_transform(px, py, x, y, rot, flip):
    """xschem symbol point -> schematic point."""
    if flip:
        px = -px
    for _ in range(rot % 4):
        px, py = -py, px
    return x + px, y + py


def qucs_orient(rot, flip):
    """xschem (rot, flip) -> Qucs (mirrorX, rotate).  xschem rotates
    clockwise on screen, Qucs counter-clockwise; xschem's flip (x -> -x) is
    Qucs' mirrorX (y -> -y) followed by a half turn."""
    k = (4 - rot % 4) % 4
    if flip:
        k = (k + 2) % 4
    return int(flip), k


# ------------------------------------------------------------ PDK devices --
# pins in xschem pinlist order = subckt order; (name, x, y) in symbol coords.
# The xschem MOS symbols are 3-pin (body is an attribute); the Qucs ones get a
# body pin on a short stub right of the channel.
MOS_N = [('D', 20, -30), ('G', -20, 0), ('S', 20, 30), ('B', 30, 0)]
MOS_P = [('D', 20, 30), ('G', -20, 0), ('S', 20, -30), ('B', 30, 0)]
RES = [('M', 0, 30), ('P', 0, -30), ('B', -20, 0)]
CAP = [('G', 0, -30), ('B', 0, 30)]

PDK = {
    'nfet3_06v0': dict(pins=MOS_N, kind='mos', sym='nfet_06v0'),
    'pfet3_06v0': dict(pins=MOS_P, kind='mos', sym='pfet_06v0'),
    'ppolyf_u_1k': dict(pins=RES, kind='res', sym='ppolyf_u_1k'),
    'nwell': dict(pins=RES, kind='res', sym='nwell'),
    'cap_mim_2f0fF': dict(pins=CAP, kind='cap', sym='cap_mim_2f0fF'),
}
MOS_KEYS = ['L', 'W', 'nf', 'ad', 'as', 'pd', 'ps', 'nrd', 'nrs', 'sa', 'sb', 'sd']


def device_params(kind, p):
    if kind == 'mos':
        s = ' '.join(f'{k}={p[k]}' for k in MOS_KEYS if k in p)
        if p.get('m', '1') != '1':
            s += f' m={p["m"]}'
        return s
    pre = 'r' if kind == 'res' else 'c'
    s = f'{pre}_width={p["W"]} {pre}_length={p["L"]}'
    if p.get('m', '1') != '1':
        s += f' m={p["m"]}'
    return s


def pdk_symbol_dir():
    import os
    roots = [os.environ.get('PDK_ROOT', ''), '/foss/pdks',
             str(Path.home() / '.volare'), str(Path.home() / '.ciel')]
    for r in roots:
        d = Path(r) / 'gf180mcuD' / 'libs.tech' / 'xschem' / 'symbols'
        if r and d.is_dir():
            return d
    sys.exit('gf180mcuD xschem symbols not found; set PDK_ROOT')


def qucs_line(x1, y1, x2, y2, color='#000080', w=2):
    return f'  <Line {num(x1)} {num(y1)} {num(x2) - num(x1)} {num(y2) - num(y1)} {color} {w} 1>'


def write_device_symbol(name, info, out):
    """Qucs .sym for a GF180 device, drawn from the PDK xschem symbol."""
    lines = []
    for kind, toks in parse_xschem(pdk_symbol_dir() / f'{info["sym"]}.sym'):
        if kind == 'L' and toks[0] == '4':
            lines.append(qucs_line(*map(float, toks[1:5])))
        elif kind == 'P' and toks[0] in '45':
            pts = list(map(float, toks[2:2 + 2 * int(toks[1])]))
            for k in range(0, len(pts) - 2, 2):
                lines.append(qucs_line(*pts[k:k + 4]))
        elif kind == 'A' and toks[0] == '4':
            cx, cy, r = map(float, toks[1:4])
            lines.append(f'  <Ellipse {num(cx - r)} {num(cy - r)} {num(2 * r)} {num(2 * r)} '
                         '#000080 2 1 #c0c0c0 1 0>')
    for k, (pn, px, py) in enumerate(info['pins'], 1):
        if info['kind'] == 'mos' and pn == 'B':
            lines.append(qucs_line(20, 0, 30, 0))
        lines.append(f'  <.PortSym {px} {py} {k} 0>')
        tx = px + 3 if px >= 0 else px - 10
        lines.append(f'  <Text {tx} {py - 13} 7 #808080 0 "{pn}">')
    out.write_text(f'<Qucs Symbol {QUCS_VERSION}>\n<Symbol>\n' + '\n'.join(lines) + '\n</Symbol>\n')


# ----------------------------------------------------------- cell symbols --
class CellSym:
    """xschem cell symbol: pin order, template params, drawing."""

    def __init__(self, name):
        self.name = name
        self.pins, self.params, self.draw = [], [], []
        for kind, toks in parse_xschem(ROOT / 'xschem' / f'{name}.sym'):
            if kind == 'K':
                p = parse_props(toks[0])
                tmpl = parse_props(p.get('template', ''))
                self.params = [(k, v) for k, v in tmpl.items() if k != 'name']
            elif kind == 'B' and toks[0] == '5':
                x1, y1, x2, y2 = map(float, toks[1:5])
                pn = parse_props(toks[5])['name']
                self.pins.append((pn, num((x1 + x2) / 2), num((y1 + y2) / 2)))
            elif kind == 'L':
                self.draw.append(qucs_line(*map(float, toks[1:5])))
            elif kind == 'P':
                pts = list(map(float, toks[2:2 + 2 * int(toks[1])]))
                for k in range(0, len(pts) - 2, 2):
                    self.draw.append(qucs_line(*pts[k:k + 4]))
            elif kind == 'T':
                txt = toks[0]
                if txt == '@name':
                    continue
                txt = txt.replace('@symname', name)
                x, y, flip, sz = float(toks[1]), float(toks[2]), int(toks[4]), float(toks[5])
                size = 7 if sz < 0.25 else 10
                if flip:        # right-aligned in xschem
                    x -= len(txt) * size * 0.6
                self.draw.append(f'  <Text {num(x)} {num(y)} {size} #000000 0 "{txt}">')

    def symbol_block(self):
        out = ['<Symbol>'] + self.draw
        for k, (pn, px, py) in enumerate(self.pins, 1):
            out.append(f'  <.PortSym {px} {py} {k} 0>')
        ys = [py for _, _, py in self.pins]
        idp = ' '.join(f'"1={k}={v}=="' for k, v in self.params)
        out.append(f'  <.ID -130 {max(ys) + 30} X{(" " + idp) if idp else ""}>')
        out.append('</Symbol>')
        return out

    def pin_xy(self, x, y, rot, flip):
        return [(pn, *xs_transform(px, py, x, y, rot, flip)) for pn, px, py in self.pins]


# --------------------------------------------------------------- converter --
GROUND = {'0', 'gnd', 'GND'}


def q(s):
    """Qucs property string: double quotes are the delimiter, newlines -> \\n."""
    return s.replace('"', "'").replace('\n', '\\n')


class Sheet:
    def __init__(self, name):
        self.name = name
        self.comps, self.labels, self.wires, self.paint = [], [], [], []
        self.points = []            # connection points, for wire splitting
        self.bbox = [10**9, 10**9, -10**9, -10**9]
        self.n = 0

    def grow(self, x, y):
        b = self.bbox
        b[0], b[1], b[2], b[3] = min(b[0], x), min(b[1], y), max(b[2], x), max(b[3], y)

    def uid(self, pre):
        self.n += 1
        return f'{pre}{self.n}'

    def label(self, x, y, net):
        self.points.append((x, y))
        self.grow(x, y)
        if net in GROUND:
            self.comps.append(f'  <GND * 1 {x} {y} 0 0 0 0>')
        else:
            self.labels.append(f'  <{x} {y} {x} {y} "{net}" {x + 10} {y - 20} 0 "">')

    def wire(self, x1, y1, x2, y2):
        self.wires.append((x1, y1, x2, y2))
        self.points += [(x1, y1), (x2, y2)]
        self.grow(x1, y1)
        self.grow(x2, y2)

    def text(self, txt, x, y, size=10):
        self.grow(x, y)
        self.paint.append(f'  <Text {x} {y} {size} #000000 0 "{q(txt)}">')

    def split_wires(self):
        """xschem joins a wire end or pin landing mid-wire; Qucs only joins
        at end points, so cut wires at every such point."""
        pts = set(self.points)
        out = []
        for x1, y1, x2, y2 in self.wires:
            cuts = [(x1, y1), (x2, y2)]
            for px, py in pts:
                if (px, py) in cuts[:2]:
                    continue
                if x1 == x2 == px and min(y1, y2) < py < max(y1, y2):
                    cuts.append((px, py))
                elif y1 == y2 == py and min(x1, x2) < px < max(x1, x2):
                    cuts.append((px, py))
            cuts.sort(key=lambda p: (p[0] - x1) ** 2 + (p[1] - y1) ** 2)
            out += [(*cuts[k], *cuts[k + 1]) for k in range(len(cuts) - 1)]
        return out

    def write(self, path, symbol=None, dataset=True):
        b = self.bbox
        view = f'{b[0] - 100},{b[1] - 100},{b[2] + 200},{b[3] + 100},1,0,0'
        nm = self.name
        out = [f'<Qucs Schematic {QUCS_VERSION}>', '<Properties>',
               f'  <View={view}>', '  <Grid=10,10,1>',
               f'  <DataSet={nm}.dat>', f'  <DataDisplay={nm}.dpl>',
               '  <OpenDisplay=0>', f'  <Script={nm}.m>', '  <RunScript=0>',
               '  <showFrame=0>', '  <FrameText0=Title>', '  <FrameText1=Drawn By:>',
               '  <FrameText2=Date:>', '  <FrameText3=Revision:>', '</Properties>']
        out += symbol or ['<Symbol>', '</Symbol>']
        out += ['<Components>'] + self.comps + ['</Components>']
        out += ['<Wires>']
        out += [f'  <{a} {b_} {c} {d} "" 0 0 0 "">' for a, b_, c, d in self.split_wires()]
        out += self.labels + ['</Wires>', '<Diagrams>', '</Diagrams>']
        out += ['<Paintings>'] + self.paint + ['</Paintings>']
        path.write_text('\n'.join(out) + '\n')


def convert(src, name, cellsyms, cell=None):
    sh = Sheet(name)
    pin_order = [pn for pn, _, _ in cell.pins] if cell else []
    for kind, toks in parse_xschem(src):
        if kind == 'N':
            x1, y1, x2, y2 = map(num, toks[:4])
            sh.wire(x1, y1, x2, y2)
        elif kind == 'T':
            sh.text(toks[0], num(toks[1]), num(toks[2]), 10 if float(toks[5]) >= 0.25 else 8)
        elif kind == 'C':
            convert_instance(sh, toks, cellsyms, pin_order)
    return sh


def convert_instance(sh, toks, cellsyms, pin_order):
    sym = toks[0]
    x, y, rot, flip = num(toks[1]), num(toks[2]), int(toks[3]), int(toks[4])
    p = parse_props(toks[5])
    base = sym.split('/')[-1][:-4]
    mir, qrot = qucs_orient(rot, flip)
    sh.grow(x, y)

    if base in PDK:
        info = PDK[base]
        name = p['name']
        pins = [(pn, *xs_transform(px, py, x, y, rot, flip)) for pn, px, py in info['pins']]
        for pn, px, py in pins:
            sh.points.append((px, py))
        if info['kind'] == 'mos':
            body = p.get('body', 'GND')
            _, bx, by = pins[3]
            sh.label(bx, by, 'gnd' if body.upper() == 'GND' else body.lower())
        params = device_params(info['kind'], p)
        gate_left = (qrot in (0,) and not mir) or (mir and qrot == 2)
        tx, ty = (35, -30) if gate_left else (-110, -30)
        show = 0 if info['kind'] == 'mos' else 1
        sh.comps.append(
            f'  <SpLib {name} 1 {x} {y} {tx} {ty} {mir} {qrot} "{MODELS}" 0 '
            f'"{p["model"]}" 1 "symbols/{base}.sym" 0 "{q(params)}" {show} "" 0>')
        if info['kind'] == 'mos':   # size note, like xschem's '@W / @L'
            sh.paint.append(f'  <Text {x + tx} {y + 20} 8 #606060 0 '
                            f'"{p["W"]} / {p["L"]}">')
    elif base in cellsyms:
        cs = cellsyms[base]
        for _, px, py in cs.pin_xy(x, y, rot, flip):
            sh.points.append((px, py))
            sh.grow(px, py)
        vals = ' '.join(f'"{p.get(k, v)}" 1' for k, v in cs.params)
        sh.comps.append(f'  <Sub {p["name"]} 1 {x} {y} -40 60 {mir} {qrot} "{base}.sch" 0'
                        f'{(" " + vals) if vals else ""}>')
    elif base in ('lab_pin', 'lab_wire'):
        sh.label(x, y, p['lab'])
    elif base in ('ipin', 'opin', 'iopin'):
        net = p['lab']
        k = pin_order.index(net) + 1
        sh.comps.append(f'  <Port P{k} 1 {x} {y} -23 12 {mir} {qrot} "{k}" 1 "analog" 0>')
        sh.label(x, y, net)
    elif base == 'gnd':
        sh.label(x, y, '0')
    elif base in ('vsource', 'isource'):
        letter = 'V' if base == 'vsource' else 'I'
        typ = 'S4Q_V' if letter == 'V' else 'S4Q_I'
        # S4Q sources are drawn vertically (+ on top) at Qucs rotate=1
        sh.comps.append(f'  <{typ} {p["name"]} 1 {x} {y} 18 -26 {mir} {(qrot + 1) % 4} '
                        f'"{q(p.get("value", ""))}" 1 "" 0 "" 0 "" 0 "" 0>')
        sh.points += [(x, y - 30), (x, y + 30)]
    elif base == 'capa':
        sh.comps.append(f'  <C {p["name"]} 1 {x} {y} 17 -26 {mir} {(qrot + 1) % 4} '
                        f'"{p.get("value", "")}" 1 "" 0 "neutral" 0>')
        sh.points += [(x, y - 30), (x, y + 30)]
    elif base == 'code_shown':
        convert_code(sh, p, x, y)
    elif base == 'launcher':
        pass
    else:
        sys.exit(f'{sh.name}: no mapping for symbol {sym}')


def convert_code(sh, p, x, y):
    val = p.get('value', '')
    if '180MCU_MODELS' in val:      # model includes: devices carry their own
        return
    ctl = re.search(r'^\.control\s*\n(.*?)^\.endc', val, re.S | re.M | re.I)
    netl = re.sub(r'^\.control.*?^\.endc\s*', '', val, flags=re.S | re.M | re.I)
    params, ics = [], []
    for ln in netl.splitlines():
        ln = ln.strip()
        if not ln or ln.startswith('*'):
            continue
        low = ln.lower()
        if low.startswith('.param'):
            params += ln.split()[1:]
        elif low.startswith('.ic'):
            ics += re.findall(r'v\([^)]*\)\s*=\s*\S+', ln, re.I)
        elif low[0] == 'b':         # B n1 n2 I=...  (two-pin behavioural source)
            nm, n1, n2, rest = ln.split(None, 3)
            yy = y + 80 * (1 + sum(c.startswith('  <SPICE_dev') for c in sh.comps))
            sh.comps.append(f'  <SPICE_dev {nm[1:]} 1 {x + 40} {yy} -26 -60 0 0 '
                            f'"2" 0 "B" 0 "" 0 "{q(rest)}" 1>')
            sh.label(x, yy, n1)
            sh.label(x + 80, yy, n2)
        else:
            sys.exit(f'{sh.name}: unhandled netlist line in code block: {ln}')
    if params:
        vals = ' '.join(f'"{prm}" 1' for prm in params)
        sh.comps.append(f'  <SpicePar SpicePar1 1 {x + 40} {y} -28 16 0 0 {vals}>')
    if ics:
        vals = ' '.join(f'"{ic.replace(" ", "")}" 1' for ic in ics)
        sh.comps.append(f'  <SpiceIC SpiceIC1 1 {x + 40} {y - 60} -9 17 0 0 {vals}>')
    if ctl:
        body = ctl.group(1)
        outs = []
        for m in re.finditer(r'^\s*write\s+\S+\s+(.*)$', body, re.M | re.I):
            outs += m.group(1).split()
        sh.comps.append(f'  <.CUSTOMSIM CUSTOM1 1 {x + 40} {y + 20} 0 40 0 0 '
                        f'"\\n{q(body)}" 1 "{";".join(outs)}" 0 "" 0>')
    sh.grow(x + 400, y + 300)


def main():
    PRJ.mkdir(parents=True, exist_ok=True)
    (PRJ / 'symbols').mkdir(exist_ok=True)
    for base, info in PDK.items():
        write_device_symbol(base, info, PRJ / 'symbols' / f'{base}.sym')
    (PRJ / MODELS).write_text(
        '* GF180MCU-D models for the Qucs-S schematics.  Every GF180 device\n'
        '* (SpLib) includes this file; swap the corner sections to switch.\n'
        '.include ~/.volare/gf180mcuD/libs.tech/ngspice/design.ngspice\n'
        '.lib ~/.volare/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical\n'
        '.lib ~/.volare/gf180mcuD/libs.tech/ngspice/sm141064.ngspice res_typical\n'
        '.lib ~/.volare/gf180mcuD/libs.tech/ngspice/sm141064.ngspice mimcap_typical\n'
        '.lib ~/.volare/gf180mcuD/libs.tech/ngspice/sm141064.ngspice cap_mim\n')

    cellsyms = {c: CellSym(c) for c in CELLS}
    for c in CELLS:
        sh = convert(ROOT / 'xschem' / f'{c}.sch', c, cellsyms, cellsyms[c])
        sh.write(PRJ / f'{c}.sch', symbol=cellsyms[c].symbol_block())
    for tb in sorted((ROOT / 'sims' / 'tb').glob('tb_*.sch')):
        sh = convert(tb, tb.stem, cellsyms)
        sh.write(PRJ / tb.name)
    print(f'wrote {PRJ.relative_to(ROOT)}/')


if __name__ == '__main__':
    main()
