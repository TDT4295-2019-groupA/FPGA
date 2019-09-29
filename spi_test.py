#!/usr/bin/env python3
# this is meant to run on a RPi
# gpio connections:
#    https://pinout.xyz/pinout/spi
import time
import spidev

CHIP_SELECT = 0

spi = spidev.SpiDev()
spi.open(0, CHIP_SELECT)
spi.max_speed_hz = 100000
spi.mode = 0
spi.bits_per_word = 8
spi.cshigh = True

seq = [
    0b1000,
    0b0100,
    0b0010,
    0b0001,
    0b0010,
    0b0100,
]

while 1:
    for i in seq:
        print(f"Sending 0x{i:x}...")
        spi.xfer([i])
        time.sleep(0.1)
