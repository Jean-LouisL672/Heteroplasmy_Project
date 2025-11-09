from Bio import SeqIO
import os

fasta_path = "/data/projet2/02_Phylogeny_part/fasta_files/all_sequences_mito.fasta"
tmp_path = fasta_path + ".tmp"

with open(tmp_path, "w") as temp:
    for rec in SeqIO.parse(fasta_path, "fasta"):
        if "complete genome" in rec.description.lower():
            SeqIO.write(rec, temp, "fasta")

# remplacer l'original après succès
os.replace(tmp_path, fasta_path)
os.remove(tmp_path) 