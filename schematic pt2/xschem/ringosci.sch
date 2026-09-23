v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -10 -20 -0 -20 {lab=#net1}
N 0 -20 0 0 {lab=#net1}
N -330 -20 -310 -20 {lab=vdd}
N 20 -60 20 -20 {lab=vdd}
N 320 -20 320 0 {lab=#net2}
N 320 0 340 0 {lab=#net2}
N 0 0 20 0 {lab=#net1}
N -330 -0 -310 -0 {lab=lo}
N -330 -0 -330 40 {lab=lo}
N -330 40 660 40 {lab=lo}
N 660 -20 660 40 {lab=lo}
N 640 -20 660 -20 {lab=lo}
N 660 -20 700 -20 {lab=lo}
N 700 -20 720 -20 {lab=lo}
N 720 -20 800 -20 {lab=lo}
N -330 -50 -330 -20 {lab=vdd}
N -330 -50 20 -50 {lab=vdd}
N 20 -50 340 -50 {lab=vdd}
N 340 -50 340 -20 {lab=vdd}
C {xschem/inv.sym} -160 -10 0 0 {name=x1}
C {xschem/inv.sym} 170 -10 0 0 {name=x2}
C {xschem/inv.sym} 490 -10 0 0 {name=x3}
C {lab_wire.sym} 20 -60 0 0 {name=p1 sig_type=std_logic lab=vdd}
C {lab_wire.sym} 800 -20 2 0 {name=p3 sig_type=std_logic lab=lo}
C {ipin.sym} -150 -150 0 0 {name=p4 lab=vdd}
C {opin.sym} -160 -120 0 0 {name=p5 lab=lo}
T {6 V devices, 5 V supply. No band cap: the ring is self-loaded
(the old 4.5 um MIM was below the 5 um minimum).} 150 -160 0 0 0.2 0.2 {}
