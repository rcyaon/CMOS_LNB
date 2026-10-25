# Placed and routed layout of Schematic/Error Amplifier/ErrorAmplifierNMOSMkI.sch
# (5-transistor OTA, all 6 V devices, W=10u L=4u).
#
#   X1, X2  PMOS mirror load   one 2-finger pfet, VDD on the shared middle strip
#   X5, X3  NMOS input pair    one 2-finger nfet, tail on the shared middle strip
#   X4      NMOS tail          below the pair, drain lined up with the tail strip
#
# Floorplan, bottom to top: X4, input pair (both in one P+ substrate ring tied
# to VSS), then the mirror in an N-well with an N+ ring tied to VDD. Metal1
# stays inside the rings; everything that leaves a ring goes on Metal2.
#
# Pins (Metal2 labels unless noted): Input (left), TBias (left), Com (right),
# Output (right), VDD (N+ ring, Metal1), VSS (P+ ring, Metal1). The schematic
# has no VSS port: its ground is the global node 0 / substrate.
#
# The bulk-tie and guard-ring options of the gf180mcu fet PCell are not used:
# Bulk Tie butts the tap against a source, which would short the input pair's
# tail to ground, and Guard Ring draws a solid diffusion block in this PDK.
#
# Run inside the IIC-OSIC-TOOLS container:
#   USER=designer KLAYOUT_PATH=$PDK_ROOT/gf180mcuD/libs.tech/klayout \
#     klayout -zz -r scripts/layout_ErrorAmplifierNMOSMkI.py -rd out=Layout/ErrorAmplifierNMOSMkI.gds
# scripts/place_layout.sh runs this instead of place_instances.py for this cell.

import math
import os
import sys
import pya

CELL = "ErrorAmplifierNMOSMkI"
DBU = 0.001

L = {  # GF180MCU layers
    "comp": (22, 0), "nwell": (21, 0), "dualgate": (55, 0), "poly": (30, 0),
    "nplus": (32, 0), "pplus": (31, 0), "cont": (33, 0),
    "m1": (34, 0), "via1": (35, 0), "m2": (36, 0),
    "m1_lbl": (34, 10), "m2_lbl": (36, 10),
}

CONT, CONT_SP = 0.22, 0.28        # contact size, spacing used on rings
VIA, VIA_SP = 0.26, 0.26
RING_W = 0.46                     # tap ring COMP / Metal1 width
IMP_ENC = 0.16                    # implant enclosure of tap COMP
NW_ENC = 0.40                     # N-well enclosure of the N+ ring
WIRE = 0.38                       # Metal2 wire width

FET = {"w_gate": 10.0, "l_gate": 4.0, "volt": "6V", "bulk": "None"}

# Device origins (PCell local coordinates are listed in the comments).
# 2-finger fets: S/D strips at x = -0.42..-0.04, 4.38..4.76, 9.18..9.56
# (nfet -0.40.., 9.16..9.54); COMP y = 0..10; gate pads 0.38 tall, 0.30 off COMP.
X_PAIR, Y_PAIR = 0.0, 12.0
X_TAIL, Y_TAIL = -0.26, 0.0       # puts the tail's right strip under the tail strip
X_MIRR, Y_MIRR = 0.02, 28.5       # puts the mirror's outer strips over the pair's

# Ring inner edges (COMP), x0, y0, x1, y1.
P_RING = (-2.0, -2.0, 10.9, 23.6)     # P+ ring around X4 and the pair
N_RING = (-2.0, 26.92, 10.9, 40.4)    # N+ ring around the mirror
EDGE_L, EDGE_R = -3.6, 12.6           # where pins are labelled


GRID = 0.005                      # manufacturing grid


def snap(v, grid=GRID):
    return round(round(v / grid) * grid, 4)


def fail(msg):
    print(f"layout: {msg}", file=sys.stderr)
    sys.exit(1)


