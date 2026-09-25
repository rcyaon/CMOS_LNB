<Qucs Schematic 26.1.1>
<Properties>
  <View=65,145,596,442,2.96633,0,0>
  <Grid=10,10,1>
  <DataSet=ImpedanceMatching.dat>
  <DataDisplay=ImpedanceMatching.dpl>
  <OpenDisplay=0>
  <Script=ImpedanceMatching.m>
  <RunScript=0>
  <showFrame=0>
  <FrameText0=Title>
  <FrameText1=Drawn By:>
  <FrameText2=Date:>
  <FrameText3=Revision:>
</Properties>
<Symbol>
  <.ID 30 4 SUB>
  <.PortSym -110 -30 1 0 LowImpedance>
  <.PortSym 30 -30 2 180 HighImpedance>
  <.PortSym -40 50 3 90 Bias>
  <Line -110 -30 10 0 #000080 2 1>
  <Line 20 -30 10 0 #000080 2 1>
  <Line -40 50 0 -10 #000080 2 1>
  <Line -100 -40 120 0 #000080 2 1>
  <Line 20 -40 0 80 #000080 2 1>
  <Line -100 40 120 0 #000080 2 1>
  <Line -100 -40 0 80 #000080 2 1>
  <Text -90 -30 12 #000000 0 "LowZ">
  <Text -20 -30 12 #000000 0 "HiZ">
  <Text -60 20 12 #000000 0 "Bias">
</Symbol>
<Components>
  <C C1 1 300 240 -26 -55 0 2 "0.56 pF" 1 "" 0 "neutral" 0>
  <Port LowImpedance 1 150 240 -23 -50 1 0 "1" 1 "analog" 0>
  <Port HighImpedance 1 410 240 4 -50 0 2 "2" 1 "analog" 0>
  <Port Bias 1 360 360 12 4 0 1 "3" 1 "analog" 0>
  <L L1 1 360 300 -78 -26 0 3 "24 nH" 1 "" 0>
</Components>
<Wires>
  <330 240 360 240 "" 0 0 0 "">
  <360 240 360 270 "" 0 0 0 "">
  <360 330 360 360 "" 0 0 0 "">
  <360 240 410 240 "" 0 0 0 "">
  <150 240 270 240 "" 0 0 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
</Paintings>
