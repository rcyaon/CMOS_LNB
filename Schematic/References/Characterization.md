# Self-Biased Reference and Ring Oscillator

Sim results for the two blocks in `Schematic/References`: a self-biased bias generator and a current-starved ring oscillator.  Both use 6 V devices on a 5 V supply.

To redo everything, run this inside the IIC-OSIC-TOOLS container:

```
python3 scripts/characterize.py
```

It runs every `tb_*.sch` bench in this folder through ngspice at all five corners, redraws the plots and dumps the numbers into `characterization_results.json`.  The per-corner numbers live in that JSON; the tables here are just min / typ / max across corners at 5 V and 27 °C.

## Bias Generator

![Beta multiplier](/Images/QUCS_beta_mult.png)

![Reference string and buffers](/Images/QUCS_vref.png)

`beta_mult.sch` makes a reference current, `vref.sch` mirrors it into a tapped poly resistor string, and a five-transistor OTA (`ota5.sch`) buffers each tap.  All three taps come off one string, so anything given in % applies to all of them.

| | Min | Typ | Max | Bench |
|---|---|---|---|---|
| 0.7 V tap (V) | 0.669 | 0.700 | 0.737 | `tb_vref_supply` |
| 2.0 V tap (V) | 1.91 | 2.00 | 2.11 | `tb_vref_supply` |
| 3.0 V tap (V) | 2.87 | 3.00 | 3.16 | `tb_vref_supply` |
| Line regulation, 4.5 V to 5.5 V (%/V) | 7.2 | 7.8 | 8.5 | `tb_vref_supply` |
| Supply current (µA) | 97 | 119 | 156 | `tb_vref_supply` |
| Change over -25 °C to 125 °C (%) | 6.5 | 6.9 | 7.5 | `tb_vref_temp` |
| Tap output resistance (kΩ) | 9.4 | 11.5 | 13.5 | `tb_vref_load` |
| PSRR at 1 kHz, 2.0 V tap (dB) | 15.6 | 16.7 | 17.5 | `tb_vref_psrr` |
| Worst PSRR, 2.0 V tap (dB) | 4.5 | 4.7 | 5.0 | `tb_vref_psrr` |
| Noise, 10 Hz to 100 kHz, 2.0 V tap (µVrms) | 316 | 338 | 361 | `tb_vref_noise` |
| Settling to 1 % after a 1 µs supply ramp (µs) | 1.08 | 1.12 | 1.16 | `tb_vref_powerup` |
| Power-up overshoot (%) | 5.7 | 7.7 | 10 | `tb_vref_powerup` |
| Mismatch, 1σ, 2.0 V tap (mV) | -- | 51 | -- | `tb_vref_mc` |
| Process + mismatch, 1σ, 2.0 V tap (mV) | -- | 61 | -- | `tb_vref_mc` |

**Short version:** it works and starts up at every corner, but it's a self-biased reference, not a band gap, and it shows:

- The taps follow the supply (~7.8 %/V) and barely reject supply noise: 13 to 26 dB at low frequency, down to 1.7 dB near 6 MHz on the 3.0 V tap.
- They move ~7 % over temperature and ~±5 % over corners.
- Mismatch alone is 2.5 % 1σ (51 mV on the 2.0 V tap).  The LDO in `Schematic/LDO` is around ±10 mV at 2σ.
- The buffers have ~11 kΩ output resistance, so a tap droops 11 mV per µA and falls over somewhere between 10 and 20 µA.  Fine for driving gates, not for supplying current.
- It was designed for 0.7 / 2.0 / 3.0 V from 5 V.  The LNA wants 1.2 (or 1.0) / 1.7 / 2.5 V from 3.3 V, where the taps sit at 0.63 / 1.79 / 2.69 V and the string is nearly out of headroom.

Moving the taps is just three resistor lengths, but the rest comes with the topology.  So this isn't a drop-in replacement for the LDO reference.

### Plots

Supply swept 0 V to 6 V.  Below ~3 V the taps just track the supply; above that they still creep up because nothing is cascoded.

![Supply sweep](/Images/Bias_Supply.png)

![Supply current](/Images/Bias_Supply_Current.png)

Temperature, -25 °C to 125 °C:

![Temperature sweep](/Images/Bias_Temp.png)

Power-up with a 1 µs supply ramp.  The taps are within 1 % about 0.1 µs after the supply gets to 5 V; the overshoot is them riding the ramp.

![Power-up](/Images/Bias_Powerup.png)

DC load of 0 to 20 µA on all three taps at once:

