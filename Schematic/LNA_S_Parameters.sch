<Qucs Schematic 26.1.1>
<Properties>
  <View=-7458,-1175,13613,2935,0.67275,4306,376>
  <Grid=10,10,1>
  <DataSet=LNA_S_Parameters.dat>
  <DataDisplay=LNA_S_Parameters.dpl>
  <OpenDisplay=0>
  <Script=LNA_S_Parameters.m>
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
  <GND * 1 -710 730 0 0 0 0>
  <GND * 1 -920 480 0 0 0 0>
  <GND * 1 -540 300 0 0 0 0>
  <SpiceInclude SpiceInclude1 1 -1140 -370 -37 16 0 0 "/foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice" 1 "" 0 "" 0 "" 0 "" 0>
  <GND * 1 -340 300 0 0 0 0>
  <C C3 1 750 380 -26 -55 0 2 "1 pF" 1 "" 0 "neutral" 0>
  <Vdc V1 1 -540 140 18 -26 0 1 "5V" 1>
  <MOS_SPICE X1 1 -340 110 0 34 1 2 "X" 1 "4" 1 "pmos" 1 "pfet_06v0 L=0.5u W=0.3u nf=1 ad='int((nf+1)/2) * W/nf * 0.18u' as='int((nf+2)/2) * W/nf * 0.18u' pd='2*int((nf+1)/2) * (W/nf + 0.18u)' ps='2*int((nf+2)/2) * (W/nf + 0.18u)' nrd='0.18u / W' nrs='0.18u / W' sa=0 sb=0 sd=0" 0 "" 0 "" 0 "" 0 "" 0>
  <Idc I1 1 -340 250 -77 -26 0 3 "11 uA" 1>
  <Vdc V3 1 -710 680 18 -26 0 1 "2 V" 1>
  <Sub SUB5 1 510 350 -26 215 0 0 "/foss/designs/LNA/MkII/Schematic/AmpCore.sch" 0>
  <Sub SUB6 1 -120 350 -26 215 0 0 "/foss/designs/LNA/MkII/Schematic/AmpCore.sch" 0>
  <Sub SUB7 1 190 350 -26 215 0 0 "/foss/designs/LNA/MkII/Schematic/AmpCore.sch" 0>
  <Sub SUB1 1 -670 410 -26 95 0 0 "/foss/designs/LNA/MkII/Schematic/ImpedanceMatching.sch" 0>
  <Pac P1 1 -920 430 18 -26 0 1 "1" 1 "50 Ohm" 1 "-50 dBm" 0 "1.7 GHz" 0 "26.85" 0 "true" 0 "false" 0>
  <SpiceLib SpiceLib1 1 -1160 -280 -14 16 0 0 "/foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice" 1 "typical" 1>
  <GND * 1 800 480 0 0 0 0>
  <.SP SP1 1 -1470 -380 0 50 0 0 "lin" 1 "1 MHz" 1 "3 GHz" 1 "200" 1 "no" 0 "1" 0 "2" 0 "no" 0 "no" 0>
  <Pac P2 1 800 430 18 -26 0 1 "2" 1 "50000 Ohm" 1 "-50 dBm" 0 "1.7 GHz" 0 "26.85" 0 "true" 0 "false" 0>
  <NutmegEq NutmegEq1 1 -490 -350 -31 16 0 0 "SP1" 1 "r_out=50000" 1 "r_in=50" 1 "dBV=dB(sqrt(s_2_1 * r_out/r_in))" 1>
