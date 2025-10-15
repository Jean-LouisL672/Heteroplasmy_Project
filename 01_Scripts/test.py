from Bio import SeqIO
import os
from collections import defaultdict

def fasta_files_dir():
    return '/data/projet2/02_Phylogeny_part/fasta_files/ncbi_dataset/data'

def Mitogenome_dir():
    return '/data/projet2/03_Mitogenome'

def Mitogenome_seq():

    os.makedirs(Mitogenome_dir(), exist_ok=True)

    base = fasta_files_dir()
    outputs = defaultdict(list)

    for root, dirs, files in os.walk(base):
        for file in files:
            if file.lower().endswith((".fasta", ".fa")):
                file_path = os.path.join(root, file)
                for record in SeqIO.parse(file_path, "fasta"):
                    if "mitochondrion" in (record.description or "").lower():
                        rel = os.path.relpath(root, base)
                        folder_name = "root" if rel in (".", "") else rel.replace(os.sep, "_")
                        output_file = os.path.join(Mitogenome_dir(), f"{folder_name}_mitogenome.fasta")
                        outputs[output_file].append(record)

    # write once per output file (overwrites previous run to avoid duplicates)
    for out_path, records in outputs.items():
        with open(out_path, "w") as out_handle:
            SeqIO.write(records, out_handle, "fasta")

if __name__ == "__main__":
    Mitogenome_seq()



#partie blast



blast = "/data/projet2/Blast+/linux" 

def blast_prot(accession_name_cible,accession_name,identifiant):
    seq = #seq a mettre pour le premier genes fasta
    SeqIO.write(seq,'prot.fasta', 'fasta')
    cible= Mitogenome_dir() + f"genomes\\{accession_name_cible}\\{accession_name_cible}"
    cmd_line = [blast, "-query", Mitogenome_dir() + 'prot.fasta', "-db", cible,
            "-evalue", "0.001", "-out", Mitogenome_dir() + "result_blast.xml", "-outfmt", "5"]
    
    subprocess.run(cmd_line)

