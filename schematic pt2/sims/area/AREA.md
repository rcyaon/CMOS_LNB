# Pre-layout area estimate

Tool: [rcyaon/sch-area-estimator](https://github.com/rcyaon/sch-area-estimator)
(upstream a2e3a04), GF180MCU estimator, run by `spice/area/estimate_blocks.py`.
Netlists come straight from `xschem/<cell>.sch` (xschem in the IIC-OSIC container),
flattened per instance. Default routing overhead: ×1.3.

| Cell | Devices | MOS (µm²) | Resistors (µm²) | MIM caps (µm²) | Device total (µm²) | With routing ×1.3 (µm²) | ≈ Square side |
|---|---|---|---|---|---|---|---|
| inv (6 V, 2/5 µm) | 2 | 39.3 | — | — | 39.3 | 51.1 | 7.2 µm |
| ringosci (3 × inv, no cap) | 6 | 118.0 | — | — | 118.0 | 153.4 | 12.4 µm |
| ota5 | 5 | 801.8 | — | — | 801.8 | 1,042 | 32.3 µm |
| vref (3 × ota5 + string + caps) | 22 | 2,603 | 533 | 1,786 | 4,922 | 6,398 | 80.0 µm |
| beta_mult | 11 | 1,106 | 61 | 1,191 | 2,357 | 3,065 | 55.4 µm |
| **beta_mult + vref** | 33 | 3,709 | 594 | 2,977 | 7,279 | **9,463** | 97.3 µm |

## Device database

The GF180 `device_db.json` shipped upstream is all placeholders. It was rebuilt
from 272 real Magic layouts (gf180mcuD, IIC-OSIC container) using a patched copy of
the upstream measurement script, `spice/area/gf180mcu_measure_devices.py`. Changes:
- corrected Magic proc names
- gf180mcuD magicrc
- removed the upstream ruleset patch, which drew every device with placeholder rules
- legal-only sweep sizes
- added ppolyf_u_1k, nwell and cap_mim_2f0fF

Fit error against the measured layouts:
- MOSFETs: 0.1 % mean.
- Resistors: exact.
- MIM caps: +5 % high. The estimator's symmetric-border model uses the 1.2 µm x border; the measured y border is 0.6 µm.

## What the numbers include and don't

- Each device's area is its Magic-generated cell: contacts plus its own guard ring.
- Well-to-well spacing, matching dummies, common-centroid arrangements, and power
  rails/pins are only covered by the flat ×1.3 routing factor. For matched analog
  blocks, ×1.5–2 is a common planning margin.
- MIM caps are 36 % (vref) and 51 % (beta_mult) of device area. The MIM sits in
  the upper metal stack, so if the PDK rules allow it over active devices, those
  caps could overlap the transistors instead of adding area. Check the
  MIM-over-device rules before counting on it.
