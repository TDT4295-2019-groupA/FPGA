import math

def emulate_freq_calc(note_index):
    return 440 * (2 ** ((note_index - 58) / 12))

def emulate_freq_to_wavelength(freq):
    return round(44100 / freq)

for x in range(0, 128):
    print(str(x) + " " + str(emulate_freq_to_wavelength(emulate_freq_calc(x))))
