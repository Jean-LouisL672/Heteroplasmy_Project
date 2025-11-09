#!/usr/bin/env python3
import os
from Bio import SeqIO, pairwise2
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord


GENOMEDIR = "/data/projet2/02_Phylogeny_part/mitochondrion"
GENES_DIR_OUTPUT = "/data/projet2/02_Phylogeny_part/mitochondrion/output_test"
SEQ_FASTA = "/data/projet2/02_Phylogeny_part/fasta_files/seq.fasta"

# Séquence CYTB qui sera le premier genes des séquences 
#gene="CYTB"
seq=(
    "ATGACAACACCAATTCGGAAAACGCATCCACTATTCAAAATTATGAATGGAGCTATAGTTGACATACCTA"
    "TTCCAAGAAATATTTCAACACTTTGAAATTTTGGTTCTCTATTAGGTCTTTGTTTATCAGTTCAAATTCT"
    "CACAGGAATTTTTCTCGCAATACATTATACAGCAGATATTAATTTAGCTTTCTCCAGAGTCGCTCACATT"
    "TGTCGCGACGTCAATTATGGCTGACTTTTGCGAACAATGCACGCTAACGGGGCATCATTTTTCTTTATCT"
    "GCCTTTACATGCATATTGGCCGAGGAATTTACTATGGATCTTTTTTATTTATTGAAGTATGGATAATTGG"
    "AGTTTTTATCTTATTCGCCACCATAGCAACTGCTTTCTTGGGATACGTTCTACCTTGAGGCCAAATATCT"
    "TTTTGAGGAGCCACTGTAATTACAAATTTATTCTCAGCTATTCCTTACGTAGGCACTGACTTAGTGCAAT"
    "GAATTTGAGGAGGTTTTTCTGTAAGCAACGCCACCCTAACACGATTCTTTACCCTTCATTTTTTATTACC"
    "CTTCGTAGTTATAGCACTCTCTGGCATTCACATTGTTTTCTTACATCAAAGAGGGTCAGGGAATCCATTA"
    "GGTATTTCAAGCCAACCTGATAAAGTTCCCTTCCATCCCTATTTTTCCTTTAAAGATCTAGTTGGGTTTA"
    "TTGTTCTACTCACATTATTAGTTATGATTACTCTACTAGACCCATATCTCTTAGGAGATCCCGACAATTT"
    "TATCCCAGCTAATCCCATGTCCACCCCAGCACATATTCAACCTGAATGATACTTCTTATTTGCCTATGCA"
    "ATTTTACGTTCTATCCCTAATAAAATGGGAGGAGTTATTGCCCTAGTTTTATCAGTTGCCATTATTATAA"
    "TTTTACCAGCAACACATTGTTCAAAATTCCGAAGATTAGCATTTTACCCATTAAGTCAATTTTTATTCTG"
    "ATCTTTGGTATCAATCTTAGTCTTACTAACATGAATCGGGGCCCGGCCAGTAGAGGATCCTTATATCTTA"
    "ACGGGTCAAATCCTAACAGTCCTATATTTCTCCTACTTCGTAATTAATCCTATTTCCATATATTTATGAG"
    "ACTCCCTATTAGATT"
)

# Enregistre la séquence de référence
os.makedirs(os.path.dirname(SEQ_FASTA), exist_ok=True)
seq_record = SeqRecord(Seq(seq), id="CYTB", description="")
SeqIO.write(seq_record, SEQ_FASTA, "fasta")



def get_alignment_start(query, target): #alignement local pour la boucle
    alignments = pairwise2.align.localms(query, target, 2, -1, -5, -1)
    best = alignments[0]
    query_start = best.start  # Position de départ de l’alignement
    return query_start


def create_sequences():
    os.makedirs(GENES_DIR_OUTPUT, exist_ok=True)
    # Lecture de la séquence de référence 
    ref_seq = str(next(SeqIO.parse(SEQ_FASTA, "fasta")).seq)
    for file in os.listdir(GENOMEDIR):
        if file.lower().endswith((".fasta", ".fna", ".fa")):
            fasta_path = os.path.join(GENOMEDIR, file)
            records = []
            for record in SeqIO.parse(fasta_path, "fasta"):
                target_seq = str(record.seq) 
                start = get_alignment_start(ref_seq, target_seq)
                # Coupe la séquence à partir de la position trouvée
                start = max(0, min(start, len(target_seq))) # s'assure que start est dans les limites dans le cas des séquences coupees
                cut_seq = target_seq[start:] + target_seq[:start] 
                # Crée un nouvel enregistrement FASTA
                new_rec = SeqRecord(Seq(cut_seq), id=record.id, description=record.description)
                records.append(new_rec)
            if records: 
                SeqIO.write(records,f"/data/projet2/02_Phylogeny_part/mitochondrion/output_test/cut_{file}", "fasta")


if __name__ == "__main__":
    create_sequences()
