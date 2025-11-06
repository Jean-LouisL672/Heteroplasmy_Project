#!/bin/bash

set -e # Stop the script if errors occur
set -u # Erreur if undefined variable

#Directories
GENOMEDIR="/data/projet2/03_Astacidea_Genome/fasta_files"
READDIR="/data/projet2/03_Astacidea_Genome/Reads"

#Variable SRA accession for the species Procambarus clarkii
SRA_ID=SRR14457194

#Create the directory where reads will be stored
mkdir -p $READDIR

#Activate conda environment with SRA tools
source /opt/conda/etc/profile.d/conda.sh
conda activate /data/projet2/conda/envs/env_mapping_astra

cd $READDIR
#Download the reads from NCBI SRA
echo "Downloading read from SRA id: $SRA_ID"
prefetch $SRA_ID

#Convert SRA files to FASTQ format
echo "Converting SRA to FASTQ"
fasterq-dump $SRA_ID --outdir $READDIR

echo "Download and conversion are done. Find the FASTQ files in $READDIR"