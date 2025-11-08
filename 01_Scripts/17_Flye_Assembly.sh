#!/bin/bash

set -euo pipefail # Stop the script if errors occur or undefined variable is used

#Directories
WORKDIR="/data/projet2/03_Astacidea_Genome"
FASTQ_FILE="$WORKDIR/Assembly/fastq/mito_reads.fastq"
ASSEMBLY_DIR="$WORKDIR/Assembly"
OUTPUT_FLYE="$ASSEMBLY_DIR/fly_result"

#Verify if the file exist
if [ ! -f "$FASTQ_FILE" ] ; then
    echo "Error no file for reads found"
    exit 1
fi

#Create directory
mkdir -p $OUTPUT_FLYE

#Activate conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate /data/projet2/conda/envs/env_assemblage_asta

cd $ASSEMBLY_DIR

#Proceed to the assembly
flye --pacbio-raw $FASTQ_FILE --out-dir $OUTPUT_FLYE --threads 2

echo "Assembly Done"

conda deactivate