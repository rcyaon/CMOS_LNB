# Layout

GF180MCU (gf180mcuD) layout for the NMOS-input LDO. Open with the PDK tech loaded:

```
KLAYOUT_PATH=$PDK_ROOT/gf180mcuD/libs.tech/klayout klayout -e Layout/LDOMkI.gds
```

## Hierarchy

The cell holds exactly the instances of its schematic, so LVS can match it.

```
LDOMkI                     Schematic/LDO/LDOMkI.sch
├── ErrorAmplifierNMOSMkI ×1   Schematic/Error Amplifier/ErrorAmplifierNMOSMkI.sch
└── pfet_06v0 ×1           pass device, W=80u L=10u
```

| Cell | State |
| --- | --- |
| `LDOMkI` | Placed only |

Instance names are text on layer 255/0 (not a GF180 layer; delete it before
tapeout).

DRC (metal-density rules `M*.4`, `MT.3` only apply to the full chip):

```
klayout -b -r $PDK_ROOT/gf180mcuD/libs.tech/klayout/tech/drc/gf180mcu.drc \
  -rd input=Layout/LDOMkI.gds -rd report=/tmp/LDOMkI.lyrdb -rd variant=D
```
