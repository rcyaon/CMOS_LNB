v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {.param cw=5.15u   .param rl=5.5u   .param wt=50u} 0 -60 0 0 0.22 0.22 {}
N 180 290 220 290 {lab=inp}
N 560 290 600 290 {lab=inn}
N 300 390 340 390 {lab=nb}
N 260 60 260 100 {lab=vdd}
N 260 180 260 220 {lab=outn}
N 280 130 320 130 {lab=gnd}
N 540 130 580 130 {lab=gnd}
N 50 290 50 330 {lab=outn}
N 50 410 50 450 {lab=gnd}
N 260 160 260 180 {lab=outn}
N 520 160 520 190 {lab=outp}
N 520 220 520 240 {lab=outp}
N 520 240 720 240 {lab=outp}
N 720 240 720 270 {lab=outp}
N 520 190 520 220 {lab=outp}
N 50 250 50 290 {lab=outn}
N 50 230 260 230 {lab=outn}
N 50 230 50 250 {lab=outn}
N 260 220 260 230 {lab=outn}
N 50 390 50 410 {lab=gnd}
N 50 450 720 450 {lab=gnd}
N 720 330 720 450 {lab=gnd}
N 380 450 380 500 {lab=gnd}
N 260 80 520 80 {lab=vdd}
N 520 80 520 100 {lab=vdd}
N 380 420 380 450 {lab=gnd}
N 260 320 260 340 {lab=#net1}
N 260 340 380 340 {lab=#net1}
N 380 340 380 360 {lab=#net1}
N 380 340 380 360 {lab=#net1}
N 380 340 520 340 {lab=#net1}
N 520 320 520 340 {lab=#net1}
N 520 240 520 260 {lab=outp}
N 260 230 260 250 {lab=outn}
N 260 250 260 260 {lab=outn}
N 20 230 50 230 {lab=outn}
N 720 240 750 240 {lab=outp}
C {devices/iopin.sym} 0 0 0 0 {name=p1 lab=inp}
C {devices/iopin.sym} 160 0 0 0 {name=p2 lab=inn}
C {devices/iopin.sym} 320 0 0 0 {name=p3 lab=outp}
C {devices/iopin.sym} 480 0 0 0 {name=p4 lab=outn}
C {devices/iopin.sym} 640 0 0 0 {name=p5 lab=vdd}
C {devices/iopin.sym} 800 0 0 0 {name=p6 lab=nb}
C {devices/lab_pin.sym} 180 290 3 0 {name=lXM1_1 lab=inp}
C {devices/lab_pin.sym} 600 290 1 0 {name=lXM2_1 lab=inn}
C {devices/lab_pin.sym} 300 390 3 0 {name=lXMT_1 lab=nb}
C {devices/lab_pin.sym} 260 60 0 0 {name=lXR1_0 lab=vdd}
C {devices/lab_pin.sym} 320 130 1 0 {name=lXR1_2 lab=gnd}
C {devices/lab_pin.sym} 580 130 1 0 {name=lXR2_2 lab=gnd}
C {devices/lab_pin.sym} 380 500 2 0 {name=lXC1_1 lab=gnd}
C {gf180mcu_fd_pr/cap_mim_2f0fF.sym} 50 360 0 0 {name=C1
W=cw
L=cw
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {gf180mcu_fd_pr/cap_mim_2f0fF.sym} 720 300 0 0 {name=C2
W=cw
L=cw
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {gf180mcu_fd_pr/ppolyf_u_1k.sym} 260 130 2 0 {name=R1
W=2u
L=rl
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {gf180mcu_fd_pr/ppolyf_u_1k.sym} 520 130 2 0 {name=R2
W=2u
L=rl
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {gf180mcu_fd_pr/nfet3_03v3.sym} 240 290 0 0 {name=M1
L=0.28u
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
model=nfet_03v3
spiceprefix=X
}
C {gf180mcu_fd_pr/nfet3_03v3.sym} 540 290 2 0 {name=M2
L=0.28u
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
model=nfet_03v3
spiceprefix=X
}
C {gf180mcu_fd_pr/nfet3_03v3.sym} 360 390 0 0 {name=M3
L=1u
W=wt
body=GND
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {devices/lab_pin.sym} 20 230 0 0 {name=loutn lab=outn}
C {devices/lab_pin.sym} 750 240 2 0 {name=loutp lab=outp}
