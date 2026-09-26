<Qucs Schematic 26.1.1>
<Properties>
  <View=-1751,12,2162,1918,1.19868,1835,346>
  <Grid=10,10,1>
  <DataSet=RingOscillator.dat>
  <DataDisplay=RingOscillator.dpl>
  <OpenDisplay=0>
  <Script=RingOscillator.m>
  <RunScript=0>
  <showFrame=0>
  <FrameText0=Title>
  <FrameText1=Drawn By:>
  <FrameText2=Date:>
  <FrameText3=Revision:>
</Properties>
<Symbol>
  <.ID 30 -116 SUB>
  <.PortSym 0 -80 1 270 VDD>
  <Line 0 -70 0 -10 #000080 2 1>
  <Line 70 30 10 0 #000080 2 1>
  <Line 70 -20 10 0 #000080 2 1>
  <Line -70 -70 140 0 #000080 2 1>
  <Line 70 -70 0 160 #000080 2 1>
  <Line -70 -70 0 160 #000080 2 1>
  <Text -20 -70 12 #000000 0 "VDD">
  <Text 30 -30 12 #000000 0 "Pos">
  <Text 30 20 12 #000000 0 "Neg">
  <Line -70 90 140 0 #000080 2 1>
  <.PortSym 80 30 3 180 Neg>
  <.PortSym 80 -20 2 180 Pos>
</Symbol>
<Components>
  <Port VDD 1 120 480 -72 -23 0 3 "1" 1 "analog" 0>
  <Sub SUB1 1 120 590 -26 98 0 0 "RingInverter.sch" 0>
  <Sub SUB2 1 320 590 -26 98 0 0 "RingInverter.sch" 0>
  <Sub SUB3 1 520 590 -26 98 0 0 "RingInverter.sch" 0>
  <Sub SUB4 1 720 590 -26 98 0 0 "RingInverter.sch" 0>
  <Sub SUB5 1 920 590 -26 98 0 0 "RingInverter.sch" 0>
  <Port Neg 1 1030 720 12 4 0 1 "3" 1 "analog" 0>
  <Port Pos 1 820 720 12 4 0 1 "2" 1 "analog" 0>
</Components>
<Wires>
  <120 480 120 490 "" 0 0 0 "">
  <200 600 240 600 "" 0 0 0 "">
  <400 600 440 600 "" 0 0 0 "">
  <600 600 620 600 "" 0 0 0 "">
  <800 600 820 600 "" 0 0 0 "">
  <1000 600 1030 600 "" 0 0 0 "">
  <1030 600 1030 720 "" 0 0 0 "">
  <820 600 840 600 "" 0 0 0 "">
  <820 600 820 720 "" 0 0 0 "">
  <620 600 640 600 "" 0 0 0 "">
  <620 600 620 720 "" 0 0 0 "">
  <620 720 0 720 "" 0 0 0 "">
  <0 720 0 600 "" 0 0 0 "">
  <0 600 40 600 "" 0 0 0 "">
  <120 490 120 510 "" 0 0 0 "">
  <120 490 320 490 "" 0 0 0 "">
  <920 490 920 510 "" 0 0 0 "">
  <720 490 920 490 "" 0 0 0 "">
  <720 510 720 490 "" 0 0 0 "">
  <520 490 720 490 "" 0 0 0 "">
  <520 510 520 490 "" 0 0 0 "">
  <320 490 520 490 "" 0 0 0 "">
  <320 510 320 490 "" 0 0 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
</Paintings>
