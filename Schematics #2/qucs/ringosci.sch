<Qucs Schematic 26.1.1>
<Properties>
  <View=-700,-570,1790,270,1,0,0>
  <Grid=10,10,1>
  <DataSet=ringosci.dat>
  <DataDisplay=ringosci.dpl>
  <OpenDisplay=0>
  <Script=ringosci.m>
  <RunScript=0>
  <showFrame=0>
  <FrameText0=Title>
  <FrameText1=Drawn By:>
  <FrameText2=Date:>
  <FrameText3=Revision:>
</Properties>
<Symbol>
  <Text -30 -6 10 #000000 0 "ringosci">
  <Line 130 -50 -260 0 #000080 2 1>
  <Line -130 -50 0 100 #000080 2 1>
  <Line -130 50 260 0 #000080 2 1>
  <Line 130 50 0 -100 #000080 2 1>
  <Line -130 -40 -20 0 #000080 2 1>
  <Text -125 -44 7 #000000 0 "vdd">
  <Line -130 -20 -20 0 #000080 2 1>
  <Text -125 -24 7 #000000 0 "ictl">
  <Line 130 -30 20 0 #000080 2 1>
  <Text 117 -34 7 #000000 0 "lo">
  <.PortSym -150 -40 1 0>
  <.PortSym -150 -20 2 0>
  <.PortSym 150 -30 3 0>
  <.ID -130 10 X>
</Symbol>
<Components>
  <GND * 1 -530 60 0 0 0 0>
  <SpLib MB1 1 -560 60 35 -30 0 0 "gf180mcu_models.spice" 0 "nfet_06v0" 1 "symbols/nfet3_06v0.sym" 0 "L=0.70u W=0.5u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <GND * 1 -540 90 0 0 0 0>
  <GND * 1 -350 60 0 0 0 0>
  <SpLib MB2 1 -380 60 35 -30 0 0 "gf180mcu_models.spice" 0 "nfet_06v0" 1 "symbols/nfet3_06v0.sym" 0 "L=0.70u W=0.5u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <GND * 1 -360 90 0 0 0 0>
  <SpLib MB3 1 -380 -80 35 -30 0 0 "gf180mcu_models.spice" 0 "pfet_06v0" 1 "symbols/pfet3_06v0.sym" 0 "L=0.55u W=1.25u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <Sub xr1 1 -40 -40 -40 60 0 0 "inv_cs.sch" 0 "4u" 1 "10u" 1 "8u" 1 "20u" 1>
  <GND * 1 10 140 0 0 0 0>
  <SpLib MC1 1 -20 140 35 -30 0 0 "gf180mcu_models.spice" 0 "nfet_06v0" 1 "symbols/nfet3_06v0.sym" 0 "L=2u W=2u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <GND * 1 0 110 0 0 0 0>
  <GND * 1 0 170 0 0 0 0>
  <Sub xr2 1 320 -40 -40 60 0 0 "inv_cs.sch" 0 "4u" 1 "10u" 1 "8u" 1 "20u" 1>
  <GND * 1 370 140 0 0 0 0>
  <SpLib MC2 1 340 140 35 -30 0 0 "gf180mcu_models.spice" 0 "nfet_06v0" 1 "symbols/nfet3_06v0.sym" 0 "L=2u W=2u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <GND * 1 360 110 0 0 0 0>
  <GND * 1 360 170 0 0 0 0>
  <Sub xr3 1 680 -40 -40 60 0 0 "inv_cs.sch" 0 "4u" 1 "10u" 1 "8u" 1 "20u" 1>
  <GND * 1 730 140 0 0 0 0>
  <SpLib MC3 1 700 140 35 -30 0 0 "gf180mcu_models.spice" 0 "nfet_06v0" 1 "symbols/nfet3_06v0.sym" 0 "L=2u W=2u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0>
  <GND * 1 720 110 0 0 0 0>
  <GND * 1 720 170 0 0 0 0>
  <Sub xb1 1 1120 -40 -40 60 0 0 "inv.sch" 0 "1u" 1 "2.5u" 1>
  <Sub xb2 1 1440 -40 -40 60 0 0 "inv.sch" 0 "3u" 1 "7.5u" 1>
  <Port P1 1 -600 -300 -23 12 0 0 "1" 1 "analog" 0>
  <Port P2 1 -600 -270 -23 12 0 0 "2" 1 "analog" 0>
  <Port P3 1 -600 -240 -23 12 0 0 "3" 1 "analog" 0>
