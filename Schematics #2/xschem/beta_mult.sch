v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Rs = R1 (ppolyf_u_1k, TC -939 ppm/C) + R2 (nwell, TC +2285 ppm/C) in series.
The mix cancels the mobility drift of Iref*R so the vref taps are near zero-TC.} -10 -560 0 0 0.2 0.2 {}
N 220 -70 220 30 {lab=gnd}
N 560 -60 560 -30 {lab=nr}
N 220 -90 220 -70 {lab=gnd}
N 220 -170 220 -150 {lab=ng}
N 60 -300 100 -300 {lab=gnd}
N 70 -350 140 -350 {lab=vdd}
N 140 -350 140 -330 {lab=vdd}
N 70 -380 70 -350 {lab=vdd}
N 140 -270 140 -210 {lab=s1}
N 100 -240 140 -240 {lab=s1}
N 180 -180 220 -180 {lab=ng}
N 220 -180 220 -170 {lab=ng}
N 140 -150 140 30 {lab=gnd}
N 230 30 450 30 {lab=gnd}
N 210 30 230 30 {lab=gnd}
N 450 30 450 60 {lab=gnd}
N 560 -140 560 -120 {lab=ns}
N 420 -170 520 -170 {lab=ng}
N 500 -130 560 -130 {lab=ns}
N 380 -140 380 30 {lab=gnd}
N 140 30 210 30 {lab=gnd}
N 220 -220 220 -180 {lab=ng}
N 220 -220 380 -220 {lab=ng}
N 380 -220 380 -200 {lab=ng}
N 380 -220 470 -220 {lab=ng}
N 470 -220 470 -170 {lab=ng}
N 200 -220 220 -220 {lab=ng}
N 380 -280 380 -220 {lab=ng}
N 70 -370 380 -370 {lab=vdd}
N 380 -370 380 -340 {lab=vdd}
N 420 -310 520 -310 {lab=pg}
N 380 -370 560 -370 {lab=vdd}
N 560 -370 560 -340 {lab=vdd}
N 560 -280 560 -200 {lab=pg}
N 560 -260 720 -260 {lab=pg}
N 760 -220 790 -220 {lab=kg}
N 720 -260 790 -260 {lab=pg}
N 720 -190 720 30 {lab=gnd}
N 450 30 560 30 {lab=gnd}
N 560 30 600 30 {lab=gnd}
N 600 30 720 30 {lab=gnd}
N 880 -190 880 -170 {lab=cpret}
N 560 -270 880 -270 {lab=pg}
N 880 -270 880 -250 {lab=pg}
N 720 -260 720 -250 {lab=pg}
C {devices/iopin.sym} -10 -430 0 0 {name=p1 lab=vdd}
C {devices/iopin.sym} 150 -430 0 0 {name=p2 lab=pg}
C {devices/iopin.sym} 310 -430 0 0 {name=p3 lab=ng}
C {devices/iopin.sym} 470 -430 0 0 {name=p4 lab=ns}
C {devices/iopin.sym} 630 -430 0 0 {name=p5 lab=cpret}
C {devices/iopin.sym} 790 -430 0 0 {name=p6 lab=s1}
C {devices/iopin.sym} 950 -430 0 0 {name=p7 lab=kg}
C {devices/lab_pin.sym} 450 60 2 0 {name=lXRS_1 lab=gnd}
C {gf180mcu_fd_pr/cap_mim_2f0fF.sym} 220 -120 0 0 {name=C1
W=22u
L=22u
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {gf180mcu_fd_pr/ppolyf_u_1k.sym} 560 -90 2 0 {name=R1
W=2u
L=rp_l
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {gf180mcu_fd_pr/nfet3_06v0.sym} 400 -170 2 0 {name=M1
L=2u
W=20u
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
C {gf180mcu_fd_pr/nfet3_06v0.sym} 160 -180 2 0 {name=M2
L=1u
W=10u
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
C {gf180mcu_fd_pr/nfet3_06v0.sym} 740 -220 2 0 {name=M3
L=1u
W=2u
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
C {gf180mcu_fd_pr/pfet3_06v0.sym} 120 -300 0 0 {name=M5
L=50u
W=0.5u
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
C {gf180mcu_fd_pr/pfet3_06v0.sym} 400 -310 2 0 {name=M6
L=2u
W=40u
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
C {lab_wire.sym} 70 -380 0 0 {name=p8 sig_type=std_logic lab=vdd}
C {lab_wire.sym} 100 -240 0 0 {name=p9 sig_type=std_logic lab=s1}
C {lab_wire.sym} 500 -130 0 0 {name=p10 sig_type=std_logic lab=ns}
C {lab_wire.sym} 200 -220 0 0 {name=p11 sig_type=std_logic lab=ng}
C {gf180mcu_fd_pr/cap_mim_2f0fF.sym} 880 -220 0 0 {name=C2
W=22u
L=22u
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {lab_wire.sym} 790 -260 2 0 {name=p12 sig_type=std_logic lab=pg}
C {lab_wire.sym} 790 -220 2 0 {name=p14 sig_type=std_logic lab=kg}
C {lab_wire.sym} 880 -170 2 0 {name=p13 sig_type=std_logic lab=cpret}
C {gf180mcu_fd_pr/nfet3_06v0.sym} 540 -170 0 0 {name=M7
L=2u
W=80u
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
C {gf180mcu_fd_pr/pfet3_06v0.sym} 540 -310 0 0 {name=M4
L=2u
W=40u
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
C {lab_wire.sym} 470 -310 0 0 {name=p15 sig_type=std_logic lab=pg}
C {lab_wire.sym} 60 -300 2 0 {name=p16 sig_type=std_logic lab=gnd}
N 580 -90 600 -90 {lab=gnd}
N 600 -90 600 0 {lab=gnd}
N 600 0 600 30 {lab=gnd}
N 580 0 600 0 {lab=gnd}
C {gf180mcu_fd_pr/nwell.sym} 560 0 2 0 {name=R2
W=2u
L=rn_l
model=nwell
spiceprefix=X
m=1}
C {devices/code_shown.sym} -10 -490 0 0 {name=PARAMS only_toplevel=false
value=".param rp_l=2.7u rn_l=4.07u"}
