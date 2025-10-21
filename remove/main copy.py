import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


data = {

    "Voltaje(V)": [
        0.52, 1.52, 2.52, 3.53, 5.05, 5.31, 6.06, 8.04,  # resistencia
        0.04, 0.09, 0.15, 0.22, 0.28, 0.37, 0.55, 0.59,  # nicron
        0.05, 0.14, 0.22, 0.31, 0.43, 0.59, 0.83, 1.41,  # foco
        0.57, 0.65, 0.69, 0.71, 0.72, 0.73, 0.73, 0.76   # diodo 
    ],

    "Corriente(A)": [
        0.006, 0.016, 0.026, 0.036, 0.051, 0.054, 0.061, 0.082,  # resistencia
        0.012, 0.025, 0.041, 0.060, 0.075, 0.099, 0.149, 0.160,  # nicron
        0.011, 0.033, 0.050, 0.069, 0.088, 0.106, 0.125, 0.150,  # foco
        0.006, 0.025, 0.045, 0.065, 0.084, 0.095, 0.105, 0.157  # diodo
    ]
}

df = pd.DataFrame(data)

I = df["Corriente(A)"][24:32]
V = df["Voltaje(V)"][24:32]


plt.scatter(V, I, label='Datos Experimentales')
print(V)
plt.xlabel("Corriente (A)")
plt.ylabel("Voltaje (V)")
plt.title("Nicron")
plt.legend()
plt.savefig("nicron", dpi=600)