class Cell:
    def __init__(self):
        self.ly = pya.Layout()
        self.ly.dbu = DBU
        self.top = self.ly.create_cell(CELL)
        self.lib = pya.Library.library_by_name("gf180mcu")
        if self.lib is None:
            fail("gf180mcu PCells not loaded: set KLAYOUT_PATH to "
                 "$PDK_ROOT/gf180mcuD/libs.tech/klayout and USER to any name")

    def li(self, name):
        return self.ly.layer(*L[name])

    def box(self, layer, x0, y0, x1, y1):
        self.top.shapes(self.li(layer)).insert(pya.DBox(x0, y0, x1, y1))

    def region(self, layer, reg):
        self.top.shapes(self.li(layer)).insert(reg)

    def label(self, layer, text, x, y):
        self.top.shapes(self.li(layer)).insert(pya.DText(text, x, y))

    def fet(self, kind, x, y, **params):
        pid = self.lib.layout().pcell_id(kind)
        var = self.ly.add_pcell_variant(self.lib, pid, dict(FET, **params))
        self.top.insert(pya.DCellInstArray(var, pya.DTrans(x, y)))

    # Wiring helpers ---------------------------------------------------------

    def vias(self, x0, y0, x1, y1):
        """Fill the box with as many Via1 cuts as fit, centred."""
        def positions(a, b):
            n = max(1, int((b - a + VIA_SP) // (VIA + VIA_SP)))
            span = n * VIA + (n - 1) * VIA_SP
            start = snap((a + b - span) / 2)
            return [start + i * (VIA + VIA_SP) for i in range(n)]
        for vx in positions(x0, x1):
            for vy in positions(y0, y1):
                self.box("via1", vx, vy, vx + VIA, vy + VIA)

    def via_stack(self, x0, y0, x1, y1):
        """Via1 array with Metal1 and Metal2 landing on the same box."""
        self.box("m1", x0, y0, x1, y1)
        self.box("m2", x0, y0, x1, y1)
        self.vias(x0, y0, x1, y1)

    def ring(self, inner, tap, label=None):
        """Tap ring of width RING_W outside `inner`; tap = 'pplus' or 'nplus'."""
        x0, y0, x1, y1 = inner
        w = RING_W
        def dbox(a, b, c, d):
            return pya.Region(pya.DBox(a, b, c, d).to_itype(DBU))
        outer = (x0 - w, y0 - w, x1 + w, y1 + w)
        ring = dbox(*outer) - dbox(x0, y0, x1, y1)
        self.region("comp", ring)
        self.region("m1", ring)
        grow = int(round(IMP_ENC / DBU))
        imp = dbox(*outer).sized(grow) - dbox(x0, y0, x1, y1).sized(-grow)
        self.region(tap, imp)
        # Contacts along the ring's centre line, corners included.
        c = w / 2
        cx0, cy0, cx1, cy1 = x0 - c, y0 - c, x1 + c, y1 + c
        pitch = CONT + CONT_SP
        pts = set()
        for a, b, fixed, horiz in ((cx0, cx1, cy0, True), (cx0, cx1, cy1, True),
                                   (cy0, cy1, cx0, False), (cy0, cy1, cx1, False)):
            n = int((b - a) // pitch)
            step = (b - a) / n
            for i in range(n + 1):
                t = snap(a + i * step, 2 * GRID)
                f = snap(fixed, 2 * GRID)
                pts.add((t, f) if horiz else (f, t))
        h = CONT / 2
        for px, py in pts:
            self.box("cont", px - h, py - h, px + h, py + h)
        if label:
            self.label("m1_lbl", label, x0 - c, (y0 + y1) / 2)
        return outer


def build():
    c = Cell()

    # Devices ---------------------------------------------------------------
    c.fet("nfet", X_TAIL, Y_TAIL, nf=1, gate_con_pos="bottom")      # X4
    c.fet("nfet", X_PAIR, Y_PAIR, nf=2, gate_con_pos="bottom")      # X5 | X3
    c.fet("pfet", X_MIRR, Y_MIRR, nf=2, gate_con_pos="top")         # X1 | X2

    # Absolute strip and pad positions.
    def nstrip(x, i):  # 2-finger nfet strips
        return [(-0.40, -0.02), (4.38, 4.76), (9.16, 9.54)][i][0] + x, \
               [(-0.40, -0.02), (4.38, 4.76), (9.16, 9.54)][i][1] + x
    def pstrip(x, i):
        return [(-0.42, -0.04), (4.38, 4.76), (9.18, 9.56)][i][0] + x, \
               [(-0.42, -0.04), (4.38, 4.76), (9.18, 9.56)][i][1] + x

    pair_bot, pair_top = Y_PAIR + 0.22, Y_PAIR + 9.78     # strip ends
    mirr_bot, mirr_top = Y_MIRR + 0.22, Y_MIRR + 9.78
    tail_top = Y_TAIL + 9.78
    pad_pair = (Y_PAIR - 0.67, Y_PAIR - 0.29)             # bottom gate pads
    pad_tail = (Y_TAIL - 0.67, Y_TAIL - 0.29)
    pad_mirr = (Y_MIRR + 10.30, Y_MIRR + 10.68)           # top gate pads

    # Tap rings -------------------------------------------------------------
    p_out = c.ring(P_RING, "pplus", label="VSS")
    n_out = c.ring(N_RING, "nplus", label="VDD")
    c.box("nwell", n_out[0] - NW_ENC, n_out[1] - NW_ENC,
          n_out[2] + NW_ENC, n_out[3] + NW_ENC)
    c.box("dualgate", EDGE_L + 0.1, p_out[1] - 1.0, EDGE_R - 0.1,
          n_out[3] + NW_ENC + 1.0)

    # Tail X4: drain (right strip) up to the pair's middle strip = tail node.
    tx0, tx1 = X_TAIL + 4.64, X_TAIL + 5.02
    c.box("m1", tx0, tail_top - 1.0, tx1, pair_bot + 1.0)
    # X4 source (left strip) to the P+ ring = VSS.
    sx0, sx1 = X_TAIL - 0.40, X_TAIL - 0.02
    for y in (1.5, 4.75, 8.0):
        c.box("m1", P_RING[0] - 0.1, y, sx1, y + 0.5)

    # Mirror: both gates and the left drain (X1, diode) tied on Metal1.
    l0, l1 = pstrip(X_MIRR, 0)
    r0, r1 = pstrip(X_MIRR, 2)
    c.box("m1", l0, pad_mirr[0], X_MIRR + 8.57, pad_mirr[1])
    c.box("m1", l0, mirr_top - 0.5, l1, pad_mirr[1])

    # Mirror middle strip = VDD, up to the N+ ring on Metal2.
    m0, m1_ = pstrip(X_MIRR, 1)
    c.via_stack(m0, mirr_bot + 4.0, m1_, mirr_top)
    c.box("m2", m0, mirr_bot + 4.0, m1_, N_RING[3] + RING_W)
    c.vias(m0 - 0.0, N_RING[3], m1_, N_RING[3] + RING_W)

    # Drains on Metal2: left column = X1/X5 drains (mirror node),
    # right column = X2/X3 drains (Output).
    for col in (0, 2):
        p0, p1 = pstrip(X_MIRR, col)
        n0, n1 = nstrip(X_PAIR, col)
        c.via_stack(p0, mirr_bot, p1, mirr_bot + 5.0)
        c.via_stack(n0, pair_top - 5.0, n0 + (n1 - n0), pair_top)
        x0, x1 = min(p0, n0), max(p1, n1)
        c.box("m2", x0, pair_top - 5.0, x1, mirr_bot + 5.0)

    # Output: right column out to the right edge.
    n0, n1 = nstrip(X_PAIR, 2)
    y_out = (P_RING[3] + RING_W + N_RING[1] - RING_W) / 2
    c.box("m2", n0, y_out - WIRE / 2, EDGE_R, y_out + WIRE / 2)
    c.label("m2_lbl", "Output", EDGE_R - 0.2, y_out)

    # Gate pins on Metal2 from the bottom gate pads.
    pin_y = (pad_pair[0] + pad_pair[1]) / 2
    # Left finger (between the mirror-node and tail strips) = X5 = Input.
    c.via_stack(X_PAIR + 0.59, pad_pair[0], X_PAIR + 4.03, pad_pair[1])
    c.box("m2", EDGE_L, pad_pair[0], X_PAIR + 4.03, pad_pair[1])
    c.label("m2_lbl", "Input", EDGE_L + 0.2, pin_y)
    # Right finger (between the tail and Output strips) = X3 = Com.
    c.via_stack(X_PAIR + 5.11, pad_pair[0], X_PAIR + 8.55, pad_pair[1])
    c.box("m2", X_PAIR + 5.11, pad_pair[0], EDGE_R, pad_pair[1])
    c.label("m2_lbl", "Com", EDGE_R - 0.2, pin_y)
    # Tail gate = TBias.
    c.via_stack(X_TAIL + 0.59, pad_tail[0], X_TAIL + 4.03, pad_tail[1])
    c.box("m2", EDGE_L, pad_tail[0], X_TAIL + 4.03, pad_tail[1])
    c.label("m2_lbl", "TBias", EDGE_L + 0.2, (pad_tail[0] + pad_tail[1]) / 2)

    return c


def main():
    out = globals().get("out") or os.path.join("Layout", CELL + ".gds")
    c = build()
    os.makedirs(os.path.dirname(os.path.abspath(out)), exist_ok=True)
    c.ly.write(out)
    print(f"layout: wrote {out}")


main()
