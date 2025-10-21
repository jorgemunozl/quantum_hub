import numpy as np
import matplotlib.pyplot as plt

# Data
voltaje = np.array([
    0.52, 1.52, 2.52, 3.53, 5.05, 5.31, 6.06, 8.04,  # resistencia
    0.04, 0.09, 0.15, 0.22, 0.28, 0.37, 0.55, 0.59,  # nicron
    0.05, 0.14, 0.22, 0.31, 0.43, 0.59, 0.83, 1.41,  # foco
    0.57, 0.65, 0.69, 0.71, 0.72, 0.73, 0.73, 0.76   # diodo 
])
corriente = np.array([
    0.006, 0.016, 0.026, 0.036, 0.051, 0.054, 0.061, 0.082,  # resistencia
    0.012, 0.025, 0.041, 0.060, 0.075, 0.099, 0.149, 0.160,  # nicron
    0.011, 0.033, 0.050, 0.069, 0.088, 0.106, 0.125, 0.150,  # foco
    0.006, 0.025, 0.045, 0.065, 0.084, 0.095, 0.105, 0.157   # diodo
])

# Select sections
V_res = voltaje[0:8]
I_res = corriente[0:8]
V_nic = voltaje[8:16]
I_nic = corriente[8:16]

# Linear fits: V = R * I + b
coef_res = np.polyfit(I_res, V_res, 1)
coef_nic = np.polyfit(I_nic, V_nic, 1)

# Predicted values
V_res_pred = np.polyval(coef_res, I_res)
V_nic_pred = np.polyval(coef_nic, I_nic)

# R^2 calculation
def r2_score(y, y_pred):
    ss_res = np.sum((y - y_pred) ** 2)
    ss_tot = np.sum((y - np.mean(y)) ** 2)
    return 1 - (ss_res / ss_tot)

r2_res = r2_score(V_res, V_res_pred)
r2_nic = r2_score(V_nic, V_nic_pred)

# Results
R_res, b_res = coef_res
R_nic, b_nic = coef_nic

print(f"Resistor: V = {R_res:.2f} * I + {b_res:.2f},  R² = {r2_res:.4f}")
print(f"Nicrom:   V = {R_nic:.2f} * I + {b_nic:.2f},  R² = {r2_nic:.4f}")

# Plot
plt.figure(figsize=(7,5))
plt.scatter(I_res, V_res, label='Resistencia', color='blue')
plt.plot(I_res, V_res_pred, color='blue', linestyle='--')

plt.scatter(I_nic, V_nic, label='Nicrom', color='red')
plt.plot(I_nic, V_nic_pred, color='red', linestyle='--')

plt.xlabel("Corriente (A)")
plt.ylabel("Voltaje (V)")
plt.legend()
plt.grid(True)
plt.show()
