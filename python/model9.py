# -*- coding: utf-8 -*-
"""
Created on Mon Nov  6 22:57:49 2023

@author: Sefofo
"""

import numpy as np
import matplotlib.pyplot as plt

# Paramètres
T = 1.0  # Temps total
N = 1000  # Nombre de pas de temps
dt = T / N  # Intervalle de temps

# Nombre de portes inverses
num_inverters = 23

# Constantes du modèle
mu = 0.1  # Terme déterministe
sigma = 0.2  # Terme de bruit
alpha = 0.01  # Coefficient de dépendance à la température

# Température (peut varier au fil du temps)
temperature = 25.0

# Créer des tableaux pour stocker les résultats
t = np.linspace(0, T, N+1)
X = np.zeros((N+1, num_inverters))

# Simulation des EDS pour chaque inverter
for i in range(1, N+1):
    dW = np.random.normal(0, np.sqrt(dt), num_inverters)
    temperature_effect = alpha * (temperature - 25.0)
    for j in range(num_inverters):
        X[i][j] = X[i-1][j] + mu * X[i-1][j] * dt + sigma * X[i-1][j] * dW[j] + temperature_effect

# Tracé des résultats pour un inverter (par exemple, le premier)
plt.plot(t, X[:, 0])
plt.xlabel('Temps')
plt.ylabel('X(t) pour le premier inverter')
plt.show()



# Ce modèle tient compte du bruit de flicker, de la dépendance à la température et de la dynamique de chaque inverter dans l'anneau. Vous pouvez adapter les paramètres et les équations pour mieux correspondre à votre application spécifique et à la modélisation du circuit réel. La modélisation précise de circuits CMOS peut être complexe, et des modèles plus détaillés peuvent être nécessaires pour des analyses plus poussées.