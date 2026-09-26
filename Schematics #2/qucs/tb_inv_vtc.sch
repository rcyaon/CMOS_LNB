<Qucs Schematic 26.1.1>
<Properties>
  <View=-720,-360,250,980,1,0,0>
  <Grid=10,10,1>
  <DataSet=tb_inv_vtc.dat>
  <DataDisplay=tb_inv_vtc.dpl>
  <OpenDisplay=0>
  <Script=tb_inv_vtc.m>
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
  <S4Q_V V1 1 -460 0 18 -26 0 1 "5" 1 "" 0 "" 0 "" 0 "" 0>
  <GND * 1 -460 50 0 0 0 0>
  <S4Q_V Vin 1 -460 250 18 -26 0 1 "0" 1 "" 0 "" 0 "" 0 "" 0>
  <GND * 1 -460 300 0 0 0 0>
  <Sub X1 1 -100 0 -40 60 0 0 "inv.sch" 0 "2u" 1 "5u" 1>
  <.CUSTOMSIM CUSTOM1 1 -580 600 0 40 0 0 "\ndc vin 0 5 0.001\nlet gain = -deriv(v(out))\nwrite tb_inv_vtc.raw v(out) gain\n" 1 "v(out);gain" 0 "" 0>
</Components>
<Wires>
  <-460 30 -460 50 "" 0 0 0 "">
  <-460 280 -460 300 "" 0 0 0 "">
  <-460 -30 -460 -30 "vdd" -450 -50 0 "">
  <-460 220 -460 220 "in" -450 200 0 "">
  <50 -30 50 -30 "out" 60 -50 0 "">
  <-250 -40 -250 -40 "vdd" -240 -60 0 "">
  <-250 -20 -250 -20 "in" -240 -40 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
</Paintings>
