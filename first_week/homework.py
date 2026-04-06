import numpy as np


def bloch_sphere_pos(theta, phi):
    x = np.cos(theta) * np.sin(phi)
    y = np.sin(theta) * np.sin(phi)
    z = np.cos(phi)
    return [x, y, z]


def generate_state(theta, phi):
    e1 = np.cos(theta / 2)
    e2 = np.exp(1j * phi) * np.sin(theta / 2)

    return np.array([e1, e2])


angle = 3 * np.pi / 4 * 1j

value = 1 / 2 * (1 - np.exp(angle))
print(value)

# [0.14644661+0.35355339j 0.85355339-0.35355339j]


def generar_statevectors(rotaciones, repiticiones):
    theta_0 = np.pi / 2
    phi_0 = np.pi / 6
    state_vector_0 = generate_state(theta_0, phi_0)
    state_ang = {
        "theta": theta_0,
        "phi": phi_0,
    }
    states = [
        {
            "estado_1_ang": state_ang,
            "estado_1_vector": state_vector_0,
        }
    ]
    for i in range(1, repiticiones):
        new_angle_theta = states[i - 1][f"estado_{i}_ang"]["theta"] + rotaciones[0]
        new_angle_phi = states[i - 1][f"estado_{i}_ang"]["phi"] + rotaciones[1]
        new_state_vector = generate_state(new_angle_theta, new_angle_phi)

        new_state_ang = {
            "theta": new_angle_theta,
            "phi": new_angle_phi,
        }

        new_state = {
            f"estado_{i + 1}_ang": new_state_ang,
            f"estado_{i + 1}_vector": new_state_vector,
        }
        states.append(new_state)
    return states


rotaciones = [np.pi / 12, np.pi / 6]
repiticiones = 5

resultados = generar_statevectors(rotaciones, repiticiones)

for i in range(1, repiticiones + 1):
    pass
# print(f"estado_{i}", end=" ")
#  print(resultados[i-1][f"estado_{i}_ang"], end=" ")
#   print(resultados[i-1][f"estado_{i}_vector"])

angles_state_2 = resultados[1]["estado_2_ang"]

pos = bloch_sphere_pos(angles_state_2["phi"], angles_state_2["theta"])

# print("estado 2 : [x,y,z]", [round(float(x), 2) for x in pos])
