# -*- coding: utf-8 -*-
"""
Created on Mon Nov 13 22:34:23 2023

@author: Sefofo
"""

#Algo1 On the Entropy of Oscillator-Based True

import numpy as np
import matplotlib.pyplot as plt

def approximate_entropy(m, b):
    n = len(b)
    bm_plus_1 = m + 1

    # Step 1: Augment the bit sequence
    augmented_sequence = np.concatenate([b, b[:m - 1]])

    # Initialize variables
    delta_values = []

    while m <= bm_plus_1:  # Steps 5
        delta_m = 0

        for i in range(2 ** m):  # Step 2
            pattern = format(i, f'0{m}b')  # Convert i to binary and pad with zeros
            count_m = np.sum(np.all(augmented_sequence[j:j + m] == np.array(list(pattern))) for j in range(n))  # Frequency count
            cm = count_m / n  # Step 3

            if cm > 0:
                delta_m += cm * np.log2(cm)  # Step 4

        # Append delta_m to the list of delta values
        delta_values.append(delta_m)

        # Increment m for the next iteration
        m += 1

    # Step 6
    ap_en_values = [delta_values[i + 1] - delta_values[i] for i in range(len(delta_values) - 1)]

    # Step 7
    return ap_en_values

# Generate a random binary sequence for testing
bit_sequence = np.random.randint(2, size=1000)

# Set the initial block length
m_value = 2

# Calculate ApEn values
ap_en_values = approximate_entropy(m_value, bit_sequence)

# Plot the results
plt.plot(range(1, len(ap_en_values) + 1), ap_en_values, marker='o')
plt.xlabel('m')
plt.ylabel('ApEn')
plt.title('Approximate Entropy vs. m')
plt.show()