</Components>
<Wires>
  <-540 30 -540 30 "ictl" -530 10 0 "">
  <-580 60 -580 60 "ictl" -570 40 0 "">
  <-360 30 -360 30 "vp" -350 10 0 "">
  <-400 60 -400 60 "ictl" -390 40 0 "">
  <-350 -80 -350 -80 "vdd" -340 -100 0 "">
  <-360 -50 -360 -50 "vp" -350 -70 0 "">
  <-400 -80 -400 -80 "vp" -390 -100 0 "">
  <-360 -110 -360 -110 "vdd" -350 -130 0 "">
  <-190 -120 -190 -120 "vdd" -180 -140 0 "">
  <-190 -80 -190 -80 "vp" -180 -100 0 "">
  <-190 -60 -190 -60 "ictl" -180 -80 0 "">
  <110 -110 110 -110 "n2" 120 -130 0 "">
  <-190 -100 -190 -100 "n1" -180 -120 0 "">
  <-40 140 -40 140 "n2" -30 120 0 "">
  <170 -120 170 -120 "vdd" 180 -140 0 "">
  <170 -80 170 -80 "vp" 180 -100 0 "">
  <170 -60 170 -60 "ictl" 180 -80 0 "">
  <470 -110 470 -110 "n3" 480 -130 0 "">
  <170 -100 170 -100 "n2" 180 -120 0 "">
  <320 140 320 140 "n3" 330 120 0 "">
  <530 -120 530 -120 "vdd" 540 -140 0 "">
  <530 -80 530 -80 "vp" 540 -100 0 "">
  <530 -60 530 -60 "ictl" 540 -80 0 "">
  <830 -110 830 -110 "n1" 840 -130 0 "">
  <530 -100 530 -100 "n3" 540 -120 0 "">
  <680 140 680 140 "n1" 690 120 0 "">
  <970 -80 970 -80 "vdd" 980 -100 0 "">
  <1270 -70 1270 -70 "b1" 1280 -90 0 "">
  <970 -60 970 -60 "n1" 980 -80 0 "">
  <1290 -80 1290 -80 "vdd" 1300 -100 0 "">
  <1590 -70 1590 -70 "lo" 1600 -90 0 "">
  <1290 -60 1290 -60 "b1" 1300 -80 0 "">
  <-600 -300 -600 -300 "vdd" -590 -320 0 "">
  <-600 -270 -600 -270 "ictl" -590 -290 0 "">
  <-600 -240 -600 -240 "lo" -590 -260 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
  <Text -525 80 8 #606060 0 "0.5u / 0.70u">
  <Text -345 80 8 #606060 0 "0.5u / 0.70u">
  <Text -345 -60 8 #606060 0 "1.25u / 0.55u">
  <Text 15 160 8 #606060 0 "2u / 2u">
  <Text 375 160 8 #606060 0 "2u / 2u">
  <Text 735 160 8 #606060 0 "2u / 2u">
  <Text -600 -470 10 #000000 0 "Current-starved 3-stage ring + 2 buffers, 6 V devices, 5 V supply.\nfosc is set by ictl (sourced into the cell, e.g. by an iDAC): MB1 makes vn for the\nstarve nFETs, MB2/MB3 make vp for the starve pFETs.  Mirror ratio 1:16.\n~9 fF nFET gate cap on each ring node (a 5 um minimum MIM is ~58 fF, too big).\nxb1 is small so it barely loads n1; xb2 drives lo.  tt/27 C: ~1.2 GHz at ictl ~80 uA.">
</Paintings>
