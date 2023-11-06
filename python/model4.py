# -*- coding: utf-8 -*-
"""
Created on Mon Nov  6 22:23:34 2023

@author: Sefofo
"""

import numpy as np
import matplotlib.pyplot as plt

# Parameters
n_oscillators = 2  # Number of oscillators
total_time = 10.0  # Total simulation time
dt = 0.01  # Time step
num_steps = int(total_time / dt)

# Initialize arrays to store results
angles = np.zeros((num_steps, n_oscillators))
times = np.linspace(0, total_time, num_steps)

# Stochastic noise parameters
noise_intensity = 0.1  # Intensity of stochastic noise

# Initial conditions
initial_angles = np.random.uniform(0, 2 * np.pi, n_oscillators)

# Simulation loop
for i in range(num_steps):
    for j in range(n_oscillators):
        # Stochastic noise
        dW = noise_intensity * np.random.normal()

        # Dynamics of the oscillator (simplified example)
        # You need to define a proper set of differential equations
        # that describe the coupled behavior of the oscillators
        dtheta = 0.1 * np.sin(angles[i - 1, (j + 1) % n_oscillators] - angles[i - 1, j]) + dW

        # Update angle
        angles[i, j] = angles[i - 1, j] + dtheta

# Plot the results
for j in range(n_oscillators):
    plt.plot(times, angles[:, j], label=f'Oscillator {j + 1}')

plt.xlabel('Time')
plt.ylabel('Angle')
plt.title('Stochastic Differential Ring Oscillators')
plt.legend()
plt.show()
