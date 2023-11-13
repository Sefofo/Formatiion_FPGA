# -*- coding: utf-8 -*-
"""
Created on Mon Nov 13 22:41:42 2023

@author: Sefofo
"""

import numpy as np

def generate_oscillator_half_periods(mean, variance, num_samples):
    """
    Generates a sequence of half-periods of a fast oscillating signal.
    
    Parameters:
    - mean: Mean of the half-periods distribution.
    - variance: Variance of the half-periods distribution.
    - num_samples: Number of half-periods to generate.
    
    Returns:
    - List of half-periods.
    """
    return np.random.normal(mean, np.sqrt(variance), num_samples)

def calculate_quality_factor(jitter_ratio, frequency_ratio):
    """
    Calculates the quality factor of a TRNG based on jitter and frequency ratios.
    
    Parameters:
    - jitter_ratio: Jitter ratio.
    - frequency_ratio: Frequency ratio.
    
    Returns:
    - Quality factor.
    """
    return jitter_ratio * frequency_ratio

def calculate_divisibility_ratio(sampling_interval, half_period):
    """
    Calculates the divisibility ratio of the half-period to the sampling interval.
    
    Parameters:
    - sampling_interval: Fixed sampling interval.
    - half_period: Half-period of the fast oscillating signal.
    
    Returns:
    - Divisibility ratio.
    """
    return (sampling_interval % half_period) / half_period

# Example usage:
mean_half_period = 1.0  # Example mean of half-periods
variance_half_period = 0.1  # Example variance of half-periods
num_half_periods = 1000  # Example number of half-periods to generate

half_periods = generate_oscillator_half_periods(mean_half_period, variance_half_period, num_half_periods)

jitter_ratio = np.std(half_periods) / np.mean(half_periods)
frequency_ratio = 1 / np.mean(half_periods)
quality_factor = calculate_quality_factor(jitter_ratio, frequency_ratio)

sampling_interval = 5.0  # Example fixed sampling interval
divisibility_ratio = calculate_divisibility_ratio(sampling_interval, mean_half_period)

print(f"Jitter Ratio: {jitter_ratio}")
print(f"Frequency Ratio: {frequency_ratio}")
print(f"Quality Factor: {quality_factor}")
print(f"Divisibility Ratio: {divisibility_ratio}")