</Components>
<Wires>
  <-710 710 -710 730 "" 0 0 0 "">
  <-640 380 -200 380 "HiZ_input_dc" -530 450 88 "">
  <-540 170 -540 300 "" 0 0 0 "">
  <-540 40 -340 40 "" 0 0 0 "">
  <-540 40 -540 110 "" 0 0 0 "">
  <-340 40 -120 40 "" 0 0 0 "">
  <-340 40 -340 60 "" 0 0 0 "">
  <-260 330 -200 330 "" 0 0 0 "">
  <-120 40 190 40 "" 0 0 0 "">
  <-340 140 -340 160 "" 0 0 0 "">
  <-310 110 -290 110 "" 0 0 0 "">
  <-340 280 -340 300 "" 0 0 0 "">
  <-290 110 -290 160 "" 0 0 0 "">
  <-340 160 -340 220 "" 0 0 0 "">
  <-340 160 -290 160 "" 0 0 0 "">
  <-340 60 -340 80 "" 0 0 0 "">
  <-380 110 -360 110 "" 0 0 0 "">
  <-380 60 -380 110 "" 0 0 0 "">
  <-380 60 -340 60 "" 0 0 0 "">
  <-40 380 110 380 "lna_stage_1_dc" 120 500 140 "">
  <270 380 430 380 "lna_stage_2_dc" 430 510 143 "">
  <90 330 110 330 "" 0 0 0 "">
  <190 40 510 40 "" 0 0 0 "">
  <-260 160 -20 160 "amp_bias_dc" -40 110 184 "">
  <-40 430 -30 430 "" 0 0 0 "">
  <-30 630 280 630 "" 0 0 0 "">
  <270 430 280 430 "" 0 0 0 "">
  <280 630 610 630 "" 0 0 0 "">
  <590 430 610 430 "" 0 0 0 "">
  <-710 630 -710 650 "" 0 0 0 "">
  <-260 160 -260 330 "" 0 0 0 "">
  <90 160 90 330 "" 0 0 0 "">
  <90 160 290 160 "" 0 0 0 "">
  <410 160 410 330 "" 0 0 0 "">
  <410 330 430 330 "" 0 0 0 "">
  <-120 40 -120 290 "" 0 0 0 "">
  <190 40 190 290 "" 0 0 0 "">
  <510 40 510 290 "" 0 0 0 "">
  <-290 160 -260 160 "" 0 0 0 "">
  <590 330 610 330 "" 0 0 0 "">
  <610 160 610 330 "" 0 0 0 "">
  <270 330 290 330 "" 0 0 0 "">
  <290 160 410 160 "" 0 0 0 "">
  <290 160 290 330 "" 0 0 0 "">
  <-40 330 -20 330 "" 0 0 0 "">
  <-20 160 90 160 "" 0 0 0 "">
  <-20 160 -20 330 "" 0 0 0 "">
  <780 380 800 380 "" 0 0 0 "">
  <-710 630 -30 630 "" 0 0 0 "">
  <-920 380 -780 380 "input" -750 330 115 "">
  <-710 460 -710 630 "" 0 0 0 "">
  <610 430 610 630 "" 0 0 0 "">
  <280 430 280 630 "" 0 0 0 "">
  <-30 430 -30 630 "" 0 0 0 "">
  <410 160 610 160 "" 0 0 0 "">
  <590 380 720 380 "lna_output_dc" 710 290 24 "">
  <-920 480 -920 460 "" 0 0 0 "">
  <-920 400 -920 380 "" 0 0 0 "">
  <800 460 800 480 "" 0 0 0 "">
  <800 380 800 400 "" 0 0 0 "">
</Wires>
<Diagrams>
  <Tab -1490 -53 1712 117 3 #c0c0c0 1 00 1 0 1 1 1 0 1 1 1 0 1 1 315 0 225 1 0 0 "" "" "">
	<"ngspice/v(input)" #0000ff 0 3 0 0 0>
	<"ngspice/v(hiz_input_dc)" #0000ff 0 3 0 0 0>
	<"ngspice/v(lna_stage_1_dc)" #0000ff 0 3 0 0 0>
	<"ngspice/v(lna_stage_2_dc)" #0000ff 0 3 0 0 0>
	<"ngspice/v(lna_output_dc)" #0000ff 0 3 0 0 0>
	<"ngspice/v(g_cell_t_bias)" #0000ff 0 3 1 0 0>
	<"ngspice/v(if_pos_dc)" #0000ff 0 3 1 0 0>
	<"ngspice/v(if_neg_dc)" #0000ff 0 3 1 0 0>
	<"ngspice/v(rf_neg)" #0000ff 0 3 1 0 0>
	<"ngspice/v(rf_pos)" #0000ff 0 3 1 0 0>
	<"ngspice/v(amp_bias_dc)" #0000ff 0 3 0 0 0>
  </Tab>
  <Rect 350 -67 707 447 3 #c0c0c0 1 00 1 0 2e+08 3e+09 1 -0.272139 0.5 3 1 -1 0.2 1 315 0 225 1 0 0 "" "" "">
	<"ngspice/ac.dbv" #ff0000 0 3 0 0 0>
  </Rect>
</Diagrams>
<Paintings>
  <Rectangle -580 10 1270 940 #000000 1 1 #c0c0c0 1 0>
  <Text -570 -20 12 #000000 0 "Low Noise Amplifier">
  <Rectangle -830 10 230 940 #000000 1 1 #c0c0c0 1 0>
  <Text -830 -20 12 #000000 0 "Impedance Matching">
</Paintings>
