<Qucs Schematic 26.1.1>
<Properties>
  <View=-381,-30,1327,925,0.922513,0,0>
  <Grid=10,10,1>
  <DataSet=Balun.dat>
  <DataDisplay=Balun.dpl>
  <OpenDisplay=0>
  <Script=Balun.m>
  <RunScript=0>
  <showFrame=0>
  <FrameText0=Title>
  <FrameText1=Drawn By:>
  <FrameText2=Date:>
  <FrameText3=Revision:>
</Properties>
<Symbol>
  <.ID 30 -126 SUB>
  <.PortSym 0 -80 1 270 VDD>
  <.PortSym -70 -30 2 0 Input>
  <.PortSym 70 -30 3 180 Positive>
  <.PortSym 70 90 4 180 Negative>
  <Line -70 -30 10 0 #000080 2 1>
  <Line 60 -30 10 0 #000080 2 1>
  <Line 0 -70 0 -10 #000080 2 1>
  <Line 60 90 10 0 #000080 2 1>
  <Line -60 -70 120 0 #000080 2 1>
  <Line 60 -70 0 200 #000080 2 1>
  <Line -60 130 120 0 #000080 2 1>
  <Line -60 -70 0 200 #000080 2 1>
  <Text 30 -40 12 #000000 0 "Pos">
  <Text 20 80 12 #000000 0 "Neg">
  <Text -50 -40 12 #000000 0 "Input">
  <Text -20 -70 12 #000000 0 "VDD">
</Symbol>
<Components>
  <Port VDD 1 480 210 -72 -23 0 3 "1" 1 "analog" 0>
  <Port Input 1 340 400 -23 12 0 0 "2" 1 "analog" 0>
  <Port Positive 1 550 530 4 -50 0 2 "3" 1 "analog" 0>
  <MOS_SPICE X3 0 170 40 -26 34 0 0 "X" 1 "4" 1 "nmos" 1 "nfet_03v3 L=0.30u W=10.00u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0 "" 0 "" 0 "" 0>
  <GND * 1 520 420 0 0 0 0>
  <Port Negative 1 560 350 4 -50 0 2 "4" 1 "analog" 0>
  <GND * 1 480 640 0 0 0 0>
  <R R1 1 480 260 15 -26 0 1 "10 kOhm" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "US" 0>
  <R R2 1 480 590 15 -26 0 1 "10 kOhm" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "US" 0>
  <MOS_SPICE X2 1 480 400 -26 34 0 0 "X" 1 "4" 1 "nmos" 1 "nfet_03v3 L=0.3u W=1.00u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0 "" 0 "" 0 "" 0>
</Components>
<Wires>
  <340 400 450 400 "" 0 0 0 "">
  <500 400 520 400 "" 0 0 0 "">
  <520 400 520 420 "" 0 0 0 "">
  <480 430 480 530 "" 0 0 0 "">
  <480 210 480 230 "" 0 0 0 "">
  <480 350 480 370 "" 0 0 0 "">
  <480 350 560 350 "" 0 0 0 "">
  <480 290 480 350 "" 0 0 0 "">
  <480 530 480 560 "" 0 0 0 "">
  <480 530 550 530 "" 0 0 0 "">
  <480 620 480 640 "" 0 0 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
</Paintings>
