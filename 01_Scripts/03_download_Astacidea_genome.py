#!/bin/env python3
# Download Astacidea genomes (most complete, RefSeq) and extract fasta sequences
import os
import zipfile
import glob # For file pattern matching

# Directories
GENOMEDIR="/data/projet2/03_Astacidea_Genome"
ENV_NCBI="/data/projet2/conda/ncbi_datasets"
OUTPUTDIR="/data/projet2/03_Astacidea_Genome/fasta_files"

# Create directories if they don't exist
os.makedirs(GENOMEDIR, exist_ok=True)
os.makedirs(OUTPUTDIR, exist_ok=True)

# Download Astacidea genomes from NCBI
# Activate conda environment for running ncbi datasets command line
download_cmd = f'''
source /opt/conda/etc/profile.d/conda.sh
conda activate {ENV_NCBI}
datasets download genome taxon "Astacidea" \\
  --assembly-source RefSeq \\
  --reference \\
  --filename "{GENOMEDIR}/astacidea_genomes.zip"
conda deactivate
'''

exit_code = os.system(f"/bin/bash -c '{download_cmd}'")
if exit_code != 0:
    print("Error during download")
    exit(1)
print("Downloading is done")

# Unzip downloaded genomes
with zipfile.ZipFile(f"{GENOMEDIR}/astacidea_genomes.zip", 'r') as zip_ref:
    zip_ref.extractall(f"{GENOMEDIR}/astacidea_genomes")
print("Extraction is done")

# Combine all fasta files into a single file
astacidea_genomes = glob.glob(f"{GENOMEDIR}/astacidea_genomes/**/*.fna", recursive=True)
combined_fasta_path = os.path.join(OUTPUTDIR, "astacidea_genomes_all.fna")
with open(combined_fasta_path, 'w') as outfile:
    for fasta_file in astacidea_genomes:
        with open(fasta_file, 'r') as infile:
            outfile.write(infile.read())
print(f"Combined {len(astacidea_genomes)} fasta files into {combined_fasta_path}")