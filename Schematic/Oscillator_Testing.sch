<Qucs Schematic 26.1.1>
<Properties>
  <View=-890,-711,5453,1139,1.48644,2597,972>
  <Grid=10,10,1>
  <DataSet=Oscillator_Testing.dat>
  <DataDisplay=Oscillator_Testing.dpl>
  <OpenDisplay=0>
  <Script=Oscillator_Testing.m>
  <RunScript=0>
  <showFrame=0>
  <FrameText0=Title>
  <FrameText1=Drawn By:>
  <FrameText2=Date:>
  <FrameText3=Revision:>
</Properties>
<Symbol>
</Symbol>
<Components>
  <GND * 1 360 170 0 0 0 0>
  <Vdc V1 1 360 140 18 -26 0 1 "5 V" 1>
  <.DC DC1 1 240 690 0 31 0 0 "26.85" 0 "0.001" 0 "1 pA" 0 "1 uV" 0 "no" 0 "150" 0 "no" 0 "none" 0 "CroutLU" 0>
  <SpiceInclude SpiceInclude1 1 590 560 -37 16 0 0 "/foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice" 1 "" 0 "" 0 "" 0 "" 0>
  <GND * 1 850 370 0 0 0 0>
  <Sub SUB1 1 440 300 -26 98 0 0 "RingOscillator.sch" 0>
  <R R1 1 850 320 15 -26 0 1 "10000 Ohm" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "US" 0>
  <R R2 1 690 380 15 -26 0 1 "10000 Ohm" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "US" 0>
  <GND * 1 690 430 0 0 0 0>
  <C C4 1 570 330 -26 17 0 0 "10 pF" 1 "" 0 "neutral" 0>
  <C C3 1 660 280 -26 17 0 0 "10 pF" 1 "" 0 "neutral" 0>
  <.TR TR1 1 240 550 0 50 0 0 "lin" 1 "0" 1 "0.02 us" 1 "20000" 0 "Trapezoidal" 0 "2" 0 "1 ns" 0 "1e-16" 0 "150" 0 "0.001" 0 "1 pA" 0 "1 uV" 0 "26.85" 0 "1e-3" 0 "1e-6" 0 "1" 0 "CroutLU" 0 "no" 0 "yes" 0 "0" 0>
  <SpiceLib SpiceLib1 1 570 650 -14 16 0 0 "/foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice" 1 "FF" 1>
  <SpicePar SpicePar1 1 590 750 -29 16 0 0 ".options temp=85" 1>
  <NutmegEq NutmegEq1 1 590 840 -31 16 0 0 "FFT1" 1 "pos_dBm=dB(( v(pos) / sqrt(2) ) / 0.2236)" 1 "neg_dBm=dB(( v(pos) / sqrt(2) ) / 0.2236)" 1 "freq_center=frequency - 2.416e9" 1>
  <.FFT FFT1 1 380 550 0 50 0 0 "10GHz" 1 "10 kHz" 1 "hanning" 1 "2" 0 "0" 0 "yes" 0>
</Components>
<Wires>
  <360 90 360 110 "" 0 0 0 "">
  <440 90 440 220 "" 0 0 0 "">
  <360 90 440 90 "" 0 0 0 "">
  <850 280 850 290 "" 0 0 0 "">
  <850 350 850 370 "" 0 0 0 "">
  <520 280 630 280 "pos_dc" 570 250 20 "">
  <690 280 850 280 "pos" 820 250 101 "">
  <600 330 690 330 "neg" 690 300 62 "">
  <690 330 690 350 "" 0 0 0 "">
  <690 410 690 430 "" 0 0 0 "">
  <520 330 540 330 "neg_dc" 560 300 12 "">
</Wires>
<Diagrams>
  <Rect 1110 410 708 385 3 #c0c0c0 1 00 0 0 5e+07 5e+08 0 -80 20 20 1 -1 0.2 1 315 0 225 1 0 0 "" "" "">
	<"ngspice/ac.pos_dbm@ac.freq_center" #ff0000 3 3 0 0 0>
	  <Mkr 8791.98 70 -370 3 0 0>
	  <Mkr 98791.9 86 -262 3 0 0>
	  <Mkr 998791 76 -314 3 0 0>
	  <Mkr 9.99879e+06 104 -210 3 0 0>
  </Rect>
  <Tab 530 135 452 88 3 #c0c0c0 1 00 1 0 1 1 1 0 1 1 1 0 1 10001 315 0 225 1 0 0 "" "" "">
	<"ngspice/v(pos_dc)" #0000ff 0 3 0 0 0>
	<"ngspice/v(neg_dc)" #0000ff 0 3 0 0 0>
  </Tab>
  <Rect 1160 875 709 405 3 #c0c0c0 1 00 1 -1 0.5 1 1 -1 1 1 1 -1 1 1 315 0 225 1 0 0 "" "" "">
	<"ngspice/tran.v(pos)" #0000ff 0 3 0 0 0>
	<"ngspice/tran.v(neg)" #ff0000 0 3 0 0 0>
  </Rect>
</Diagrams>
<Paintings>
</Paintings>
