#!/bin/env python3
# Download genomes for phylogenetic analysis from NCBI query and extract files
import os
import sys
import zipfile


#Directories
GENOMEDIR="/data/projet2/02_Phylogeny_part"
ENV_NCBI="/data/projet2/conda/ncbi_datasets"

#Directory to save fasta files after extraction
OUTPUTDIR="/data/projet2/02_Phylogeny_part/fasta_files"

# Create directory if it doesn't exist
os.makedirs(GENOMEDIR, exist_ok=True)
os.makedirs(OUTPUTDIR, exist_ok=True)

# Download genomes from NCBI
# Activate conda environnement for running ncbi datasets command line
   #Use f string for reproducibility of code cause of the variables

download_cmd = f'''
source /opt/conda/etc/profile.d/conda.sh
conda activate {ENV_NCBI}
datasets download genome taxon "Decapoda" \\
  --assembly-level chromosome,complete \\
  --reference \\
  --include genome \\
  --filename "{GENOMEDIR}/decapoda_genomes.zip"
conda deactivate
'''

exit_code = os.system(f"/bin/bash -c '{download_cmd}'")

if exit_code != 0:
    print("Error during download")
    exit(1)
print("Downloading is done")






