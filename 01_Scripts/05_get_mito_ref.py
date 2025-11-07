#!/bin/env python3
import os
import Bio
from Bio import SeqIO

# Directories
GENOMEDIR="/data/projet2/03_Astacidea_Genome/fasta_files/genome_refseq"
MITO_DIR_OUTPUT="/data/projet2/03_Astacidea_Genome/Reference_mitogenome"

# Create output directory if it doesn't exist
os.makedirs(MITO_DIR_OUTPUT, exist_ok=True)

def Mitogenome_seq():
    #Collect sequences whose description contains 'mitochondrion' and
    #write them to one file per source folder inside MITO_DIR_OUTPUT

    for file in os.listdir(GENOMEDIR):
        if file.lower().endswith((".fasta", ".fna",".fa")):

            file_path = os.path.join(GENOMEDIR, file)
            base_name = os.path.splitext(file)[0]
            output_file = os.path.join(MITO_DIR_OUTPUT, f"{base_name}_mitogenome.fasta")

            mito_seq=[]
            for record in SeqIO.parse(file_path, "fasta"):
                if "mitochondrion" in (record.description or "").lower():
                    mito_seq.append(record)
            
            if mito_seq:
                SeqIO.write(mito_seq, output_file, "fasta")
                print(f"Written {len(mito_seq)} mitogenome sequences to {output_file}")
            else:
                print(f"No mitogenome sequences found in {file_path}")

if __name__ == "__main__":
    Mitogenome_seq()