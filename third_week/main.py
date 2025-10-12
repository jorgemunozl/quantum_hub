from qiskit import QuantumCircuit
from qiskit_aer.primitives import SamplerV2 as Sampler
from qiskit_aer import AerSimulator
from qiskit.transpiler import generate_preset_pass_manager
from qiskit.visualization import plot_histogram
from qiskit.quantum_info import Statevector
import matplotlib.pyplot as plt


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


def verify_state(qc):
    Statevector
    return 

def main():
    qc = QuantumCircuit(1, 1)
    qc.h(0)
    counts = counter(qc, p1=0, p2=0)
    print(counts)
    plot_histogram(counts, title="Medición del estado")
    plt.show()


if __name__ == "__main__":
    main()
