# -*- coding: utf-8 -*-
"""
Created on Mon Nov  6 22:17:20 2023

@author: Sefofo
"""

import numpy as np
import matplotlib.pyplot as plt

# Paramètres du modèle
omega0 = 1.0  # Fréquence naturelle de l'oscillateur
D = 0.1  # Intensité du bruit stochastique
T = 10.0  # Temps total de la simulation
dt = 0.01  # Pas de temps
N = int(T / dt)  # Nombre de pas de temps

# Initialisation
theta = np.zeros(N)  # Vecteur pour stocker les valeurs de l'angle
theta[0] = 0.0  # Condition initiale

# Simulation stochastique
for i in range(1, N):
    dtheta = omega0 * dt + np.sqrt(2 * D * dt) * np.random.normal()  # Équation de Langevin
    theta[i] = theta[i - 1] + dtheta

# Tracé de l'angle en fonction du temps
t = np.linspace(0, T, N)
plt.plot(t, theta)
plt.xlabel('Temps')
plt.ylabel('Angle')
plt.title('Simulation d\'un oscillateur d\'anneau stochastique')
plt.show()


