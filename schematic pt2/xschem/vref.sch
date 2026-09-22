v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {.param l1=34.26u l2=64.23u l3=49.31u} 0 -60 0 0 0.22 0.22 {}
N 100 180 100 220 {lab=#net1}
N 140 140 180 140 {lab=pg}
N 100 60 100 100 {lab=vdd}
N 100 750 100 790 {lab=gnd}
N 100 460 100 500 {lab=#net2}
N 100 560 100 600 {lab=#net3}
N 120 530 160 530 {lab=gnd}
N 40 300 80 300 {lab=gnd}
N 200 510 200 550 {lab=gnd}
N 200 490 200 510 {lab=gnd}
N 180 720 180 750 {lab=gnd}
N 120 700 130 700 {lab=gnd}
N 130 700 130 750 {lab=gnd}
N 100 750 130 750 {lab=gnd}
N 100 730 100 750 {lab=gnd}
N 100 100 100 110 {lab=vdd}
N 100 170 100 180 {lab=#net1}
N 100 330 100 360 {lab=#net2}
N 280 370 330 370 {lab=#net2}
N 280 230 330 230 {lab=#net1}
N 280 620 330 620 {lab=#net3}
N 120 230 280 230 {lab=#net1}
N 100 220 100 230 {lab=#net1}
N 100 230 100 270 {lab=#net1}
N 100 620 280 620 {lab=#net3}
N 100 600 100 620 {lab=#net3}
N 100 620 100 670 {lab=#net3}
N 120 370 280 370 {lab=#net2}
N 100 360 100 370 {lab=#net2}
N 100 370 100 460 {lab=#net2}
N 100 370 120 370 {lab=#net2}
N 100 230 120 230 {lab=#net1}
N 200 330 200 350 {lab=gnd}
N 280 390 330 390 {lab=pg}
N 280 410 330 410 {lab=vdd}
N 200 430 330 430 {lab=o20}
N 280 250 330 250 {lab=pg}
N 280 270 330 270 {lab=vdd}
N 200 290 330 290 {lab=o30}
N 200 270 200 290 {lab=o30}
N 280 640 330 640 {lab=pg}
N 280 660 330 660 {lab=vdd}
N 180 680 330 680 {lab=o07}
N 180 660 180 680 {lab=o07}
C {devices/iopin.sym} 0 0 0 0 {name=p1 lab=vdd}
C {devices/iopin.sym} 160 0 0 0 {name=p2 lab=pg}
C {devices/iopin.sym} 320 0 0 0 {name=p3 lab=o07}
C {devices/iopin.sym} 480 0 0 0 {name=p4 lab=o20}
C {devices/iopin.sym} 640 0 0 0 {name=p5 lab=o30}
C {devices/lab_pin.sym} 180 140 1 0 {name=lXMP4_1 lab=pg}
C {devices/lab_pin.sym} 100 60 0 0 {name=lXMP4_2 lab=vdd}
C {devices/lab_pin.sym} 100 790 2 0 {name=lXRA_1 lab=gnd}
C {devices/lab_pin.sym} 160 530 1 0 {name=lXRB_2 lab=gnd}
C {devices/lab_pin.sym} 40 300 3 0 {name=lXRC_2 lab=gnd}
C {devices/lab_pin.sym} 250 680 0 0 {name=lXD1_0 lab=o07}
C {devices/lab_pin.sym} 200 550 2 0 {name=lXD2_1 lab=gnd}
C {devices/lab_pin.sym} 250 290 0 0 {name=lXD3_0 lab=o30}
C {xschem/ota5.sym} 480 400 2 0 {name=x1}
C {gf180mcu_fd_pr/cap_mim_2f0fF.sym} 200 460 0 0 {name=C1
W=22u
L=22u
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {gf180mcu_fd_pr/cap_mim_2f0fF.sym} 180 690 0 0 {name=C3
W=22u
L=22u
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {gf180mcu_fd_pr/ppolyf_u_1k.sym} 100 700 2 0 {name=R1
W=1e-6
L=l1
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {gf180mcu_fd_pr/ppolyf_u_1k.sym} 100 530 2 0 {name=R2
W=1e-6
L=l2
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {gf180mcu_fd_pr/ppolyf_u_1k.sym} 100 300 0 0 {name=R3
W=1e-6
L=l3
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {gf180mcu_fd_pr/pfet3_06v0.sym} 120 140 2 0 {name=M1
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
C {lab_wire.sym} 250 430 0 0 {name=p7 sig_type=std_logic lab=o20}
C {lab_wire.sym} 280 390 0 0 {name=p8 sig_type=std_logic lab=pg}
C {lab_wire.sym} 280 410 0 0 {name=p9 sig_type=std_logic lab=vdd}
C {xschem/ota5.sym} 480 260 2 0 {name=x4}
C {lab_wire.sym} 280 250 0 0 {name=p12 sig_type=std_logic lab=pg}
C {lab_wire.sym} 280 270 0 0 {name=p13 sig_type=std_logic lab=vdd}
C {xschem/ota5.sym} 480 650 2 0 {name=x5}
C {lab_wire.sym} 280 640 0 0 {name=p16 sig_type=std_logic lab=pg}
C {lab_wire.sym} 280 660 0 0 {name=p17 sig_type=std_logic lab=vdd}
C {gf180mcu_fd_pr/cap_mim_2f0fF.sym} 200 300 0 0 {name=C4
W=22u
L=22u
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {devices/lab_pin.sym} 200 350 2 0 {name=lXD1 lab=gnd}
C {devices/lab_pin.sym} 180 750 2 0 {name=lXRA_2 lab=gnd}
