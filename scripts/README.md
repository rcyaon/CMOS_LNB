# Scripts

Run from the repo root, inside the IIC-OSIC-TOOLS container unless noted.

| Script | What it does |
| --- | --- |
| `place_layout.sh` | Netlists schematics and places their devices into `Layout/<cell>.gds` (also works from the host via docker). See `Layout/README.md`. |
| `layout_ErrorAmplifierNMOSMkI.py` | Placed and routed layout of the NMOS-input error amplifier (run through `place_layout.sh`). |
| `place_instances.py` | KLayout macro used by `place_layout.sh`: one gf180mcu PCell per device of a Qucs-S netlist, unrouted. |
| `characterize.py` | Corner characterization of the bias reference and ring oscillator benches in `Schematic/References`; writes `Images/Bias_*`, `Images/Osc_*` and `characterization_results.json`. |
| `mc_process.py` | Plots Monte Carlo spread from an ngspice print file, e.g. `python3 scripts/mc_process.py Schematic/LDO/mc_data.csv`; writes `Images/MC_<column>_TT.png`. |
| `xschem2qucs.py` | xschem → Qucs-S converter used to create the reference cells. It expects the original `xschem/` and `sims/tb/` folders, which are not in this repo. |
