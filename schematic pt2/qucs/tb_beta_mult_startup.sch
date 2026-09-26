<Qucs Schematic 26.1.1>
<Properties>
  <View=-720,-360,100,980,1,0,0>
  <Grid=10,10,1>
  <DataSet=tb_beta_mult_startup.dat>
  <DataDisplay=tb_beta_mult_startup.dpl>
  <OpenDisplay=0>
  <Script=tb_beta_mult_startup.m>
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
  <S4Q_V Von 1 -560 -60 18 -26 0 1 "5" 1 "" 0 "" 0 "" 0 "" 0>
  <GND * 1 -560 -10 0 0 0 0>
  <S4Q_V Voff 1 -560 240 18 -26 0 1 "5" 1 "" 0 "" 0 "" 0 "" 0>
  <GND * 1 -560 290 0 0 0 0>
  <Sub Xon 1 -250 -60 -40 60 0 0 "beta_mult.sch" 0>
  <Sub Xoff 1 -250 240 -40 60 0 0 "beta_mult.sch" 0>
  <GND * 1 -400 270 0 0 0 0>
  <SpiceIC SpiceIC1 1 -580 520 -9 17 0 0 "v(pg_on)=5" 1 "v(ng_on)=0" 1 "v(ns_on)=0" 1 "v(s1_on)=0" 1 "v(pg_off)=5" 1 "v(ng_off)=0" 1 "v(ns_off)=0" 1 "v(s1_off)=0" 1>
  <.CUSTOMSIM CUSTOM1 1 -580 600 0 40 0 0 "\nsave all @m.xon.xm7.m0[id] @m.xoff.xm7.m0[id]\ntran 2n 2u uic\nlet iref_on = @m.xon.xm7.m0[id]*1e6\nlet iref_off = @m.xoff.xm7.m0[id]*1e6\nwrite tb_beta_mult_startup.raw iref_on iref_off v(pg_on) v(pg_off) v(s1_on)\n" 1 "iref_on;iref_off;v(pg_on);v(pg_off);v(s1_on)" 0 "" 0>
</Components>
<Wires>
  <-560 -30 -560 -10 "" 0 0 0 "">
  <-560 270 -560 290 "" 0 0 0 "">
  <-400 250 -400 270 "" 0 0 0 "">
  <-560 -90 -560 -90 "vdd_on" -550 -110 0 "">
  <-560 210 -560 210 "vdd_off" -550 190 0 "">
  <-400 -90 -400 -90 "vdd_on" -390 -110 0 "">
  <-400 -70 -400 -70 "vdd_on" -390 -90 0 "">
  <-400 -50 -400 -50 "s1_on" -390 -70 0 "">
  <-100 -90 -100 -90 "pg_on" -90 -110 0 "">
  <-100 -70 -100 -70 "ng_on" -90 -90 0 "">
  <-100 -50 -100 -50 "ns_on" -90 -70 0 "">
  <-100 -30 -100 -30 "s1_on" -90 -50 0 "">
  <-400 210 -400 210 "vdd_off" -390 190 0 "">
  <-400 230 -400 230 "vdd_off" -390 210 0 "">
  <-100 210 -100 210 "pg_off" -90 190 0 "">
  <-100 230 -100 230 "ng_off" -90 210 0 "">
  <-100 250 -100 250 "ns_off" -90 230 0 "">
  <-100 270 -100 270 "s1_off" -90 250 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
  <Text -420 -150 10 #000000 0 "kick ON: kg tied to s1 (the real circuit)">
  <Text -420 150 10 #000000 0 "kick OFF: kg tied to 0 (negative control)">
</Paintings>
