# Quantum Hub

Course materials, exercises, and code for classes on **quantum computing**.

The repository collects weekly assignments, lecture topics, and runnable Qiskit
examples produced as the course progresses.

## Setup

This project targets **Python 3.13+**. With [uv](https://github.com/astral-sh/uv) or another PEP 621–aware tool:

```bash
uv sync
```

Or install in editable mode with your preferred workflow from `pyproject.toml`.

If you prefer `pip`, a flat list of dependencies is also provided in
`requirements.txt`:

```bash
pip install -r requirements.txt
```

## Contents

```text
quantum_hub/
├── basic_circuit.py        # Build and simulate a Bell state (Qiskit + Aer)
├── Topics/                 # Standalone topic notebooks (Bloch sphere, gates, ...)
├── first_week/             # Week 1: assignment answers and homework
├── second_week/            # Week 2: assignment, Qiskit script, proofs notebook
├── third_week/             # Week 3: assignment and Qiskit notebook
└── fourth_week/            # Week 4: assignment and supporting screenshots
```

Each `*_week/` folder holds its own assignment answers (`assigment.md`) plus the
corresponding code, notebooks, or supporting documents. The `Topics/` folder
contains reusable class notebooks:

- `QH_LAB_QC_single-checkpoint.ipynb` — Qiskit installation and first steps
- `BlochSphere_U-checkpoint.ipynb` — Bloch sphere
- `PuertasCuanticas_U.ipynb` — quantum gates
- `Mediciones_U.ipynb` — measurement simulation
- `Entrelazamiento_U.ipynb` — entanglement and measurement on IBM hardware

> Most notebooks and assignment documents are written in Spanish.

## Running the examples

Run the standalone Bell-state circuit:

```bash
python basic_circuit.py --shots 1024 --seed 42
```

Use `--no-draw` to skip printing the ASCII circuit diagram. The notebooks can be
launched with:

```bash
jupyter lab
```

## License

Released under the [MIT License](LICENSE).
