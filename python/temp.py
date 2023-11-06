# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import numpy as np

import matplotlib.pyplot as plt


# Créez un signal sinusoïdal avec une fréquence de 5 Hz et une durée de 1 seconde

sample_rate = 1000  # Fréquence d'échantillonnage en Hz

t = np.arange(0, 1, 1/sample_rate)  # Créez un vecteur de temps


signal = np.sin(2 * np.pi * 5 * t)  # Signal sinusoïdal à 5 Hz

fft_result = np.fft.fft(signal)


frequencies = np.fft.fftfreq(len(fft_result), 1/sample_rate)



plt.figure()
plt.plot(frequencies, np.abs(fft_result))
plt.xlabel('Fréquence (Hz)')
plt.ylabel('Amplitude')
plt.title('Spectre Fréquentiel')
plt.show()
