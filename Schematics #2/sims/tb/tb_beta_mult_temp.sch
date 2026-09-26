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
C {xschem/beta_mult.sym} -250 0 0 0 {name=X1}
C {devices/lab_pin.sym} -400.0 -30.0 0 0 {name=l3 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -400.0 -10.0 0 0 {name=l4 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -400.0 10.0 0 0 {name=l5 sig_type=std_logic lab=s1}
C {devices/lab_pin.sym} -100.0 -30.0 0 1 {name=l6 sig_type=std_logic lab=pg}
C {devices/lab_pin.sym} -100.0 -10.0 0 1 {name=l7 sig_type=std_logic lab=ng}
C {devices/lab_pin.sym} -100.0 10.0 0 1 {name=l8 sig_type=std_logic lab=ns}
C {devices/lab_pin.sym} -100.0 30.0 0 1 {name=l9 sig_type=std_logic lab=s1}
C {devices/code_shown.sym} -620 420 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value=".include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice mimcap_typical
.lib $::180MCU_MODELS/sm141064.ngspice cap_mim"}
C {devices/code_shown.sym} -620 580 0 0 {name=NGSPICE only_toplevel=true
value=".control
save all @m.x1.xm7.m0[id]
dc temp -25 125 1
let iref = @m.x1.xm7.m0[id]*1e6
let idd = -i(v1)*1e6
write tb_beta_mult_temp.raw iref idd
.endc"}
C {devices/launcher.sym} -600 -260 0 0 {name=h1
descr="ctrl-click: load / unload tb_beta_mult_temp.raw"
tclcommand="xschem raw_read $netlist_dir/tb_beta_mult_temp.raw"}
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
color="6 5"
node="Iref (uA);iref
supply current (uA);idd"
x1=-25.0
x2=125.0
y1=15.663655905128682
y2=43.813501959307416}
