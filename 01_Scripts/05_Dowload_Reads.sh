#!/bin/bash

#Directory
GENOMEDIR="/data/projet2/03_Astracidea_Genome/fasta_files"
READDIR="/data/projet2/03_Astracidea_Genome/Reads"

#Variable SRA accession
SRA_ID=

#Create the directory where reads will be stored
mkdir -p $READDIR

#Activate conda environment with SRA tools
source /opt/conda/etc/profile.d/conda.sh
conda activate /data/projet2/conda/envs/env_mapping_astra

cd $READDIR
#Download the reads from NCBI SRA
prefetch $SRA_ID

#Convert SRA files to FASTQ format
fasterq-dump $SRA_ID --outdir $READDIR
