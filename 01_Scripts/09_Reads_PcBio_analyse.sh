#!/bin/bash

set -e # Stop the script if errors occur
set -u # Erreur if undefined variable

#Directories
READDIR="/data/projet2/03_Astacidea_Genome/Reads"
QC_REPORT_DIR="/data/projet2/03_Astacidea_Genome/Reads/QC_Reports"

#QC PacBio Reads
echo "QC report for PacBio Reads"

#Create output directory if it doesn't exist
mkdir -p $QC_REPORT_DIR

#Activate conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate /data/projet2/conda/envs/env_mapping_astra

#Run Nanoplot for analyse PacBio reads


