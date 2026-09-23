v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {devices/vsource.sym} -560 0 0 0 {name=V1
value="pwl(0 0 1u 5)"}
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
tran 5n 20u
meas tran t30 WHEN v(o30)=2.97 RISE=1
meas tran t20 WHEN v(o20)=1.98 RISE=1
meas tran t07 WHEN v(o07)=0.693 RISE=1
write tb_vref_powerup.raw v(vdd) v(o07) v(o20) v(o30)
.endc"}
C {devices/launcher.sym} -600 -260 0 0 {name=h1
descr="ctrl-click: load / unload tb_vref_powerup.raw"
tclcommand="xschem raw_read $netlist_dir/tb_vref_powerup.raw"}
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
color="6 5 4 10"
node="vdd;vdd
o07;o07
o20;o20
o30;o30"
x1=0.0
x2=1.9999999999999998e-05
y1=-0.3
y2=5.3}
