#!/usr/bin/env python4
import os
from Bio import SeqIO

GENES_DIR_OUTPUT = "/data/projet2/02_Phylogeny_part/mitochondrion/output_test"
FICHIER_ALIGNER = "/data/projet2/02_Phylogeny_part/fasta_files/all_sequences_mito.fasta"
OUTPUT_CLUSTAL = "/data/projet2/02_Phylogeny_part/fasta_files/all_sequences_mito_aligned.fasta"

##    SeqIO.write("", FICHIER_ALIGNER, "fasta") cela cree des bug pas besoin de cree un fasta vide "with open" s'en charge deja

def alignement():
    os.makedirs(GENES_DIR_OUTPUT, exist_ok=True)
    with open(FICHIER_ALIGNER, 'w') as result_file:
        for file in os.listdir(GENES_DIR_OUTPUT):
            if file.lower().endswith((".fasta", ".fna", ".fa")):
                fasta_path = os.path.join(GENES_DIR_OUTPUT, file)
                for record in SeqIO.parse(fasta_path, "fasta"):
                    SeqIO.write(record, result_file, "fasta")
    result_file.close()
if __name__ == "__main__":
    alignement()
