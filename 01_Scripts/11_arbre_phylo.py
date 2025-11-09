#!/usr/bin/env python3

# arbre Maximum de Vraisemblance , on a pu montrer que ML, associé à une bonne recherche heuristique, est la méthode 
#qui a le plus de chances de retrouver la vraie phylogénie. C’est son avantage majeur au vu de notre jeux de donner avec
# un nombre limité de séquences.

import os
import shutil
import subprocess
import sys

ALIGNMENT = "/data/projet2/02_Phylogeny_part/fasta_files/all_sequences_mito_aligned.fasta"
OUTPUT_DIR = "/data/projet2/02_Phylogeny_part/arbre_phylo"
PREFIX = os.path.join(OUTPUT_DIR, "iqtree_run")


def find_iqtree():
    for cmd in ("iqtree2", "iqtree"):
        path = shutil.which(cmd)
        if path:
            return cmd, path
    return None, None


def ensure_paths():
    if not os.path.exists(ALIGNMENT):
        print(f"Error: alignment file not found: {ALIGNMENT}")
        return False
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    return True


def run_iqtree(iqcmd_path):
    # Build command: use model selection (MFP), ultrafast bootstrap and alrt
    cmd = [iqcmd_path,
           "-s", ALIGNMENT,
           "-m", "MFP",
           "-bb", "100000",
           "-alrt", "100000",
           "-nt", "AUTO",
           "-pre", PREFIX]

    print("Running:", " ".join(cmd))
    try:
        subprocess.run(cmd, check=True)
        print("IQ-TREE finished. Results in:")
        print("  ", OUTPUT_DIR)
    except subprocess.CalledProcessError as e:
        print(f"IQ-TREE failed (return code {e.returncode}).")
        print("Check stdout/stderr above or the iqtree log files in the output directory.")
        sys.exit(1)


def main():
    if not ensure_paths():
        sys.exit(1)

    cmd_name, cmd_path = find_iqtree()
    if not cmd_path:
        print("IQ-TREE (iqtree2 or iqtree) not found in PATH.")
        print("Install with conda (recommended):\n  conda install -c bioconda iqtree2\n")
        print("Or install iqtree (system packages may be available). After installation, ensure 'iqtree2' or 'iqtree' is on your PATH.")
        sys.exit(1)

    print(f"Using IQ-TREE executable: {cmd_path}")
    run_iqtree(cmd_path)


if __name__ == "__main__":
    main()
