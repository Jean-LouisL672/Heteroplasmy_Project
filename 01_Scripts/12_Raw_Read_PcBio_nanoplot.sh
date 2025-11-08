#!/bin/bash

set -euo pipefail # Stop the script if errors occur or undefined variable is used

#Directories
WORKDIR="/data/projet2/03_Astacidea_Genome/Reads"
READ_FILE="$WORKDIR/SRR14457194.fastq"
REPORTS_DIR="$WORKDIR/Reports"


#Create output directory if it doesn't exist
mkdir -p $REPORTS_DIR

#Activate conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate /data/projet2/conda/envs/env_mapping_astra

#Nanoplot, statistics on raw data PacBio reads
NanoPlot --fastq $READ_FILE -o $REPORTS_DIR/NanoPlot_PacBio --N50 --loglength

echo "Nanoplot report done"

#Deactivate conda environment
conda deactivate