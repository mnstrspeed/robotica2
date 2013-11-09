v 20121123 2
C 0 0 0 0 0 title-B.sym
C 14100 6100 1 0 1 connector4-1.sym
{
T 12300 7000 5 10 0 0 0 6 1
device=CONNECTOR_4
T 14100 7500 5 10 1 1 0 6 1
refdes=USB-B
}
C 300 1800 1 0 0 connector6-1.sym
{
T 2100 3600 5 10 0 0 0 0 1
device=CONNECTOR_6
T 400 3800 5 10 1 1 0 0 1
refdes=ICSP
}
C 4200 8500 1 90 0 cap.sym
{
T 3500 8700 5 10 0 0 90 0 1
device=POLARIZED_CAPACITOR
T 4900 9300 5 10 1 1 180 0 1
refdes=C1 100nF
T 3300 8700 5 10 0 0 90 0 1
symversion=0.1
}
C 3500 7700 1 180 0 cap.sym
{
T 3300 7000 5 10 0 0 180 0 1
device=POLARIZED_CAPACITOR
T 3900 7700 5 10 1 1 180 0 1
refdes=C2 10uF
T 3300 6800 5 10 0 0 180 0 1
symversion=0.1
}
C 2200 8500 1 0 0 ld1117c33.sym
{
T 3500 9800 5 10 0 0 0 0 1
device=7805
T 2600 9500 5 10 1 1 0 6 1
refdes=U1
}
C 5000 3500 1 0 0 pic18f14k50.sym
{
T 8900 8000 5 10 1 1 0 6 1
refdes=U2
T 5400 12500 5 8 0 0 0 0 1
device=PIC18F4431-DIP
T 5400 12900 5 8 0 0 0 0 1
footprint=DIP20
}
C 2200 7200 1 0 0 ground.sym
C 3300 9700 1 0 0 ground.sym
N 2400 7500 2400 8500 4
N 3500 7500 5000 7500 4
N 3200 8500 11500 8500 4
C 9800 7500 1 0 0 ground.sym
C 12000 5700 1 0 0 ground.sym
N 9500 7500 9600 7500 4
N 9600 7500 9600 7900 4
N 9600 7900 10000 7900 4
N 10000 7900 10000 7800 4
C 11000 6100 1 0 0 cap.sym
{
T 11200 6800 5 10 0 0 0 0 1
device=POLARIZED_CAPACITOR
T 11000 5900 5 10 1 1 0 0 1
refdes=C3 470nF
T 11200 7000 5 10 0 0 0 0 1
symversion=0.1
}
N 11000 6300 9500 6300 4
N 11900 6300 12400 6300 4
N 12200 6300 12200 6000 4
N 12400 7200 11500 7200 4
N 11500 7200 11500 8500 4
N 2600 7500 2400 7500 4
N 2800 8500 2800 8000 4
N 2800 8000 4000 8000 4
N 4000 8000 4000 7500 4
N 4000 9400 4000 10000 4
N 4000 10000 3500 10000 4
N 9500 7100 11100 7100 4
N 11100 7100 11100 6900 4
N 11100 6900 12400 6900 4
N 9500 6700 10900 6700 4
N 10900 2300 10900 6700 4
N 10900 6600 12400 6600 4
C 1500 5700 1 270 0 cap.sym
{
T 2200 5500 5 10 0 0 270 0 1
device=POLARIZED_CAPACITOR
T 1900 5500 5 10 1 1 0 0 1
refdes=C4 22pF
T 2400 5500 5 10 0 0 270 0 1
symversion=0.1
}
C 2500 5700 1 270 0 cap.sym
{
T 3200 5500 5 10 0 0 270 0 1
device=POLARIZED_CAPACITOR
T 1900 4900 5 10 1 1 0 0 1
refdes=22pF C5
T 3400 5500 5 10 0 0 270 0 1
symversion=0.1
}
C 2000 4300 1 0 0 ground.sym
C 1900 6000 1 0 0 crystal-1.sym
{
T 2100 6500 5 10 0 0 0 0 1
device=CRYSTAL
T 1800 6300 5 10 1 1 0 0 1
refdes=X1 12Mhz
T 2100 6700 5 10 0 0 0 0 1
symversion=0.1
}
N 1900 6100 1700 6100 4
N 1700 5700 1700 7100 4
N 2600 6100 2700 6100 4
N 2700 5700 2700 6700 4
N 2700 4800 2700 4600 4
N 1700 4600 2700 4600 4
N 1700 4800 1700 4600 4
N 5000 7100 1700 7100 4
N 5000 6700 2700 6700 4
N 5000 6300 3700 6300 4
N 3700 6300 3700 3500 4
N 3700 3500 2000 3500 4
N 2000 3200 4000 3200 4
N 4000 3200 4000 7500 4
C 2300 2700 1 0 0 ground.sym
N 2000 2600 10700 2600 4
N 10700 2600 10700 7100 4
N 2000 2300 10900 2300 4
N 2000 2900 2200 2900 4
N 2200 2900 2200 3000 4
N 2200 3000 2500 3000 4
N 14000 4500 13000 4500 4
N 13000 4500 13000 5500 4
N 13000 5500 15300 5500 4
N 15300 5500 15300 8800 4
N 15300 8800 4600 8800 4
N 4600 8800 4600 7500 4
C 13100 2300 1 0 0 ground.sym
N 14000 3900 9500 3900 4
C 15700 2200 1 0 1 connector8-1.sym
{
T 15600 5400 5 10 0 0 0 6 1
device=CONNECTOR_8
T 15600 4800 5 10 1 1 0 6 1
refdes=TRX-1
}
N 14000 3600 12700 3600 4
N 14000 2400 13600 2400 4
N 13600 2400 13600 1600 4
N 13600 1600 4300 1600 4
N 4300 1600 4300 4700 4
N 4300 4700 5000 4700 4
N 14000 3300 12400 3300 4
N 12400 3300 12400 5400 4
N 12400 5400 10200 5400 4
N 10200 5400 10200 5900 4
N 10200 5900 9500 5900 4
N 13300 3000 14000 3000 4
N 13300 3000 13300 2600 4
C 1300 900 1 0 0 led-2.sym
{
T 1200 1100 5 10 1 1 0 0 1
refdes=LED2
T 1400 1500 5 10 0 0 0 0 1
device=LED
}
C 1300 400 1 0 0 led-2.sym
{
T 1200 600 5 10 1 1 0 0 1
refdes=LED3
T 1400 1000 5 10 0 0 0 0 1
device=LED
}
C 1300 1400 1 0 0 led-2.sym
{
T 1200 1600 5 10 1 1 0 0 1
refdes=LED1
T 1400 2000 5 10 0 0 0 0 1
device=LED
}
C 2500 1400 1 0 0 resistor-1.sym
{
T 2800 1800 5 10 0 0 0 0 1
device=RESISTOR
T 2700 1700 5 10 1 1 0 0 1
refdes=R1 47 Ohm
}
C 2500 900 1 0 0 resistor-1.sym
{
T 2800 1300 5 10 0 0 0 0 1
device=RESISTOR
T 2700 1200 5 10 1 1 0 0 1
refdes=R2 47 Ohm
}
C 2500 400 1 0 0 resistor-1.sym
{
T 2800 800 5 10 0 0 0 0 1
device=RESISTOR
T 2700 700 5 10 1 1 0 0 1
refdes=R3 47 Ohm
}
C 3800 200 1 0 0 ground.sym
N 3400 500 4000 500 4
N 4000 500 4000 1500 4
N 4000 1000 3400 1000 4
N 3400 1500 4000 1500 4
N 2500 500 2200 500 4
N 2500 1000 2200 1000 4
N 2500 1500 2200 1500 4
N 5000 5100 3500 5100 4
N 3500 5100 3500 3800 4
N 3500 3800 1000 3800 4
N 1000 3800 1000 4100 4
N 1000 4100 200 4100 4
N 200 4100 200 1500 4
N 200 1500 1300 1500 4
N 5000 5500 3300 5500 4
N 3300 5500 3300 4000 4
N 3300 4000 1200 4000 4
N 1200 4000 1200 4300 4
N 1200 4300 100 4300 4
N 100 4300 100 1000 4
N 100 1000 1300 1000 4
N 5000 5900 3000 5900 4
N 3000 5900 3000 4200 4
N 3000 4200 1400 4200 4
N 1400 4200 1400 4500 4
N 1400 4500 0 4500 4
N 0 4500 0 500 4
N 0 500 1300 500 4
N 12700 3600 12700 4700 4
N 12700 4700 9500 4700 4
N 14000 4200 11700 4200 4
N 11700 4200 11700 2900 4
N 11700 2900 4600 2900 4
N 4600 2900 4600 4300 4
N 4600 4300 5000 4300 4
