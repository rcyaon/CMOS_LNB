<Qucs Schematic 26.1.1>
<Properties>
  <View=-360,-500,250,230,1,0,0>
  <Grid=10,10,1>
  <DataSet=inv_cs.dat>
  <DataDisplay=inv_cs.dpl>
  <OpenDisplay=0>
  <Script=inv_cs.m>
  <RunScript=0>
  <showFrame=0>
  <FrameText0=Title>
  <FrameText1=Drawn By:>
  <FrameText2=Date:>
  <FrameText3=Revision:>
</Properties>
<Symbol>
  <Text -30 -6 10 #000000 0 "inv_cs">
  <Line 130 -90 -260 0 #000080 2 1>
  <Line -130 -90 0 180 #000080 2 1>
  <Line -130 90 260 0 #000080 2 1>
  <Line 130 90 0 -180 #000080 2 1>
  <Line -130 -80 -20 0 #000080 2 1>
  <Text -125 -84 7 #000000 0 "vdd">
  <Line -130 -60 -20 0 #000080 2 1>
  <Text -125 -64 7 #000000 0 "in">
  <Line -130 -40 -20 0 #000080 2 1>
  <Text -125 -44 7 #000000 0 "vp">
  <Line -130 -20 -20 0 #000080 2 1>
  <Text -125 -24 7 #000000 0 "vn">
  <Line 130 -70 20 0 #000080 2 1>
  <Text 112 -74 7 #000000 0 "out">
  <.PortSym 150 -70 1 0>
  <.PortSym -150 -80 2 0>
  <.PortSym -150 -60 3 0>
  <.PortSym -150 -40 4 0>
  <.PortSym -150 -20 5 0>
  <.ID -130 10 X "1=wn=4u==" "1=wp=10u==" "1=wsn=8u==" "1=wsp=20u==">
</Symbol>
<Components>
  <SpLib M4 1 20 -260 35 -30 0 0 "gf180mcu_models.spice" 0 "pfet_06v0" 1 "symbols/pfet3_06v0.sym" 0 "L=0.55u W=wsp nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <SpLib M2 1 20 -140 35 -30 0 0 "gf180mcu_models.spice" 0 "pfet_06v0" 1 "symbols/pfet3_06v0.sym" 0 "L=0.55u W=wp nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <GND * 1 50 -20 0 0 0 0>
  <SpLib M1 1 20 -20 35 -30 0 0 "gf180mcu_models.spice" 0 "nfet_06v0" 1 "symbols/nfet3_06v0.sym" 0 "L=0.70u W=wn nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <GND * 1 50 100 0 0 0 0>
  <SpLib M3 1 20 100 35 -30 0 0 "gf180mcu_models.spice" 0 "nfet_06v0" 1 "symbols/nfet3_06v0.sym" 0 "L=0.70u W=wsn nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <GND * 1 40 130 0 0 0 0>
  <Port P2 1 -260 -260 -23 12 0 0 "2" 1 "analog" 0>
  <Port P3 1 -260 -230 -23 12 0 0 "3" 1 "analog" 0>
  <Port P4 1 -260 -200 -23 12 0 0 "4" 1 "analog" 0>
  <Port P5 1 -260 -170 -23 12 0 0 "5" 1 "analog" 0>
  <Port P1 1 -260 -140 -23 12 0 0 "1" 1 "analog" 0>
</Components>
<Wires>
  <50 -260 50 -260 "vdd" 60 -280 0 "">
  <40 -230 40 -230 "sp" 50 -250 0 "">
  <0 -260 0 -260 "vp" 10 -280 0 "">
  <40 -290 40 -290 "vdd" 50 -310 0 "">
  <50 -140 50 -140 "vdd" 60 -160 0 "">
  <40 -110 40 -110 "out" 50 -130 0 "">
  <0 -140 0 -140 "in" 10 -160 0 "">
  <40 -170 40 -170 "sp" 50 -190 0 "">
  <40 -50 40 -50 "out" 50 -70 0 "">
  <0 -20 0 -20 "in" 10 -40 0 "">
  <40 10 40 10 "sn" 50 -10 0 "">
  <40 70 40 70 "sn" 50 50 0 "">
  <0 100 0 100 "vn" 10 80 0 "">
  <-260 -260 -260 -260 "vdd" -250 -280 0 "">
  <-260 -230 -260 -230 "in" -250 -250 0 "">
  <-260 -200 -260 -200 "vp" -250 -220 0 "">
  <-260 -170 -260 -170 "vn" -250 -190 0 "">
  <-260 -140 -260 -140 "out" -250 -160 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
  <Text 55 -240 8 #606060 0 "wsp / 0.55u">
  <Text 55 -120 8 #606060 0 "wp / 0.55u">
  <Text 55 0 8 #606060 0 "wn / 0.70u">
  <Text 55 120 8 #606060 0 "wsn / 0.70u">
  <Text -260 -400 10 #000000 0 "Current-starved 6 V inverter.  M4 / M3 limit the charge / discharge\ncurrent (gates from the ring's bias mirror); M2 / M1 switch.\nSizes are instance parameters (symbol default 4/10 switch, 8/20 starve).">
</Paintings>
