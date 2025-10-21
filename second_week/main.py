from qiskit import QuantumCircuit
from qiskit_aer.primitives import SamplerV2 as Sampler
from qiskit_aer import AerSimulator
from qiskit.transpiler import generate_preset_pass_manager
from qiskit.visualization import plot_histogram, plot_bloch_multivector, plot_bloch_vector
from qiskit.quantum_info import Statevector
import matplotlib.pyplot as plt
import numpy as np

def counter(qc, p1, p2):
    qc.measure(p1, p2)
    measured_circuit = qc.copy()
    measured_circuit.measure_all()
    params = []
    exact_sampler = Sampler(
        options={"backend_options": {"method": "stabilizer"}}
        )
    pass_manager = generate_preset_pass_manager(
        1, AerSimulator(method="stabilizer")
        )
    isa_circuit = pass_manager.run(measured_circuit)
    pub = (isa_circuit, params)
    job = exact_sampler.run([pub])
    result = job.result()
    counts = result[0].data.meas.get_counts()

    return counts


def state(qc):
    print(Statevector.from_instruction(qc).data)


def state_a(theta, phi):
    x = np.cos(phi)*np.sin(theta)
    y = np.sin(theta)*np.sin(phi)
    z = np.cos(theta)
    return [x, y, z]


def main():
    qc = QuantumCircuit(1, 1)
    qc.h(0)
    qc.x(0)
    qc.s(0)
    qc.t(0)
    qc.h(0)
    #plot_bloch_multivector(qc)

    phi = -np.pi/2
    theta = 3*np.pi/4
    plot_bloch_vector(state_a(theta, phi))
    state(qc)
    plt.show()


if __name__ == "__main__":
    main()
