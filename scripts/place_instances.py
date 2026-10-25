# Create a GF180 layout cell with every instance its schematic asks for,
# unrouted. Adapted from rcyaon/bidir-level-shifter layout/place_instances.py
# (IHP SG13) for the gf180mcuD KLayout PCells.
#
# Reads a Qucs-S ngspice netlist (qucs-s -n --ngspice -i X.sch -o X.cir) and
# writes <out> (default Layout/<cell>.gds). The cell gets:
#   - one gf180mcu PCell per device: nfet/pfet (3.3, 5 and 6 V), nfet_06v0_nvt,
#     cap_mim and the poly resistors. m=N gives N separate devices, nf=N
#     gives one PCell with N fingers of W/N each.
#   - a bulk tie on every MOSFET (the PCell's "Bulk Tie" option).
#   - one instance per subcircuit, read from <libdir>/<child>.gds. Only the
#     cell's own devices are placed, not the ones inside its children, so
#     build children first (scripts/place_layout.sh does this in order).
#
# The cell is either a .SUBCKT in the netlist, or (if no .SUBCKT has that
# name) the netlist's top level, which is what Qucs-S writes for the
# schematic it was given.
#
# Run inside the IIC-OSIC-TOOLS container with the GF180 KLayout tech loaded:
#   USER=designer KLAYOUT_PATH=$PDK_ROOT/gf180mcuD/libs.tech/klayout \
#     klayout -zz -r scripts/place_instances.py \
#       -rd netlist=ldo.cir -rd cell=LDOMkI -rd libdir=Layout
# Easier: scripts/place_layout.sh, which netlists the schematic for you.
# An existing output .gds is replaced.

import os
import re
import sys
import pya

LIB = "gf180mcu"
TEXT_LAYER = (255, 0)      # not a GF180 layer: instance names only, ignored by
                           # DRC/LVS; delete it before tapeout
GAP = 2.0                  # um between placed instances
VOLT = {"03v3": "3.3V", "05v0": "5V", "06v0": "6V"}
L_MIN = {("n", "3.3V"): 0.28, ("p", "3.3V"): 0.28, ("n", "5V"): 0.6,
         ("p", "5V"): 0.5, ("n", "6V"): 0.7, ("p", "6V"): 0.55}
W_MIN_BULK_TIE = 0.42      # fet_w_con_bulk in the PCell code, per finger
MIM = {"mim_option": "MIM-B", "metal_level": "M5"}   # MIM between Metal4 and Metal5
RESISTORS = {              # netlist model -> (PCell, voltage area)
    "ppolyf_u_1k": ("ppolyf_u_high_Rs_resistor", "3.3V"),
    "ppolyf_u_1k_6p0": ("ppolyf_u_high_Rs_resistor", "5/6V"),
    "ppolyf_u": ("ppolyf_u_resistor", "3.3V"),
    "ppolyf_s": ("ppolyf_s_resistor", "3.3V"),
    "npolyf_u": ("npolyf_u_resistor", "3.3V"),
    "npolyf_s": ("npolyf_s_resistor", "3.3V"),
}
UNITS = {"f": 1e-15, "p": 1e-12, "n": 1e-9, "u": 1e-6, "m": 1e-3, "k": 1e3,
         "meg": 1e6, "g": 1e9}


def fail(msg):
    # klayout -r swallows the message of sys.exit(msg); print it ourselves.
    print(f"place_instances: {msg}", file=sys.stderr)
    sys.exit(1)


def um(value):
    """SPICE number ('10u', '0.5e-6', '80') in um."""
    m = re.fullmatch(r"([-+0-9.eE]+)(meg|[fpnumkg])?", value.strip().lower())
    if not m:
        fail(f"cannot read number {value!r}")
    return float(m.group(1)) * UNITS.get(m.group(2), 1.0) * 1e6


def split_line(line):
    """Split a netlist line on spaces, keeping quoted expressions whole."""
    return re.findall(r"(?:[^\s']|'[^']*')+", line)


def read_netlist(path):
    """Return ({SUBCKT: [element words]}, [top-level element words])."""
    text = open(path).read().replace("\n+", " ")
    subckts, top, current, control = {}, [], None, False
    for line in text.splitlines():
        words = split_line(line)
        if not words or line.startswith("*"):
            continue
        key = words[0].lower()
        if key == ".control":
            control = True
        elif key == ".endc":
            control = False
        elif control:
            continue
        elif key == ".subckt":
            current = words[1]
            subckts[current.upper()] = []
        elif key == ".ends":
            current = None
        elif key.startswith("."):
            continue
        elif current:
            subckts[current.upper()].append(words)
        else:
            top.append(words)
    return subckts, top


def gf180():
    lib = pya.Library.library_by_name(LIB)
    if lib is None:
        fail(f"PCell library {LIB} not loaded: set KLAYOUT_PATH to "
             f"$PDK_ROOT/gf180mcuD/libs.tech/klayout and USER to any name "
             f"(gdsfactory needs it; see scripts/place_layout.sh)")
    return lib


def is_empty(path):
    ly = pya.Layout()
    ly.read(path)
    return all(c.is_empty() for c in ly.each_cell())


