#!/usr/bin/python3
import numpy as np
import matplotlib.pyplot as plt

# ----MÉTODO GAUSS-SEIDEL----

# Sistema de ecuaciones del circuito 3
# Se forma usando mallas y ley de Kirchhoff
# Cada ecuación representa una malla del circuito

A = np.array([
    [76, -25, -50, 0, 0],
    [-25, 56, -25, -30, 0],
    [-50, -25, 131, -25, -55],
    [0, -30, -25, 86, -25],
    [0, 0, -55, -25, 111]
])

b = np.array([10, 0, 0, 0, 0])
x = np.zeros(5)
tolerancia = 1e-6
errores = []

for _ in range(1000):
    x_nueva = np.copy(x)

    for i in range(5):
        suma = 0
        for j in range(5):
            if j != i:
                if j < i:
                    suma += A[i][j] * x_nueva[j]
                else:
                    suma += A[i][j] * x[j]
        x_nueva[i] = (b[i] - suma) / A[i][i]

    error = 0
    for i in range(5):
        error += (x_nueva[i] - x[i]) ** 2 # Add that division
    error = error ** 0.5
    errores.append(error)

    x = x_nueva
    if error < tolerancia:
        break

# Imprimir solo las 5 corrientes
for corriente in x:
    print(round(corriente, 6)) # Redondear hasta orden 6

# Mostrar gráfica error vs iteraciones
plt.plot(errores, marker='o')
plt.title("Error vs Iteraciones - Método Gauss-Seidel")
plt.xlabel("Iteración")
plt.ylabel("Error")
plt.grid(True)
plt.show()