"""Plot Monte Carlo spread (box plot + histogram) per column of an ngspice
print file into Images/MC_<column>_TT.png.

    python3 scripts/mc_process.py Schematic/LDO/mc_data.csv
"""
import sys
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

IMAGES = Path(__file__).resolve().parent.parent / 'Images'

file_path = sys.argv[1] if len(sys.argv) > 1 else 'data.txt'

df = pd.read_csv(file_path, sep=r'\s+')
df = df.apply(pd.to_numeric, errors='coerce').dropna()

for col in df.columns:
    fig, (ax_box, ax_hist) = plt.subplots(1, 2, figsize=(14, 6))

    ax_box.boxplot([df[col]], label=[col])
    ax_box.set_xticks([1])
    ax_box.set_xticklabels([col])
    ax_box.set_title(f'Voltage Spread: {col}')
    ax_box.set_ylabel('Voltage (V)')
    ax_box.grid(True, axis='y', linestyle='--', alpha=0.7)

    ax_hist.hist(df[col], bins=20, alpha=0.7, color='C1', label=col)
    ax_hist.set_title(f'Distribution Profile: {col}')
    ax_hist.set_xlabel('Voltage (V)')
    ax_hist.set_ylabel('Sample Count')
    ax_hist.legend()
    ax_hist.grid(True, axis='y', linestyle='--', alpha=0.7)

    plt.tight_layout()
    plt.savefig(IMAGES / f'MC_{col}_TT.png')
    plt.close(fig)
