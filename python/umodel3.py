# -*- coding: utf-8 -*-
"""
Created on Mon Nov  6 22:21:48 2023

@author: Sefofo
"""

import numpy as np
import matplotlib.pyplot as plt

# Parameters
n_oscillators = 3  # Number of oscillators in the ring
total_time = 10.0  # Total simulation time
dt = 0.01  # Time step
num_steps = int(total_time / dt)

# Initialize arrays to store results
angles = np.zeros((num_steps, n_oscillators))
times = np.linspace(0, total_time, num_steps)

# Fisher noise parameters
noise_intensity = 0.1  # Intensity of Fisher noise
kappa = 5  # Fisher parameter

# Initial conditions
initial_angles = np.random.uniform(0, 2 * np.pi, n_oscillators)

# Simulation loop
for i in range(num_steps):
    for j in range(n_oscillators):
        # Fisher noise
        dW = np.random.vonmises(0, kappa, 1)[0]

        # Dynamics of the oscillator
        # Simplified example: Apply Fisher noise to the angle
        dtheta = dW * noise_intensity * np.random.normal() * dt

        # Update angle
        angles[i, j] = angles[i - 1, j] + dtheta

# Plot the results
for j in range(n_oscillators):
    plt.plot(times, angles[:, j], label=f'Oscillator {j + 1}')

plt.xlabel('Time')
plt.ylabel('Angle')
plt.title('Stochastic Ring Oscillator with Fisher Noise')
plt.legend()
plt.show()