![Load regulation](/Images/Bias_Load.png)

10 µA load step with 0, 1, 10 and 100 pF hung on each tap (`tb_vref_loadstep`).  One overshoot at 0 and 1 pF, no ringing at any corner, and from 10 pF up it just gets slower.

![Load step](/Images/Bias_Load_Step.png)

PSRR:

![PSRR](/Images/Bias_PSRR.png)

Noise.  It scales with the tap voltage, so it's coming from the reference current and not the buffers.

![Noise](/Images/Bias_Noise.png)

Monte Carlo, 500 runs at TT, mismatch only and then with die-to-die process variation added.  Mismatch dominates (2.5 % goes to 3.1 %), and it comes from the beta multiplier, whose current is set by a small Vgs difference between two transistors.

![Monte Carlo mismatch](/Images/Bias_MC_Mismatch.png)

![Monte Carlo global](/Images/Bias_MC_Global.png)

The beta multiplier on its own (`tb_beta_mult_supply`, `tb_beta_mult_temp`, `tb_beta_mult_startup`).  Iref is 19.4 µA typical (15.9 to 25.3 µA over corners) and moves ~5.7 %/V with the supply.  With the start-up branch connected it's up in ~0.17 µs; with it disconnected it stays off, so the start-up circuit is needed and it works.

![Beta multiplier](/Images/Bias_Beta_Multiplier.png)

## Ring Oscillator

![Ring oscillator](/Images/QUCS_ringosci.png)

`ringosci.sch` is a three-stage current-starved inverter ring with a two-inverter output buffer.  A control current into `ictl` sets the frequency.


| Parameter                               | Minimum  | Typical  | Maximum  |
| --------------------------------------- | -------- | -------- | -------- |
| LO Frequency, 20 µA Control Current     | 0.45 GHz | 0.48 GHz | 0.50 GHz |
| LO Frequency, 80 µA Control Current     | 1.02 GHz | 1.22 GHz | 1.36 GHz |
| LO Frequency, 200 µA Control Current    | 1.13 GHz | 1.42 GHz | 1.67 GHz |
| LO Frequency, 200 µA Control Current    | 1.13 GHz | 1.42 GHz | 1.67 GHz |
| Supply Current, Running at 80 µA        | 1.31 mA  | 1.57 mA  | 1.82 mA  |
| Supply Current, Control Current Removed | 13 µA    | 35 µA    | 58 µA    |

Minimum and maximum are across the process corners at 5 V and 27 °C.  The tuning curve flattens out above about 100 µA, and the oscillator is free running, so the frequency also moves with temperature (1.36 GHz at -25 °C down to 1.01 GHz at 125 °C at 80 µA) and supply.  The full results are [here](Schematic/References/Characterization.md#ring-oscillator).


| | Min | Typ | Max | Bench |
|---|---|---|---|---|
| LO frequency, 20 µA control current (GHz) | 0.447 | 0.482 | 0.504 | `tb_ringosci_tune` |
| LO frequency, 80 µA (GHz) | 1.02 | 1.22 | 1.36 | `tb_ringosci` |
| LO frequency, 200 µA (GHz) | 1.13 | 1.42 | 1.67 | `tb_ringosci_tune` |
| Supply current, running at 80 µA (mA) | 1.31 | 1.57 | 1.82 | `tb_ringosci_disable` |
| Supply current, control current removed (µA) | 13 | 35 | 58 | `tb_ringosci_disable` |
| Restart time (ns) | 2.34 | 2.39 | 2.87 | `tb_ringosci_disable` |

It oscillates at every corner and swings nearly rail to rail (0.1 V to 4.85 V into 50 fF).  Things to know before using it as the LO:

- **Tuning saturates.**  Above ~100 µA the frequency flattens out: 1.42 GHz typical, 1.13 GHz at SS, 1.14 GHz at 125 °C.  Nothing we simulated reaches 1.7 GHz.
- **It drifts.**  At a fixed 80 µA it goes from 1.36 GHz at -25 °C to 1.01 GHz at 125 °C, and from 1.17 GHz to 1.25 GHz over 4.5 V to 5.5 V.  It's free running, with no lock or calibration.
- **Disable is just pulling the control current.**  The ring stops, the output parks at VDD, the supply current drops to ~35 µA, and it restarts in ~2.4 ns.  There's no real enable pin and no way to feed in an external LO yet.

![Oscillator transient](/Images/Osc_Transient.png)

![Oscillator tuning](/Images/Osc_Tuning.png)
