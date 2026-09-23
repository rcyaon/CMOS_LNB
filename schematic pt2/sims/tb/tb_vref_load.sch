v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {devices/vsource.sym} -560 0 0 0 {name=V1
value="5"}
C {devices/lab_pin.sym} -560 -30 0 0 {name=l1 sig_type=std_logic lab=vdd}
C {devices/gnd.sym} -560 50 0 0 {name=g2 lab=GND}
N -560 30 -560 50 {lab=GND}
C {devices/vsource.sym} -560 300 0 0 {name=Vctl
value="0"}
C {devices/lab_pin.sym} -560 270 0 0 {name=l3 sig_type=std_logic lab=ctl}
C {devices/gnd.sym} -560 350 0 0 {name=g4 lab=GND}
N -560 330 -560 350 {lab=GND}
C {xschem/beta_mult.sym} -250 0 0 0 {name=Xbias}
C {devices/lab_pin.sym} -400.0 -30.0 0 0 {name=l5 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -400.0 -10.0 0 0 {name=l6 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -400.0 10.0 0 0 {name=l7 sig_type=std_logic lab=s1}
C {devices/lab_pin.sym} -100.0 -30.0 0 1 {name=l8 sig_type=std_logic lab=pg}
C {devices/lab_pin.sym} -100.0 -10.0 0 1 {name=l9 sig_type=std_logic lab=ng}
C {devices/lab_pin.sym} -100.0 10.0 0 1 {name=l10 sig_type=std_logic lab=ns}
C {devices/lab_pin.sym} -100.0 30.0 0 1 {name=l11 sig_type=std_logic lab=s1}
C {xschem/vref.sym} 180 0 0 0 {name=Xref}
C {devices/lab_pin.sym} 30.0 -20.0 0 0 {name=l12 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 30.0 0.0 0 0 {name=l13 sig_type=std_logic lab=pg}
C {devices/lab_pin.sym} 330.0 -20.0 0 1 {name=l14 sig_type=std_logic lab=o07}
C {devices/lab_pin.sym} 330.0 0.0 0 1 {name=l15 sig_type=std_logic lab=o20}
C {devices/lab_pin.sym} 330.0 20.0 0 1 {name=l16 sig_type=std_logic lab=o30}
C {devices/code_shown.sym} -620 420 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value=".include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice mimcap_typical
.lib $::180MCU_MODELS/sm141064.ngspice cap_mim"}
C {devices/code_shown.sym} -620 580 0 0 {name=NGSPICE only_toplevel=true
value="* load current drawn from every tap = v(ctl) uA
Bl07 o07 0 I=v(ctl)*1u
Bl20 o20 0 I=v(ctl)*1u
Bl30 o30 0 I=v(ctl)*1u
.control
dc vctl 0 20 0.1
* tap droop, mV
let d07 = (v(o07)-v(o07)[0])*1000
let d20 = (v(o20)-v(o20)[0])*1000
let d30 = (v(o30)-v(o30)[0])*1000
write tb_vref_load.raw v(o07) v(o20) v(o30) d07 d20 d30
.endc"}
C {devices/launcher.sym} -600 -260 0 0 {name=h1
descr="ctrl-click: load / unload tb_vref_load.raw"
tclcommand="xschem raw_read $netlist_dir/tb_vref_load.raw"}
B 2 560 -300 1460 120 {flags=graph
divx=5
subdivx=1
divy=5
subdivy=1
unitx=1
unity=1
dataset=-1
linewidth_mult=2
legend=1
color="6 5 4"
node="o07 (V);o07
o20 (V);o20
o30 (V);o30"
x1=0.0
x2=20.000000000000014
y1=-0.38475774531093465
y2=3.192842554565652}
B 2 560 160 1460 580 {flags=graph
divx=5
subdivx=1
divy=5
subdivy=1
unitx=1
unity=1
dataset=-1
linewidth_mult=2
legend=1
color="6 5 4"
node="o07 droop (mV);d07
o20 droop (mV);d20
o30 droop (mV);d30"
x1=0
x2=15
y1=-212.7451381983461
y2=12.042177633868647}
