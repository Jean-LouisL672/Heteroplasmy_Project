#!/bin/bash

set -euo pipefail # Stop the script if errors occur or undefined variable is used

#Directories
WORKDIR="/data/projet2/03_Astacidea_Genome/Reads"
READ_FILE="$WORKDIR/SRR14457194.fastq"
REPORTS_DIR="$WORKDIR/Reports"

#QC PacBio Reads
echo "QC report for PacBio Reads"

#Create output directory if it doesn't exist
mkdir -p $REPORTS_DIR

#Activate conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate /data/projet2/conda/envs/env_mapping_astra

#Statistics on raw PacBio reads
seqkit stats $READ_FILE > $REPORTS_DIR/Raw_Reads_stats.txt

echo "report done"

#Deactivate conda environment
conda deactivate





