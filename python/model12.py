# -*- coding: utf-8 -*-
"""
Created on Mon Nov  6 23:07:22 2023

@author: Sefofo
"""
#differential RO

import numpy as np
import matplotlib.pyplot as plt

# Parameters
T = 1.0  # Total simulation time
N = 1000  # Number of time steps
dt = T / N  # Time step

# Number of inverters in the differential ring oscillator
num_inverters = 8

# Initialize state arrays for the two complementary outputs
Xp = np.zeros(N+1)
Xn = np.zeros(N+1)

# Stochastic parameters
mu = 0.1  # Drift term (deterministic)
sigma = 0.2  # Diffusion term (stochastic)

# Simulation
for i in range(1, N+1):
    dW = np.random.normal(0, np.sqrt(dt))  # Stochastic noise (Wiener process)
    
    # Update the state of the two complementary outputs
    Xp[i] = Xp[i-1] + mu * Xp[i-1] * dt + sigma * Xp[i-1] * dW
    Xn[i] = Xn[i-1] + mu * Xn[i-1] * dt + sigma * Xn[i-1] * dW

# Calculate the phase difference
phase_difference = Xp - Xn

# Plot the phase difference over time
plt.figure(figsize=(10, 5))
plt.plot(np.arange(N+1) * dt, phase_difference)
plt.xlabel('Time')
plt.ylabel('Phase Difference')
plt.title('Simulation of Differential Ring Oscillator with Wiener Process')
plt.grid()
plt.show()
