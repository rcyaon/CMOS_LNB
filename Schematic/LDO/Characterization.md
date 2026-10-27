# Biasing Reference Supply

*Most Up-To-Date Schematic: Schematic/LDO/Reference.sch*

This characterization assumes an ideally stable 1.2V supply because the performance of the GF180MCU harness band gap reference design remains unclear.  In actuality, many of these performance metrics may be limited by the stability of the band gap reference.  Testing was performed with the reference supply unloaded because the biased transistor gates provide nearly no additional loading to the reference.

## Rise Time Test Bench

*Most Up-To-Date Schematic: Schematic/LDO/LDO_Testing_Rise_Time_MkI.sch*

The voltage reference takes at most 500 nS to stabilize, reaching the desired steady output voltage.

### Typical 
![Rise Time](/Images/Reference_Rise_Time_TT.png)

### Slow-Slow Corner

![Rise Time](/Images/Reference_Rise_Time_TT.png)

### Fast-Fast Corner

![Rise Time](/Images/Reference_Rise_Time_TT.png)

### Slow-Fast Corner

![Rise Time](/Images/Reference_Rise_Time_TT.png)

### Fast-Slow Corner

![Rise Time](/Images/Reference_Rise_Time_TT.png)



## Supply Voltage Test Bench

*Most Up-To-Date Schematic: Schematic/LDO/LDO_Testing_Supply_MkI.sch*

The bias supply reference remains functional and stable between 3V and 4V.

### Typical 
![Supply](/Images/Reference_Supply_TT.png)

### Slow-Slow Corner

![Supply](/Images/Reference_Supply_SS.png)

### Fast-Fast Corner

![Supply](/Images/Reference_Supply_FF.png)

### Slow-Fast Corner

![Supply](/Images/Reference_Supply_SF.png)

### Fast-Slow Corner

![Supply](/Images/Reference_Supply_FS.png)



## Temperature Sweep Test Bench

*Most Up-To-Date Schematic: Schematic/LDO/LDO_Testing_Temp_MkI.sch*

Temperature was swept over the automotive span of -25 C to 125 C.  The LDO remained stable over the entire temperature span.

### Typical 
| 1.7 V | 2.5 V |
|---------------------|---------------------|
|![Temperature](/Images/Reference_Temp_1v7_TT.png)|![Temperature](/Images/Reference_Temp_2v5_TT.png)|


### Slow-Slow Corner
| 1.7 V | 2.5 V |
|---------------------|---------------------|
|![Temperature](/Images/Reference_Temp_1v7_SS.png)|![Temperature](/Images/Reference_Temp_2v5_SS.png)|


### Fast-Fast Corner
| 1.7 V | 2.5 V |
|---------------------|---------------------|
|![Temperature](/Images/Reference_Temp_1v7_FF.png)|![Temperature](/Images/Reference_Temp_2v5_FF.png)|


### Slow-Fast Corner
| 1.7 V | 2.5 V |
|---------------------|---------------------|
|![Temperature](/Images/Reference_Temp_1v7_SF.png)|![Temperature](/Images/Reference_Temp_2v5_SF.png)|


### Fast-Slow Corner
| 1.7 V | 2.5 V |
|---------------------|---------------------|
|![Temperature](/Images/Reference_Temp_1v7_FS.png)|![Temperature](/Images/Reference_Temp_2v5_FS.png)|



## Monte Carlo Mismatch Test Bench

*Most Up-To-Date Schematic: Schematic/LDO/LDO_Monte_Carlo_MkI.sch*

A 3000 run Monte Carlo simulation was performed using the typical transistor corner in order to assess drift in the output due to transistor mismatch.  The results showed a 2 standard deviation drift of around ±10 mV.  This is more than enough for the bias supply.  This uses the worst-case die-to-die variance model.  It is likely matching would be better on transistors near each other on the same die.

### 1.7 V Reference

![Monte Carlo](/Images/MC_out_1v7_TT.png)

### 2.5 V Reference

![Monte Carlo](/Images/MC_out_2v5_TT.png)



# 1.7 V LDO (ReferenceMkII)

*Schematic: Schematic/LDO/ReferenceMkII.sch · Layout: Layout/ReferenceMkII.gds*

1.7 V branch of ReferenceMkI: error amp, pass FET, divider, MIM cap and tail diode. Size: **75 × 30.6 µm**.

![Layout](/Images/ReferenceMkII_Layout.png)

Pins: VDD, VSS, Out (1.7 V), BandGap (1.2 V), TBias (sink 10 µA).

## Checks

| Check | Result |
| --- | --- |
| DRC (KLayout) | Pass (density rules are chip-level) |
| DRC (Magic) | Pass |
| LVS (KLayout, netgen) | Pass |
| PEX (Magic) | Done |
| Ampacity (125 °C) | Pass |

## Results (post-layout)

| Parameter | Value |
| --- | --- |
| Vout | 1.703 V |
| Quiescent current | 68 µA |
| Phase margin | ≥ 53° |
| PSRR (1 kHz) | −75 dB |
| Temp drift (−25 to 125 °C) | ~5 mV |
| Max load (1 % drop) | 165 µA |
| Start-up | < 280 ns |

Note: low load-current capability and no output cap, so this is for gate bias only.

## Plots

![Supply](/Images/ReferenceMkII_Supply.png)
![Temperature](/Images/ReferenceMkII_Temperature.png)
![Load](/Images/ReferenceMkII_Load.png)
![Loop](/Images/ReferenceMkII_Loop.png)
![PSRR](/Images/ReferenceMkII_PSRR.png)
![Startup](/Images/ReferenceMkII_Startup.png)

## DUALGATE

DUALGATE marks thick (6 V) gate oxide, not dual-gate transistors. All 6 V devices need it.
