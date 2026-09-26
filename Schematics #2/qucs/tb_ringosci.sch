<Qucs Schematic 26.1.1>
<Properties>
  <View=-720,-360,260,980,1,0,0>
  <Grid=10,10,1>
  <DataSet=tb_ringosci.dat>
  <DataDisplay=tb_ringosci.dpl>
  <OpenDisplay=0>
  <Script=tb_ringosci.m>
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
  <S4Q_V V1 1 -460 0 18 -26 0 1 "pwl(0 0 1n 5)" 1 "" 0 "" 0 "" 0 "" 0>
  <GND * 1 -460 50 0 0 0 0>
  <S4Q_I I1 1 -460 250 18 -26 0 1 "80u" 1 "" 0 "" 0 "" 0 "" 0>
  <Sub X1 1 -150 0 -40 60 0 0 "ringosci.sch" 0>
  <C C1 1 60 60 17 -26 0 1 "50f" 1 "" 0 "neutral" 0>
  <GND * 1 60 110 0 0 0 0>
  <.CUSTOMSIM CUSTOM1 1 -580 600 0 40 0 0 "\ntran 1p 30n 0 1p\nmeas tran t1 WHEN v(lo)=2.5 RISE=10\nmeas tran t2 WHEN v(lo)=2.5 RISE=30\nlet fosc_ghz = 20/(t2-t1)/1e9\nprint fosc_ghz\nlet idd = -i(v1)*1e3\nwrite tb_ringosci.raw v(lo) v(vdd) idd\n" 1 "v(lo);v(vdd);idd" 0 "" 0>
</Components>
<Wires>
  <-460 30 -460 50 "" 0 0 0 "">
  <60 90 60 110 "" 0 0 0 "">
  <-460 -30 -460 -30 "vdd" -450 -50 0 "">
  <-460 220 -460 220 "vdd" -450 200 0 "">
  <-460 280 -460 280 "ictl" -450 260 0 "">
  <-300 -40 -300 -40 "vdd" -290 -60 0 "">
  <-300 -20 -300 -20 "ictl" -290 -40 0 "">
  <0 -30 0 -30 "lo" 10 -50 0 "">
  <60 30 60 30 "lo" 70 10 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
  <Text -460 -150 10 #000000 0 "ictl = 80 uA (stands in for the iDAC); 50 fF on lo stands in for the mixer LO input">
</Paintings>
