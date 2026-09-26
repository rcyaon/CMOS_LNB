<Qucs Schematic 26.1.1>
<Properties>
  <View=-300,-360,250,110,1,0,0>
  <Grid=10,10,1>
  <DataSet=inv.dat>
  <DataDisplay=inv.dpl>
  <OpenDisplay=0>
  <Script=inv.m>
  <RunScript=0>
  <showFrame=0>
  <FrameText0=Title>
  <FrameText1=Drawn By:>
  <FrameText2=Date:>
  <FrameText3=Revision:>
</Properties>
<Symbol>
  <Text -30 -6 10 #000000 0 "inv">
  <Line 130 -50 -260 0 #000080 2 1>
  <Line -130 -50 0 100 #000080 2 1>
  <Line -130 50 260 0 #000080 2 1>
  <Line 130 50 0 -100 #000080 2 1>
  <Line -130 -40 -20 0 #000080 2 1>
  <Text -125 -44 7 #000000 0 "vdd">
  <Line -130 -20 -20 0 #000080 2 1>
  <Text -125 -24 7 #000000 0 "in">
  <Line 130 -30 20 0 #000080 2 1>
  <Text 112 -34 7 #000000 0 "out">
  <.PortSym 150 -30 1 0>
  <.PortSym -150 -40 2 0>
  <.PortSym -150 -20 3 0>
  <.ID -130 10 X "1=wn=2u==" "1=wp=5u==">
</Symbol>
<Components>
  <SpLib M2 1 20 -140 35 -30 0 0 "gf180mcu_models.spice" 0 "pfet_06v0" 1 "symbols/pfet3_06v0.sym" 0 "L=0.55u W=wp nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <GND * 1 50 -20 0 0 0 0>
  <SpLib M1 1 20 -20 35 -30 0 0 "gf180mcu_models.spice" 0 "nfet_06v0" 1 "symbols/nfet3_06v0.sym" 0 "L=0.70u W=wn nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <GND * 1 40 10 0 0 0 0>
  <Port P2 1 -180 -130 -23 12 0 0 "2" 1 "analog" 0>
  <Port P3 1 -180 -100 -23 12 0 0 "3" 1 "analog" 0>
  <Port P1 1 -200 -160 -23 12 0 0 "1" 1 "analog" 0>
</Components>
<Wires>
  <50 -140 50 -140 "vdd" 60 -160 0 "">
  <40 -110 40 -110 "out" 50 -130 0 "">
  <0 -140 0 -140 "in" 10 -160 0 "">
  <40 -170 40 -170 "vdd" 50 -190 0 "">
  <40 -50 40 -50 "out" 50 -70 0 "">
  <0 -20 0 -20 "in" 10 -40 0 "">
  <-180 -130 -180 -130 "vdd" -170 -150 0 "">
  <-180 -100 -180 -100 "in" -170 -120 0 "">
  <-200 -160 -200 -160 "out" -190 -180 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
  <Text 55 -120 8 #606060 0 "wp / 0.55u">
  <Text 55 0 8 #606060 0 "wn / 0.70u">
  <Text -200 -260 10 #000000 0 "6 V inverter.  wn / wp are instance parameters\n(symbol default 2u / 5u).">
</Paintings>
