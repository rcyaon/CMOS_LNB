v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {devices/vsource.sym} -560 -60 0 0 {name=Von
value="5"}
C {devices/lab_pin.sym} -560 -90 0 0 {name=l1 sig_type=std_logic lab=vdd_on}
C {devices/gnd.sym} -560 -10 0 0 {name=g2 lab=GND}
N -560 -30 -560 -10 {lab=GND}
C {devices/vsource.sym} -560 240 0 0 {name=Voff
value="5"}
C {devices/lab_pin.sym} -560 210 0 0 {name=l3 sig_type=std_logic lab=vdd_off}
C {devices/gnd.sym} -560 290 0 0 {name=g4 lab=GND}
N -560 270 -560 290 {lab=GND}
C {xschem/beta_mult.sym} -250 -60 0 0 {name=Xon}
C {devices/lab_pin.sym} -400.0 -90.0 0 0 {name=l5 sig_type=std_logic lab=vdd_on}
C {devices/lab_pin.sym} -400.0 -70.0 0 0 {name=l6 sig_type=std_logic lab=vdd_on}
C {devices/lab_pin.sym} -400.0 -50.0 0 0 {name=l7 sig_type=std_logic lab=s1_on}
C {devices/lab_pin.sym} -100.0 -90.0 0 1 {name=l8 sig_type=std_logic lab=pg_on}
C {devices/lab_pin.sym} -100.0 -70.0 0 1 {name=l9 sig_type=std_logic lab=ng_on}
C {devices/lab_pin.sym} -100.0 -50.0 0 1 {name=l10 sig_type=std_logic lab=ns_on}
C {devices/lab_pin.sym} -100.0 -30.0 0 1 {name=l11 sig_type=std_logic lab=s1_on}
C {xschem/beta_mult.sym} -250 240 0 0 {name=Xoff}
C {devices/lab_pin.sym} -400.0 210.0 0 0 {name=l12 sig_type=std_logic lab=vdd_off}
C {devices/lab_pin.sym} -400.0 230.0 0 0 {name=l13 sig_type=std_logic lab=vdd_off}
C {devices/gnd.sym} -400.0 270.0 0 0 {name=g14 lab=GND}
N -400.0 250.0 -400.0 270.0 {lab=GND}
C {devices/lab_pin.sym} -100.0 210.0 0 1 {name=l15 sig_type=std_logic lab=pg_off}
C {devices/lab_pin.sym} -100.0 230.0 0 1 {name=l16 sig_type=std_logic lab=ng_off}
C {devices/lab_pin.sym} -100.0 250.0 0 1 {name=l17 sig_type=std_logic lab=ns_off}
C {devices/lab_pin.sym} -100.0 270.0 0 1 {name=l18 sig_type=std_logic lab=s1_off}
T {kick ON: kg tied to s1 (the real circuit)} -420 -150 0 0 0.3 0.3 {}
T {kick OFF: kg tied to 0 (negative control)} -420 150 0 0 0.3 0.3 {}
C {devices/code_shown.sym} -620 420 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value=".include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice mimcap_typical
.lib $::180MCU_MODELS/sm141064.ngspice cap_mim"}
C {devices/code_shown.sym} -620 580 0 0 {name=NGSPICE only_toplevel=true
value=".ic v(pg_on)=5 v(ng_on)=0 v(ns_on)=0 v(s1_on)=0
.ic v(pg_off)=5 v(ng_off)=0 v(ns_off)=0 v(s1_off)=0
.control
save all @m.xon.xm7.m0[id] @m.xoff.xm7.m0[id]
tran 2n 2u uic
let iref_on = @m.xon.xm7.m0[id]*1e6
let iref_off = @m.xoff.xm7.m0[id]*1e6
write tb_beta_mult_startup.raw iref_on iref_off v(pg_on) v(pg_off) v(s1_on)
.endc"}
C {devices/launcher.sym} -600 -260 0 0 {name=h1
descr="ctrl-click: load / unload tb_beta_mult_startup.raw"
tclcommand="xschem raw_read $netlist_dir/tb_beta_mult_startup.raw"}
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
node="Iref, kick on;iref_on
Iref, kick off;iref_off"
x1=2.0000000000000002e-11
x2=2e-06
y1=-3.224116966445807
y2=56.95941430112392}
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
node="pg, kick on;pg_on
pg, kick off;pg_off
s1 (sense);s1_on"
x1=2.0000000000000002e-11
x2=2e-06
y1=-0.3995561143764649
y2=6.356022640435098}
