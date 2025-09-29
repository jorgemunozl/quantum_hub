from qiskit import QuantumCircuit, QuantumRegister, ClassicalRegister
from qiskit.visualization import plot_bloch_vector, plot_bloch_multivector
from qiskit.quantum_info import Statevector
import matplotlib.pyplot as plt


if __name__ == "__main__":

    q_reg = QuantumRegister(1)
    c_reg = ClassicalRegister(1)

    qc_0 = QuantumCircuit(q_reg, c_reg)
    state_vector_0 = Statevector.from_instruction(qc_0)
    qc_1 = QuantumCircuit(q_reg, c_reg)
    qc_1.x(0)
    state_1 = Statevector.from_instruction(qc_1)
    qc_plus = QuantumCircuit(q_reg, c_reg)
    qc_plus.h(0)
    state_plus = Statevector.from_instruction(qc_plus)
    plot_bloch_multivector(state_plus)
    plot_bloch_vector([0.1, 0.2, 0.3])
    print(state_1.data)
