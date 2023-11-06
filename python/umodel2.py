# -*- coding: utf-8 -*-
"""
Created on Mon Nov  6 22:18:39 2023

@author: Sefofo
"""

import numpy as np

# Parameters
kd = 25
kp = 31
noise_intensity = 0.1  # Intensity of stochastic noise
dt = 0.01  # Time step
total_time = 10.0  # Total simulation time
num_steps = int(total_time / dt)

# Initial conditions
theta = 0.0  # Initial angle

# Initialize arrays to store results
angles = np.zeros(num_steps)
times = np.linspace(0, total_time, num_steps)

# Simulation loop
for i in range(num_steps):
    # Stochastic term (Brownian motion)
    dW = np.sqrt(2 * noise_intensity * dt) * np.random.randn()

    # Dynamics of the oscillator
    dtheta = kp * np.sin(theta) * dt + kd * np.cos(theta) * dt + dW
    theta += dtheta

    # Store the angle
    angles[i] = theta

# Plot the results
import matplotlib.pyplot as plt

plt.plot(times, angles)
plt.xlabel('Time')
plt.ylabel('Angle')
plt.title('Stochastic Ring Oscillator')
plt.show()
