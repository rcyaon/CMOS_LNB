<Qucs Schematic 26.1.1>
<Properties>
  <View=-60,-30,770,620,1,0,0>
  <Grid=10,10,1>
  <DataSet=ota5.dat>
  <DataDisplay=ota5.dpl>
  <OpenDisplay=0>
  <Script=ota5.m>
  <RunScript=0>
  <showFrame=0>
  <FrameText0=Title>
  <FrameText1=Drawn By:>
  <FrameText2=Date:>
  <FrameText3=Revision:>
</Properties>
<Symbol>
  <Text -36 -6 10 #000000 0 "ota5">
  <Line 130 -40 -260 0 #000080 2 1>
  <Line -130 -40 0 80 #000080 2 1>
  <Line -130 40 260 0 #000080 2 1>
  <Line 130 40 0 -80 #000080 2 1>
  <Line 130 -30 20 0 #000080 2 1>
  <Text 112 -34 7 #000000 0 "out">
  <Line 130 -10 20 0 #000080 2 1>
  <Text 112 -14 7 #000000 0 "vdd">
  <Line 130 10 20 0 #000080 2 1>
  <Text 117 6 7 #000000 0 "pg">
  <Line 130 30 20 0 #000080 2 1>
  <Text 112 26 7 #000000 0 "inp">
  <.PortSym 150 -30 1 0>
  <.PortSym 150 -10 2 0>
  <.PortSym 150 10 3 0>
  <.PortSym 150 30 4 0>
  <.ID -130 60 X>
</Symbol>
<Components>
  <Port P4 1 410 100 -23 12 0 0 "4" 1 "analog" 0>
  <Port P1 1 440 380 -23 12 0 0 "1" 1 "analog" 0>
  <Port P2 1 410 70 -23 12 0 0 "2" 1 "analog" 0>
  <Port P3 1 570 70 -23 12 0 0 "3" 1 "analog" 0>
  <SpLib M1 1 100 330 35 -30 0 0 "gf180mcu_models.spice" 0 "pfet_06v0" 1 "symbols/pfet3_06v0.sym" 0 "L=2u W=40u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <GND * 1 300 430 0 0 0 0>
  <SpLib M2 1 270 430 35 -30 0 0 "gf180mcu_models.spice" 0 "nfet_06v0" 1 "symbols/nfet3_06v0.sym" 0 "L=2u W=20u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <SpLib M3 1 190 180 35 -30 0 0 "gf180mcu_models.spice" 0 "pfet_06v0" 1 "symbols/pfet3_06v0.sym" 0 "L=2u W=40u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <SpLib M4 1 310 330 -110 -30 0 2 "gf180mcu_models.spice" 0 "pfet_06v0" 1 "symbols/pfet3_06v0.sym" 0 "L=2u W=40u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <GND * 1 110 430 0 0 0 0>
  <SpLib M5 1 140 430 -110 -30 0 2 "gf180mcu_models.spice" 0 "nfet_06v0" 1 "symbols/nfet3_06v0.sym" 0 "L=2u W=20u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <GND * 1 200 520 0 0 0 0>
</Components>
<Wires>
  <130 180 170 180 "" 0 0 0 "">
  <40 330 80 330 "" 0 0 0 "">
  <210 100 210 150 "" 0 0 0 "">
  <120 240 120 300 "" 0 0 0 "">
  <120 240 210 240 "" 0 0 0 "">
  <210 240 290 240 "" 0 0 0 "">
  <290 240 290 300 "" 0 0 0 "">
  <120 360 120 370 "" 0 0 0 "">
  <120 370 120 400 "" 0 0 0 "">
  <290 360 290 380 "" 0 0 0 "">
  <290 380 290 400 "" 0 0 0 "">
  <120 370 200 370 "" 0 0 0 "">
  <200 370 200 430 "" 0 0 0 "">
  <200 430 250 430 "" 0 0 0 "">
  <160 430 200 430 "" 0 0 0 "">
  <120 460 120 500 "" 0 0 0 "">
  <120 500 200 500 "" 0 0 0 "">
  <200 500 290 500 "" 0 0 0 "">
  <290 460 290 500 "" 0 0 0 "">
  <200 500 200 520 "" 0 0 0 "">
  <290 380 370 380 "" 0 0 0 "">
  <370 380 440 380 "" 0 0 0 "">
  <330 330 370 330 "" 0 0 0 "">
  <370 330 370 380 "" 0 0 0 "">
  <210 210 210 240 "" 0 0 0 "">
  <410 100 410 100 "inp" 420 80 0 "">
  <440 380 440 380 "out" 450 360 0 "">
  <410 70 410 70 "vdd" 420 50 0 "">
  <570 70 570 70 "pg" 580 50 0 "">
  <210 100 210 100 "vdd" 220 80 0 "">
  <130 180 130 180 "pg" 140 160 0 "">
  <40 330 40 330 "inp" 50 310 0 "">
  <130 330 130 330 "vdd" 140 310 0 "">
  <220 180 220 180 "vdd" 230 160 0 "">
  <280 330 280 330 "vdd" 290 310 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
  <Text 135 350 8 #606060 0 "40u / 2u">
  <Text 305 450 8 #606060 0 "20u / 2u">
  <Text 225 200 8 #606060 0 "40u / 2u">
  <Text 200 350 8 #606060 0 "40u / 2u">
  <Text 30 450 8 #606060 0 "20u / 2u">
</Paintings>
