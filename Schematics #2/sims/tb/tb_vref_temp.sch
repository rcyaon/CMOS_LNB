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
C {xschem/beta_mult.sym} -250 0 0 0 {name=Xbias}
C {devices/lab_pin.sym} -400.0 -30.0 0 0 {name=l3 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -400.0 -10.0 0 0 {name=l4 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -400.0 10.0 0 0 {name=l5 sig_type=std_logic lab=s1}
C {devices/lab_pin.sym} -100.0 -30.0 0 1 {name=l6 sig_type=std_logic lab=pg}
C {devices/lab_pin.sym} -100.0 -10.0 0 1 {name=l7 sig_type=std_logic lab=ng}
C {devices/lab_pin.sym} -100.0 10.0 0 1 {name=l8 sig_type=std_logic lab=ns}
C {devices/lab_pin.sym} -100.0 30.0 0 1 {name=l9 sig_type=std_logic lab=s1}
C {xschem/vref.sym} 180 0 0 0 {name=Xref}
C {devices/lab_pin.sym} 30.0 -20.0 0 0 {name=l10 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 30.0 0.0 0 0 {name=l11 sig_type=std_logic lab=pg}
C {devices/lab_pin.sym} 330.0 -20.0 0 1 {name=l12 sig_type=std_logic lab=o07}
C {devices/lab_pin.sym} 330.0 0.0 0 1 {name=l13 sig_type=std_logic lab=o20}
C {devices/lab_pin.sym} 330.0 20.0 0 1 {name=l14 sig_type=std_logic lab=o30}
C {devices/code_shown.sym} -620 420 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value=".include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice mimcap_typical
.lib $::180MCU_MODELS/sm141064.ngspice cap_mim"}
C {devices/code_shown.sym} -620 580 0 0 {name=NGSPICE only_toplevel=true
value=".control
dc temp -25 125 1
* deviation of each tap from its own 27 C value (index 52), in %
let d07 = 100*(v(o07)/v(o07)[52]-1)
let d20 = 100*(v(o20)/v(o20)[52]-1)
let d30 = 100*(v(o30)/v(o30)[52]-1)
write tb_vref_temp.raw d07 d20 d30 v(o07) v(o20) v(o30)
.endc"}
C {devices/launcher.sym} -600 -260 0 0 {name=h1
descr="ctrl-click: load / unload tb_vref_temp.raw"
tclcommand="xschem raw_read $netlist_dir/tb_vref_temp.raw"}
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
node="o07;d07
o20;d20
o30;d30"
x1=-25.0
x2=125.0
y1=-6.787028166849904
y2=0.9942084280609471}
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
node="o07 (V);o07
o20 (V);o20
o30 (V);o30"
x1=-25.0
x2=125.0
y1=0.5146584471066853
y2=3.1602405460120826}
