"""Didaktische Modellrechnung, keine Messdaten."""
import math

for length_m in [0.25, 0.50, 0.75, 1.0]:
    period_s = 2 * math.pi * math.sqrt(length_m / 9.81)
    print(f"{length_m:0.2f} m -> {period_s:0.3f} s")
