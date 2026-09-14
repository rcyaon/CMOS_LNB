<Qucs Schematic 26.1.1>
<Properties>
  <View=-2246,-301,4904,752,0.837036,2198,0>
  <Grid=10,10,1>
  <DataSet=Balun_Testing.dat>
  <DataDisplay=Balun_Testing.dpl>
  <OpenDisplay=0>
  <Script=Balun_Testing.m>
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
  <.TR TR1 1 240 -590 0 50 0 0 "lin" 1 "0" 1 "0.02 us" 1 "2000" 0 "Trapezoidal" 0 "2" 0 "1 ns" 0 "1e-16" 0 "150" 0 "0.001" 0 "1 pA" 0 "1 uV" 0 "26.85" 0 "1e-3" 0 "1e-6" 0 "1" 0 "CroutLU" 0 "no" 0 "yes" 0 "0" 0>
  <.DC DC1 1 240 -450 0 31 0 0 "26.85" 0 "0.001" 0 "1 pA" 0 "1 uV" 0 "no" 0 "150" 0 "no" 0 "none" 0 "CroutLU" 0>
  <SpiceInclude SpiceInclude1 1 440 -590 -37 16 0 0 "/foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice" 1 "" 0 "" 0 "" 0 "" 0>
  <SpiceLib SpiceLib1 1 420 -500 -14 16 0 0 "/foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice" 1 "typical" 1>
  <GND * 1 1610 180 0 0 0 0>
  <R R2 1 1610 130 15 -26 0 1 "50 kOhm" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "US" 0>
  <GND * 1 1610 420 0 0 0 0>
  <R R3 1 1610 370 15 -26 0 1 "50 kOhm" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "US" 0>
  <C C1 1 1540 80 -26 17 0 0 "1 pF" 1 "" 0 "neutral" 0>
  <C C2 1 1540 320 -26 17 0 0 "1 pF" 1 "" 0 "neutral" 0>
  <GND * 1 640 300 0 0 0 0>
  <GND * 1 750 300 0 0 0 0>
  <R R4 1 750 180 15 -26 0 1 "30 kOhm" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "US" 0>
  <GND * 1 1040 -70 0 0 0 0>
  <Vdc V3 1 1040 -130 18 -26 0 1 "5 V" 1>
  <Vac V1 1 640 260 18 -26 0 1 "1 mV" 1 "1.7 GHz" 0 "0" 0 "0" 0 "0" 0 "0" 0>
  <GND * 1 870 310 0 0 0 0>
  <C C3 1 640 180 -76 -26 0 3 "1 pF" 1 "" 0 "neutral" 0>
  <Vdc V2 1 750 260 18 -26 0 1 "1.9 V" 1>
  <Vdc V4 1 870 260 18 -26 0 1 "1.9 V" 1>
  <Sub SUB5 1 1150 170 -26 138 0 0 "DiffPairBalun.sch" 0>
</Components>
<Wires>
  <1610 160 1610 180 "" 0 0 0 "">
  <1610 80 1610 100 "" 0 0 0 "">
  <1610 400 1610 420 "" 0 0 0 "">
  <1610 320 1610 340 "" 0 0 0 "">
  <1460 80 1460 140 "output_pos_dc" 1490 10 52 "">
  <1460 80 1510 80 "" 0 0 0 "">
  <1460 320 1510 320 "output_neg_dc" 1490 250 6 "">
  <1570 80 1610 80 "" 0 0 0 "">
  <1570 320 1610 320 "" 0 0 0 "">
  <750 140 1080 140 "" 0 0 0 "">
  <640 140 640 150 "" 0 0 0 "">
  <640 210 640 230 "input" 670 190 11 "">
  <750 210 750 230 "" 0 0 0 "">
  <640 140 750 140 "" 0 0 0 "">
  <750 140 750 150 "" 0 0 0 "">
  <750 290 750 300 "" 0 0 0 "">
  <640 290 640 300 "" 0 0 0 "">
  <1040 -180 1040 -160 "" 0 0 0 "">
  <1040 -100 1040 -70 "" 0 0 0 "">
  <1040 -180 1150 -180 "" 0 0 0 "">
  <870 220 870 230 "" 0 0 0 "">
  <870 290 870 310 "" 0 0 0 "">
  <870 220 980 220 "" 0 0 0 "">
  <1460 180 1460 320 "" 0 0 0 "">
  <1150 -180 1150 90 "" 0 0 0 "">
  <980 260 1080 260 "" 0 0 0 "">
  <1420 220 1420 340 "" 0 0 0 "">
  <1220 140 1460 140 "" 0 0 0 "">
  <1220 180 1460 180 "" 0 0 0 "">
  <1220 220 1420 220 "" 0 0 0 "">
  <1220 260 1300 260 "" 0 0 0 "">
  <1300 260 1300 340 "" 0 0 0 "">
  <1420 340 1300 340 "" 0 0 0 "">
  <1300 340 980 340 "" 0 0 0 "">
  <980 340 980 260 "" 0 0 0 "">
  <980 220 1080 220 "" 0 0 0 "">
  <980 220 980 260 "" 0 0 0 "">
  <1610 80 1610 80 "output_pos" 1620 50 0 "">
  <1610 320 1610 320 "output_neg" 1620 290 0 "">
  <750 140 750 140 "lna_output_dc" 780 70 0 "">
</Wires>
<Diagrams>
  <Rect 750 836 792 366 3 #c0c0c0 1 00 1 0 2e-09 2e-08 1 -1.22378e-05 5e-06 1.84266e-05 1 -1 0.2 1 315 0 225 1 0 0 "" "" "">
	<"ngspice/tran.v(input)" #0000ff 0 3 0 0 0>
	<"ngspice/tran.v(output_neg)" #ff0000 0 3 0 0 0>
	<"ngspice/tran.v(output_pos)" #ff00ff 0 3 0 0 0>
  </Rect>
  <Tab 240 -263 1606 103 3 #c0c0c0 1 00 1 0 1 1 1 0 1 1 1 0 1 1 315 0 225 1 0 0 "" "" "">
	<"ngspice/v(input)" #0000ff 0 3 0 0 0>
	<"ngspice/v(hiz_input_dc)" #0000ff 0 3 0 0 0>
	<"ngspice/v(lna_stage_1_dc)" #0000ff 0 3 0 0 0>
	<"ngspice/v(lna_stage_2_dc)" #0000ff 0 3 0 0 0>
	<"ngspice/v(lna_output_dc)" #0000ff 0 3 0 0 0>
	<"ngspice/v(output_neg)" #0000ff 0 3 0 0 0>
	<"ngspice/v(output_pos)" #0000ff 0 3 0 0 0>
	<"ngspice/v(output_pos_dc)" #0000ff 0 3 1 0 0>
	<"ngspice/v(output_neg_dc)" #0000ff 0 3 1 0 0>
  </Tab>
</Diagrams>
<Paintings>
  <Text 240 -240 12 #000000 0 "Low Noise Amplifier">
</Paintings>
