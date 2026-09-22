v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 130 180 170 180 {lab=pg}
N 40 330 80 330 {lab=inp}
N 210 100 210 150 {lab=vdd}
N 120 240 120 300 {lab=#net1}
N 120 240 290 240 {lab=#net1}
N 290 240 290 300 {lab=#net1}
N 120 360 120 400 {lab=#net2}
N 290 360 290 400 {lab=out}
N 120 370 200 370 {lab=#net2}
N 200 370 200 430 {lab=#net2}
N 200 430 250 430 {lab=#net2}
N 160 430 200 430 {lab=#net2}
N 120 460 120 500 {lab=gnd}
N 120 500 290 500 {lab=gnd}
N 290 460 290 500 {lab=gnd}
N 200 500 200 520 {lab=gnd}
N 290 380 440 380 {lab=out}
N 330 330 370 330 {lab=out}
N 370 330 370 380 {lab=out}
N 210 210 210 240 {lab=#net1}
C {devices/iopin.sym} 410 100 0 0 {name=p1 lab=inp}
C {devices/iopin.sym} 440 380 0 0 {name=p2 lab=out}
C {devices/iopin.sym} 410 70 0 0 {name=p3 lab=vdd}
C {devices/iopin.sym} 570 70 0 0 {name=p4 lab=pg}
C {devices/lab_pin.sym} 210 100 0 0 {name=lXMT_0 lab=vdd}
C {devices/lab_pin.sym} 130 180 3 0 {name=lXMT_1 lab=pg}
C {devices/lab_pin.sym} 40 330 3 0 {name=lXMA_1 lab=inp}
C {gf180mcu_fd_pr/pfet3_06v0.sym} 100 330 0 0 {name=M1
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
C {gf180mcu_fd_pr/nfet3_06v0.sym} 270 430 0 0 {name=M2
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
C {gf180mcu_fd_pr/pfet3_06v0.sym} 190 180 0 0 {name=M3
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
C {gf180mcu_fd_pr/pfet3_06v0.sym} 310 330 2 0 {name=M4
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
C {gf180mcu_fd_pr/nfet3_06v0.sym} 140 430 2 0 {name=M5
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
C {devices/lab_pin.sym} 200 520 0 0 {name=lXMT_2 lab=gnd}
