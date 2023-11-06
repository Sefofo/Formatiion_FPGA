# -*- coding: utf-8 -*-
"""
Created on Mon Nov  6 23:05:11 2023

@author: Sefofo
"""

# A stochastic model of an XOR-ring oscillator (XOR-RO) can be formulated using stochastic differential equations (SDEs) to account for the stochastic or random influences affecting its operation. An XOR-RO consists of XOR gates connected in a ring, and it is used for generating oscillatory signals. Here's a simplified stochastic model for an XOR-RO:

# Let \(X(t)\) represent the state of the XOR-RO at time \(t\), and \(f(X(t))\) denote the deterministic part of the dynamics. The stochastic model can be expressed as:

# \[
# dX(t) = f(X(t))dt + g(X(t))dW(t)
# \]

# Where:
# - \(dX(t)\) represents the infinitesimal change in the state of the XOR-RO at time \(t\).
# - \(f(X(t))\) represents the deterministic part of the dynamics, which could depend on the XOR gate's internal properties, biasing, and the connections within the ring.
# - \(g(X(t))\) is a function that models the influence of random factors (e.g., noise sources, temperature variations, manufacturing variations).
# - \(dW(t)\) is a Wiener process, representing stochastic noise sources.

# The details of \(f(X(t))\) and \(g(X(t))\) would depend on the specific characteristics of the XOR-RO and the stochastic sources that affect its behavior. The parameters of this model would need to be determined based on empirical measurements and observations of the real system.

# This stochastic model allows you to simulate the XOR-RO's behavior in the presence of stochastic influences, and it can be used for statistical analysis or Monte Carlo simulations to assess the variability and randomness in the XOR-RO's output. Keep in mind that real-world applications may require more complex and detailed models to capture all the sources of noise and variability accurately.


import numpy as np
import matplotlib.pyplot as plt

# Parameters
T = 1.0  # Total simulation time
N = 1000  # Number of time steps
dt = T / N  # Time step

# Number of XOR gates in the ring oscillator
num_xor_gates = 8

# Initialize state array
X = np.zeros((N+1, num_xor_gates))

# Stochastic parameters
mu = 0.1  # Drift term (deterministic)
sigma = 0.2  # Diffusion term (stochastic)

# Simulation
for i in range(1, N+1):
    dW = np.random.normal(0, np.sqrt(dt), num_xor_gates)  # Stochastic noise
    for j in range(num_xor_gates):
        X[i][j] = X[i-1][j] + mu * X[i-1][j] * dt + sigma * X[i-1][j] * dW[j]

# Plot the state of the XOR-RO over time
plt.figure(figsize=(10, 5))
for j in range(num_xor_gates):
    plt.plot(np.arange(N+1) * dt, X[:, j], label=f'XOR Gate {j + 1}')

plt.xlabel('Time')
plt.ylabel('State')
plt.legend()
plt.title('Simulation of XOR-RO')
plt.grid()
plt.show()