def load_child(layout, name, libdir, warnings):
    """Return the cell index of child `name`, reading <libdir>/<name>.gds."""
    cell = layout.cell(name)
    if cell:
        return cell.cell_index()
    path = os.path.join(libdir, name + ".gds")
    if os.path.isfile(path) and not is_empty(path):
        opt = pya.LoadLayoutOptions()
        # Children share grandchildren and PCell variants; keep the first copy.
        opt.cell_conflict_resolution = pya.LoadLayoutOptions.SkipNewCell
        layout.read(path, opt)
        if layout.cell(name) is None:
            fail(f"{path} has no cell named {name}")
        return layout.cell(name).cell_index()
    # No layout yet: an empty, labelled stand-in keeps the floorplan honest.
    warnings.append(f"{name}.gds missing or empty: placed an empty stand-in; "
                    f"lay out {name} and rerun")
    cell = layout.create_cell(name)
    text = layout.layer(*TEXT_LAYER)
    cell.shapes(text).insert(pya.DBox(0, 0, 10, 10))
    cell.shapes(text).insert(pya.DText(name, 0.5, 0.5))
    return cell.cell_index()


def params_of(words):
    return {k.lower(): v for k, v in (w.split("=", 1) for w in words if "=" in w)}


def device(layout, lib, inst, words, warnings):
    """Return (row, pcell variant, count) for one device line, or None."""
    nets = [w for w in words[1:] if "=" not in w]
    model = nets[-1].lower()
    p = params_of(words)
    m = int(float(p.get("m", "1")))
    pid = lib.layout().pcell_id

    mos = re.fullmatch(r"([np])fet_(03v3|05v0|06v0)(_nvt)?", model)
    if mos:
        kind, volt = mos.group(1), VOLT[mos.group(2)]
        nf = int(float(p.get("nf", "1")))
        w, l = um(p["w"]) / nf, um(p["l"])
        if l < L_MIN[(kind, volt)] - 1e-9:
            warnings.append(f"{inst}: L={l:g}u is below the {model} minimum "
                            f"{L_MIN[(kind, volt)]:g}u: drawn as is, fails DRC")
        if w < W_MIN_BULK_TIE - 1e-9:
            warnings.append(f"{inst}: W/nf={w:g}u is below {W_MIN_BULK_TIE}u, "
                            f"the bulk-tie minimum: drawn as is, fails DRC")
        name = "nfet_06v0_nvt" if mos.group(3) else kind + "fet"
        var = layout.add_pcell_variant(lib, pid(name), {
            "w_gate": w, "l_gate": l, "nf": nf, "volt": volt,
            "bulk": "Bulk Tie"})
        return kind, var, m

    if model.startswith("cap_mim"):
        var = layout.add_pcell_variant(lib, pid("cap_mim"), dict(
            MIM, wc=um(p["c_width"]), lc=um(p["c_length"])))
        return "c", var, m

    if model in RESISTORS:
        pcell, volt = RESISTORS[model]
        var = layout.add_pcell_variant(lib, pid(pcell), {
            "w_res": um(p["r_width"]), "l_res": um(p["r_length"]),
            "volt": volt})
        return "c", var, m

    warnings.append(f"{inst}: no PCell for model {model}; skipped")
    return None


def main():
    netlist = globals().get("netlist")
    name = globals().get("cell")
    if not netlist or not name:
        fail("usage: klayout -zz -r place_instances.py -rd netlist=<X.cir> "
             "-rd cell=<CELL> [-rd libdir=<dir>] [-rd out=<X.gds>]")
    libdir = globals().get("libdir") or os.path.dirname(os.path.abspath(netlist))
    out = globals().get("out") or os.path.join(libdir, name + ".gds")

    subckts, top_level = read_netlist(netlist)
    elements = subckts.get(name.upper(), top_level)
    if not elements:
        fail(f"no devices for {name} in {netlist}")
    # Subcircuit names as written in the netlist, for the child .gds names.
    real_names = {n.upper(): n for n in re.findall(
        r"(?im)^\.subckt\s+(\S+)", open(netlist).read())}

    layout = pya.Layout()
    layout.dbu = 0.001
    top = layout.create_cell(name)
    text = layout.layer(*TEXT_LAYER)
    lib = gf180()

    # Rows, bottom to top: passives, NMOS, PMOS, child cells.
    rows = {"c": [], "n": [], "p": [], "x": []}
    warnings = []
    for words in elements:
        inst = words[0]
        nets = [w for w in words[1:] if "=" not in w]
        child = real_names.get(nets[-1].upper()) if nets else None
        if inst[0].upper() == "X" and child:
            rows["x"].append((inst, load_child(layout, child, libdir, warnings)))
        elif inst[0].upper() == "X":
            placed = device(layout, lib, inst, words, warnings)
            if placed:
                row, var, m = placed
                for i in range(m):
                    rows[row].append((inst if m == 1 else f"{inst}.{i + 1}", var))
        else:
            warnings.append(f"{inst}: {' '.join(words)} has no layout device; "
                            f"skipped")

    y = 0.0
    for row in ("c", "n", "p", "x"):
        x, height = 0.0, 0.0
        for inst, ci in rows[row]:
            box = layout.cell(ci).dbbox()
            trans = pya.DCplxTrans(x - box.left, y - box.bottom)
            top.insert(pya.DCellInstArray(ci, trans))
            top.shapes(text).insert(pya.DText(inst, x, y + box.height() + 0.2))
            x += box.width() + GAP
            height = max(height, box.height())
        if rows[row]:
            y += height + 2 * GAP

    os.makedirs(os.path.dirname(os.path.abspath(out)), exist_ok=True)
    layout.write(out)
    print(f"place_instances: wrote {out}: {len(rows['p'])} PMOS, "
          f"{len(rows['n'])} NMOS, {len(rows['c'])} passives, "
          f"{len(rows['x'])} subcells")
    for w in warnings:
        print(f"place_instances: warning: {w}")


main()
