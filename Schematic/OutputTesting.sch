<Qucs Schematic 26.1.1>
<Properties>
  <View=-101,-111,1576,742,1.77156,946,436>
  <Grid=10,10,1>
  <DataSet=OutputTesting.dat>
  <DataDisplay=OutputTesting.dpl>
  <OpenDisplay=0>
  <Script=OutputTesting.m>
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
  <R R1 1 600 480 15 -26 0 1 "1 kOhm" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "US" 0>
  <GND * 1 540 540 0 0 0 0>
  <.TR TR1 1 490 130 0 50 0 0 "lin" 1 "0" 1 "0.02 us" 1 "2000" 0 "Trapezoidal" 0 "2" 0 "1 ns" 0 "1e-16" 0 "150" 0 "0.001" 0 "1 pA" 0 "1 uV" 0 "26.85" 0 "1e-3" 0 "1e-6" 0 "1" 0 "CroutLU" 0 "no" 0 "yes" 0 "0" 0>
  <.DC DC1 1 490 270 0 31 0 0 "26.85" 0 "0.001" 0 "1 pA" 0 "1 uV" 0 "no" 0 "150" 0 "no" 0 "none" 0 "CroutLU" 0>
  <Vac V1 1 480 480 18 -26 0 1 "1 V" 1 "2 GHz" 0 "0" 0 "0" 0 "0" 0 "0" 0>
  <.FFT FFT1 1 630 130 0 50 0 0 "10GHz" 1 "1 MHz" 1 "none" 1 "2" 0 "0" 0 "no" 0>
</Components>
<Wires>
  <600 450 600 410 "" 0 0 0 "">
  <600 410 480 410 "" 0 0 0 "">
  <480 410 480 450 "" 0 0 0 "">
  <480 510 480 540 "" 0 0 0 "">
  <480 540 540 540 "" 0 0 0 "">
  <600 540 600 510 "" 0 0 0 "">
  <540 540 600 540 "" 0 0 0 "">
  <600 410 600 410 "output" 630 380 0 "">
</Wires>
<Diagrams>
  <Rect 1010 590 240 160 3 #c0c0c0 1 00 0 0 2e+09 3e+09 1 -0.0976363 0.5 1.074 1 -1 1 1 315 0 225 1 0 0 "" "" "">
	<"ngspice/ac.v(output)" #0000ff 1 3 0 0 0>
	  <Mkr 1.9999e+09 -290 -247 3 1 0>
	  <Mkr 9.9995e+08 -280 -160 3 1 0>
  </Rect>
  <Rect 1010 380 240 160 3 #c0c0c0 1 00 1 0 0.5 2 1 -1 1 1 1 -1 1 1 315 0 225 1 0 0 "" "" "">
	<"ngspice/tran.v(output)" #ff0000 0 3 0 0 0>
  </Rect>
</Diagrams>
<Paintings>
</Paintings>
