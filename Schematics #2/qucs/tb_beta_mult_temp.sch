<Qucs Schematic 26.1.1>
<Properties>
  <View=-720,-360,100,980,1,0,0>
  <Grid=10,10,1>
  <DataSet=tb_beta_mult_temp.dat>
  <DataDisplay=tb_beta_mult_temp.dpl>
  <OpenDisplay=0>
  <Script=tb_beta_mult_temp.m>
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
  <S4Q_V V1 1 -560 0 18 -26 0 1 "5" 1 "" 0 "" 0 "" 0 "" 0>
  <GND * 1 -560 50 0 0 0 0>
  <Sub X1 1 -250 0 -40 60 0 0 "beta_mult.sch" 0>
  <.CUSTOMSIM CUSTOM1 1 -580 600 0 40 0 0 "\nsave all @m.x1.xm7.m0[id]\ndc temp -25 125 1\nlet iref = @m.x1.xm7.m0[id]*1e6\nlet idd = -i(v1)*1e6\nwrite tb_beta_mult_temp.raw iref idd\n" 1 "iref;idd" 0 "" 0>
</Components>
<Wires>
  <-560 30 -560 50 "" 0 0 0 "">
  <-560 -30 -560 -30 "vdd" -550 -50 0 "">
  <-400 -30 -400 -30 "vdd" -390 -50 0 "">
  <-400 -10 -400 -10 "vdd" -390 -30 0 "">
  <-400 10 -400 10 "s1" -390 -10 0 "">
  <-100 -30 -100 -30 "pg" -90 -50 0 "">
  <-100 -10 -100 -10 "ng" -90 -30 0 "">
  <-100 10 -100 10 "ns" -90 -10 0 "">
  <-100 30 -100 30 "s1" -90 10 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
</Paintings>
