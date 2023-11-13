# -*- coding: utf-8 -*-
"""
Created on Mon Nov 13 21:35:48 2023

@author: Sefofo
"""

def approximate_entropy(m, b):
    n = len(b)
    bm_plus_1 = m + 1

    # Step 1: Augment the bit sequence
    augmented_sequence = b + b[:m - 1]

    # Initialize variables
    delta_m = 0
    delta_m_plus_1 = 0

    for i in range(2 ** m):  # Step 2
        pattern = bin(i)[2:].zfill(m)  # Convert i to binary and pad with zeros
        count_m = augmented_sequence.count(pattern)  # Frequency count
        cm = count_m / n  # Step 3

        if cm > 0:
            delta_m += cm * (cm).log2()  # Step 4

    # Step 5
    m += 1

    for i in range(2 ** m):
        pattern = bin(i)[2:].zfill(m)
        count_m_plus_1 = augmented_sequence.count(pattern)
        cm_plus_1 = count_m_plus_1 / n

        if cm_plus_1 > 0:
            delta_m_plus_1 += cm_plus_1 * (cm_plus_1).log2()

    # Step 6
    ap_en = delta_m - delta_m_plus_1

    # Step 7
    return ap_en

# Example usage:
m_value = 2
bit_sequence = [0, 1, 0, 1, 1, 0, 1, 0, 1, 0]

result = approximate_entropy(m_value, bit_sequence)
print(f"Approximate Entropy: {result}")
