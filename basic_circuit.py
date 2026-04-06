#!/usr/bin/env python3

from __future__ import annotations

import argparse

from qiskit import QuantumCircuit
from qiskit_aer import AerSimulator
from qiskit.transpiler import generate_preset_pass_manager


def build_bell_circuit() -> QuantumCircuit:
    qc = QuantumCircuit(2, 2)
    qc.h(0)
    qc.cx(0, 1)
    qc.measure([0, 1], [0, 1])
    return qc


def run_counts(qc: QuantumCircuit, shots: int, seed: int | None) -> dict[str, int]:
    backend = AerSimulator()
    pass_manager = generate_preset_pass_manager(optimization_level=1, backend=backend)
    isa_circuit = pass_manager.run(qc)

    run_kwargs = {"shots": shots}
    if seed is not None:
        run_kwargs["seed_simulator"] = seed

    job = backend.run(isa_circuit, **run_kwargs)
    result = job.result()
    return result.get_counts()


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Build and simulate a basic quantum circuit (Bell state)."
    )
    parser.add_argument("--shots", type=int, default=1024)
    parser.add_argument("--seed", type=int, default=None)
    parser.add_argument(
        "--no-draw", action="store_true", help="Do not print ASCII circuit diagram."
    )
    args = parser.parse_args()

    qc = build_bell_circuit()
    if not args.no_draw:
        print(qc.draw(output="text"))

    counts = run_counts(qc, shots=args.shots, seed=args.seed)
    print("Counts:", dict(sorted(counts.items())))


if __name__ == "__main__":
    main()
