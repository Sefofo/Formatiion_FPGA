# -*- coding: utf-8 -*-
"""
Created on Mon Nov  6 23:01:33 2023

@author: Sefofo
"""

import numpy as np

# Parameters
num_inverters = 23  # Number of inverters in the ring oscillator
num_samples = 1000  # Number of samples to collect
sample_duration = 1.0  # Duration for collecting samples (in seconds)

# Initialize an array to store the collected bits
random_bits = []

# Simulate the ring oscillator
for _ in range(num_samples):
    # Simulate the ring oscillator for the sample_duration
    oscillator_frequency = np.random.normal(1.0, 0.1)  # Simulated frequency with noise
    num_cycles = int(oscillator_frequency * sample_duration)
    
    # Collect bits based on oscillator transitions
    for i in range(num_inverters):
        bit = i % 2  # 0 or 1, representing transitions
        random_bits.append(bit)

# Convert the list of bits into a binary string
random_binary_string = ''.join(map(str, random_bits))

# Print the generated random binary string
print("Random binary string:", random_binary_string)
