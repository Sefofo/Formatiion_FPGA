# -*- coding: utf-8 -*-
"""
Created on Mon Nov  6 22:10:40 2023

@author: Sefofo
"""

import matplotlib.pyplot as plt

# Créez des données pour la fonction discrète (par exemple, un sinus)
import numpy as np

t = np.arange(0, 2 * np.pi, 0.1)  # Génère un échantillon de 0 à 2*pi avec un pas de 0.1
y = np.sin(t)  # Calculez le sin(x) pour chaque valeur de t

# Tracez la fonction discrète
plt.stem(t, y, use_line_collection=True)  # Utilisez 'stem' pour un tracé discret
plt.xlabel('Temps')
plt.ylabel('Amplitude')
plt.title('Fonction Discrète (sinus)')
plt.grid(True)  # Activez la grille

plt.show()
