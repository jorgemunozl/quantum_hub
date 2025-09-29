import qiskit
import numpy as np


def incremento(delta_theta, delta_phi, state):
    new_state = []
    return new_state

def generar_statevectors(rotaciones: list, repiticiones: int):
    initial_state = [np.pi/2, np.pi/6]
    states = [initial_state]
    for i in range(repiticiones):
        state = incremento(rotaciones[0], rotaciones[1], states[i])
        states.append(state)
    return states

if __name__ == "__main__":
    delta_theta = np.pi
    delta_phi = np.pi/2
    rotaciones = [delta_theta,  delta_phi]
    repiticiones = 10
    generar_statevectors(rotaciones, repiticiones)
