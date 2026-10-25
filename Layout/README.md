# Layout

GF180MCU (gf180mcuD) layout cells. Open with the PDK tech loaded:

```
KLAYOUT_PATH=$PDK_ROOT/gf180mcuD/libs.tech/klayout klayout -e Layout/LDOMkI.gds
```

## Hierarchy

Each cell holds exactly the instances of its schematic, so LVS can match it.
Lay out the leaf cells first, then work up the tree.

```
LDOMkI                     Schematic/LDO/LDOMkI.sch
├── ErrorAmplifierNMOSMkI ×1
└── pfet_06v0 ×1           pass device, W=80u L=10u

ErrorAmplifierNMOSMkI      Schematic/Error Amplifier/ErrorAmplifierNMOSMkI.sch (leaf)
├── pfet_06v0 ×2           W=10u L=4u, current-mirror load
└── nfet_06v0 ×3           W=10u L=4u, input pair and tail
```

| Cell | State |
| --- | --- |
| `ErrorAmplifierNMOSMkI` | Placed and routed, DRC and LVS clean |
| `LDOMkI` | Placed only |

## ErrorAmplifierNMOSMkI (routed)

Drawn by `scripts/layout_ErrorAmplifierNMOSMkI.py`. About 16 × 46 µm:

- X1/X2 (mirror) are one 2-finger pfet with VDD on the shared middle strip,
  inside an N-well with an N+ tap ring (VDD).
- X5/X3 (input pair) are one 2-finger nfet with the tail on the shared middle
  strip. X4 (tail) sits below with its drain lined up under the tail strip.
  Both are inside a P+ substrate ring (VSS).
- Metal1 stays inside the rings and everything that leaves a ring is on Metal2.
- Pins: `Input` and `TBias` on the left, `Com` and `Output` on the right
  (Metal2 labels), `VDD` and `VSS` on the rings (Metal1 labels). The schematic
  has no ground port. `VSS` is its global node 0, i.e. the substrate.

The PCell's own `Bulk Tie` option is not used: it butts the tap against a
source and would short the input pair's tail to ground. Its `Guard Ring`
option draws a solid diffusion block in this PDK version, so the rings are
drawn by the script.

LVS against `ErrorAmplifierNMOSMkI.spice`, inside the container:

```
python3 $PDK_ROOT/gf180mcuD/libs.tech/klayout/tech/lvs/run_lvs.py \
  --layout=Layout/ErrorAmplifierNMOSMkI.gds --netlist=Layout/ErrorAmplifierNMOSMkI.spice \
  --variant=D --topcell=ErrorAmplifierNMOSMkI --lvs_sub=VSS --run_dir=/tmp/lvs
```

## Placing instances

`scripts/place_layout.sh` netlists each schematic with Qucs-S and runs
`scripts/place_instances.py` (or the cell's own `scripts/layout_<cell>.py`
if it has one, see above), which writes `Layout/<cell>.gds` with one
gf180mcu PCell per device (each MOSFET with its own bulk tie) and one
instance per subcircuit, in rows: passives, NMOS, PMOS, subcells. Nothing is
routed. Instance names are text on layer 255/0 (not a GF180 layer; delete it
before tapeout).

```
scripts/place_layout.sh                                   # error amp, then LDO
scripts/place_layout.sh "Schematic/LDO/ReferenceMkI.sch"  # any other cell
```

It runs inside the IIC-OSIC-TOOLS container, or from the host through
`docker exec` (container name in `$OSIC_CONTAINER`). Rerunning replaces the
cell, including any hand edits: copy a cell to a new name before routing it
by hand, or write a `scripts/layout_<cell>.py` generator.

Both cells pass DRC (`klayout -b -r $PDK_ROOT/gf180mcuD/libs.tech/klayout/tech/drc/gf180mcu.drc -rd input=<gds> -rd report=<lyrdb> -rd variant=D`) apart from the metal-density rules (`M*.4`, `MT.3`),
which only apply to the full chip.
