v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 -110 40 -50 {lab=out}
N 40 10 40 40 {lab=gnd}
N 40 -80 160 -80 {lab=out}
N 40 -200 40 -170 {lab=#net1}
N -20 -140 0 -140 {lab=in}
N -20 -140 -20 -20 {lab=in}
N -20 -20 -0 -20 {lab=in}
N -50 -80 -20 -80 {lab=in}
C {gf180mcu_fd_pr/nfet3_06v0.sym} 20 -20 0 0 {name=M1
L=0.70u
W=wn
body=GND
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_06v0
spiceprefix=X
}
C {gf180mcu_fd_pr/pfet3_06v0.sym} 20 -140 0 0 {name=M2
L=0.55u
W=wp
body=VDD
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_06v0
spiceprefix=X
}
C {lab_wire.sym} 40 40 2 0 {name=p1 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 160 -80 2 0 {name=p2 sig_type=std_logic lab=out}
C {opin.sym} -200 -160 0 0 {name=p3 lab=out}
C {ipin.sym} -180 -130 0 0 {name=p4 lab=vdd}
C {ipin.sym} -180 -100 0 0 {name=p5 lab=in}
C {lab_wire.sym} -50 -80 0 0 {name=p6 sig_type=std_logic lab=in}
C {lab_wire.sym} 40 -200 0 0 {name=p7 sig_type=std_logic lab=vdd}
C {devices/code_shown.sym} -200 -240 0 0 {name=PARAMS only_toplevel=false
value=".param wn=2u wp=5u"}
