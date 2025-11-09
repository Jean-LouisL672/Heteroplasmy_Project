import os
import shutil
from Bio import SeqIO
import subprocess
mafft_path = shutil.which("mafft")
GENES_DIR_OUTPUT = "/data/projet2/02_Phylogeny_part/mitochondrion/output_test"
FICHIER_ALIGNER = "/data/projet2/02_Phylogeny_part/fasta_files/all_sequences_mito.fasta"
OUTPUT_CLUSTAL = "/data/projet2/02_Phylogeny_part/fasta_files/all_sequences_mito_aligned.fasta"


def alignement():
    os.makedirs(GENES_DIR_OUTPUT, exist_ok=True)
    with open(OUTPUT_CLUSTAL, "w") as out:
        subprocess.run([mafft_path, "--auto", "--inputorder", FICHIER_ALIGNER], stdout=out, stderr=subprocess.PIPE, text=True)
    # Aligner les séquences avec mafft

    
if __name__ == "__main__":
    alignement()

