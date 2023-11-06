# -*- coding: utf-8 -*-
"""
Created on Mon Nov  6 22:29:36 2023

@author: Sefofo
"""

import numpy as np
import matplotlib.pyplot as plt

# Paramètres
omega_0 = 1.0  # Fréquence naturelle des oscillateurs
tau = 1.0  # Temps de retard entre les oscillateurs
total_time = 10.0  # Temps total de la simulation
dt = 0.01  # Pas de temps
num_steps = int(total_time / dt)

# Initialisation des angles des oscillateurs
theta1 = np.random.uniform(0, 2 * np.pi)
theta2 = np.random.uniform(0, 2 * np.pi)

# Intensité du bruit stochastique
noise_intensity = 0.1

# Initialisation des listes pour stocker les angles au fil du temps
angles1 = [theta1]
angles2 = [theta2]
times = [0.0]

# Simulation stochastique
for i in range(1, num_steps):
    # Calcul des bruits stochastiques
    noise1 = noise_intensity * np.random.randn()
    noise2 = noise_intensity * np.random.randn()

    # Équations de Langevin pour les oscillateurs
    dtheta1 = (omega_0 + noise1) * dt
    dtheta2 = (omega_0 + noise2) * dt

    # Mise à jour des angles des oscillateurs
    theta1 += dtheta1
    theta2 += dtheta2

    # Stockage des angles au fil du temps
    angles1.append(theta1)
    angles2.append(theta2)
    times.append(i * dt)

# Tracé des angles au fil du temps
plt.plot(times, angles1, label='Oscillateur 1')
plt.plot(times, angles2, label='Oscillateur 2')
plt.xlabel('Temps')
plt.ylabel('Angle')
plt.title('Modèle Stochastique d\'Anneau d\'Oscillateurs Différentiels')
plt.legend()
plt.show()
