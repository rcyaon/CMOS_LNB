v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
C {devices/vsource.sym} -460 0 0 0 {name=V1
value="pwl(0 0 1n 5)"}
C {devices/lab_pin.sym} -460 -30 0 0 {name=l1 sig_type=std_logic lab=vdd}
C {devices/gnd.sym} -460 50 0 0 {name=g2 lab=GND}
N -460 30 -460 50 {lab=GND}
C {xschem/ringosci.sym} -150 0 0 0 {name=X1}
C {devices/lab_pin.sym} -260.0 0.0 0 0 {name=l3 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -40.0 0.0 0 1 {name=l4 sig_type=std_logic lab=lo}
C {devices/code_shown.sym} -620 420 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value=".include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
.lib $::180MCU_MODELS/sm141064.ngspice res_typical
.lib $::180MCU_MODELS/sm141064.ngspice mimcap_typical
.lib $::180MCU_MODELS/sm141064.ngspice cap_mim"}
C {devices/code_shown.sym} -620 580 0 0 {name=NGSPICE only_toplevel=true
value=".control
tran 1p 20n 0 1p
meas tran t1 WHEN v(lo)=2.5 RISE=10
meas tran t2 WHEN v(lo)=2.5 RISE=20
let fosc_ghz = 10/(t2-t1)/1e9
print fosc_ghz
let idd = -i(v1)*1e3
write tb_ringosci.raw v(lo) v(vdd) idd
.endc"}
C {devices/launcher.sym} -600 -260 0 0 {name=h1
descr="ctrl-click: load / unload tb_ringosci.raw"
tclcommand="xschem raw_read $netlist_dir/tb_ringosci.raw"}
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
node="lo;lo
vdd;vdd"
x1=0.0
x2=2e-08
y1=-0.3008877185494001
y2=5.3156830277060685}
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
node="lo;lo"
x1=1.8e-08
x2=2e-08
y1=-0.27597300835363053
y2=5.314271027248525}
B 2 560 620 1460 1040 {flags=graph
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
node="supply current (mA);idd"
x1=0.0
x2=2e-08
y1=-0.0504399204481479
y2=0.891105261250613}
