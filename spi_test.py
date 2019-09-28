#!/usr/bin/env python3
# this is meant to run on a RPi
# gpio connections:
#    https://pinout.xyz/pinout/spi
import time
import spidev

CHIP_SELECT = 0

spi = spidev.SpiDev()
spi.open(0, CHIP_SELECT)
spi.max_speed_hz = 10000
spi.mode = 0
spi.bits_per_word = 8
spi.cshigh = True

while 1:
    for i in range(0x10):
        print(f"Sending 0x{i:x}...")
        spi.xfer([i])
        time.sleep(0.8)
