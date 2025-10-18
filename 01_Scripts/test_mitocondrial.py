
import Bio
from Bio import SeqIO
import os

def fasta_files_dir():
    return '/data/projet2/02_Phylogeny_part/fasta_files/ncbi_dataset/data'
 

def Mitogenome_dir():
    return '/data/projet2/03_Mitogenome'

def Mitogenome_seq():
    #Collect sequences whose description contains 'mitochondrion' and
    #write them to one file per source folder inside Mitogenome_dir().
    os.makedirs(Mitogenome_dir(), exist_ok=True)

    for root, dirs, files in os.walk(fasta_files_dir()):
        for file in files:
            if file.lower().endswith((".fasta", ".fa")):
                file_path = os.path.join(root, file)
                for record in SeqIO.parse(file_path, "fasta"):
                    if "mitochondrion" in (record.description or "").lower():
                        folder_name = os.path.basename(root) or "root"
                        output_file = os.path.join(Mitogenome_dir(), f"{folder_name}_mitogenome.fasta")
                        # append so multiple files from the same folder accumulate in the same output
                        with open(output_file, "a") as out_handle:
                            SeqIO.write(record, out_handle, "fasta")


Mitogenome_seq()
