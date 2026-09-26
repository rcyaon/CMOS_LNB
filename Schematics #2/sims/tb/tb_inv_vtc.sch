v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {devices/vsource.sym} -460 0 0 0 {name=V1
value="5"}
C {devices/lab_pin.sym} -460 -30 0 0 {name=l1 sig_type=std_logic lab=vdd}
C {devices/gnd.sym} -460 50 0 0 {name=g2 lab=GND}
N -460 30 -460 50 {lab=GND}
C {devices/vsource.sym} -460 250 0 0 {name=Vin
value="0"}
C {devices/lab_pin.sym} -460 220 0 0 {name=l3 sig_type=std_logic lab=in}
C {devices/gnd.sym} -460 300 0 0 {name=g4 lab=GND}
N -460 280 -460 300 {lab=GND}
C {xschem/inv.sym} -100 0 0 0 {name=X1}
C {devices/lab_pin.sym} 50.0 -10.0 0 1 {name=l5 sig_type=std_logic lab=out}
C {devices/lab_pin.sym} -250.0 -10.0 0 0 {name=l6 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -250.0 10.0 0 0 {name=l7 sig_type=std_logic lab=in}
C {devices/code_shown.sym} -620 420 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value=".include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice mimcap_typical
.lib $::180MCU_MODELS/sm141064.ngspice cap_mim"}
C {devices/code_shown.sym} -620 580 0 0 {name=NGSPICE only_toplevel=true
value=".control
dc vin 0 5 0.001
let gain = -deriv(v(out))
write tb_inv_vtc.raw v(out) gain
.endc"}
C {devices/launcher.sym} -600 -260 0 0 {name=h1
descr="ctrl-click: load / unload tb_inv_vtc.raw"
tclcommand="xschem raw_read $netlist_dir/tb_inv_vtc.raw"}
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
color="6"
node="out;out"
x1=0.0
x2=5.000000000000004
y1=-0.2999999929979425
y2=5.299999992343456}
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
color="6"
node="|dVout/dVin|;gain"
x1=0.0
x2=5.000000000000004
y1=-1.490635753043484
y2=26.334564980167592}
