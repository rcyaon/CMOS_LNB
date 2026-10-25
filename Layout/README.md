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

## Placing instances

`scripts/place_layout.sh` netlists each schematic with Qucs-S and runs
`scripts/place_instances.py`, which writes `Layout/<cell>.gds` with one
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
cell, including any hand edits: copy a cell to a new name before routing it.

Both cells pass DRC apart from the metal-density rules (`M*.4`, `MT.3`),
which only apply to the full chip.
