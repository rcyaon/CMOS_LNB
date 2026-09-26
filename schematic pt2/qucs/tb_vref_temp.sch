<Qucs Schematic 26.1.1>
<Properties>
  <View=-720,-360,530,980,1,0,0>
  <Grid=10,10,1>
  <DataSet=tb_vref_temp.dat>
  <DataDisplay=tb_vref_temp.dpl>
  <OpenDisplay=0>
  <Script=tb_vref_temp.m>
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
  <Sub Xbias 1 -250 0 -40 60 0 0 "beta_mult.sch" 0>
  <Sub Xref 1 180 0 -40 60 0 0 "vref.sch" 0>
  <.CUSTOMSIM CUSTOM1 1 -580 600 0 40 0 0 "\ndc temp -25 125 1\n* deviation of each tap from its own 27 C value (index 52), in %\nlet d07 = 100*(v(o07)/v(o07)[52]-1)\nlet d20 = 100*(v(o20)/v(o20)[52]-1)\nlet d30 = 100*(v(o30)/v(o30)[52]-1)\nwrite tb_vref_temp.raw d07 d20 d30 v(o07) v(o20) v(o30)\n" 1 "d07;d20;d30;v(o07);v(o20);v(o30)" 0 "" 0>
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
  <30 -20 30 -20 "vdd" 40 -40 0 "">
  <30 0 30 0 "pg" 40 -20 0 "">
  <330 -20 330 -20 "o07" 340 -40 0 "">
  <330 0 330 0 "o20" 340 -20 0 "">
  <330 20 330 20 "o30" 340 0 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
</Paintings>
