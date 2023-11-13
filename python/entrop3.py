# -*- coding: utf-8 -*-
"""
Created on Mon Nov 13 22:37:35 2023

@author: Sefofo
"""
#Algo2 On the Entropy of Oscillator-Based True

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

def compute_apen_with_dynamic_h(b, z_0):
    n = len(b)
    h = 1

    while len(approximate_entropy(h, b)) > z_0 / np.sqrt(n):  # Steps 1-3
        h += 1

    # Step 4
    ap_en_values = approximate_entropy(h, b)

    # Step 5
    return ap_en_values[-1]  # Returning the last value of ApEn

# Generate a random binary sequence for testing
bit_sequence = np.random.randint(2, size=1000)

# Set the initial z_0 value
z_0_value = 0.995

# Calculate and print the final ApEn
final_apen = compute_apen_with_dynamic_h(bit_sequence, z_0_value)
print(f"Final ApEn: {final_apen}")

# Plot the results
plt.plot(range(1, len(final_apen) + 1), final_apen, marker='o')
plt.xlabel('m')
plt.ylabel('ApEn')
plt.title('Approximate Entropy vs. m')
plt.show()

