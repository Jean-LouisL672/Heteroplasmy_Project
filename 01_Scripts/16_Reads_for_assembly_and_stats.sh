#!/bin/bash

set -euo pipefail # Stop the script if errors occur or undefined variable is used

#Directories
WORKDIR="/data/projet2/03_Astacidea_Genome"
MAPPING_DIR="$WORKDIR/Mapping_raw_reads"
STATSDIR="$MAPPING_DIR/stats"
BAM_SORTED_FILE="$MAPPING_DIR/mapped_raw_reads.sorted.bam"
FASTQ="$WORKDIR/Assembly/fastq"
REPORTS="$WORKDIR/Assembly/reports"

#Create output directory if it doesn't exist
mkdir -p $FASTQ
mkdir -p $REPORTS

#Activate conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate /data/projet2/conda/envs/env_mapping_astra

#Extract mapped reads form the bam
samtools fastq $BAM_SORTED_FILE > $FASTQ/mito_reads.fastq


if [ ! -f "$FASTQ/mito_reads.fastq" ] ; then
    echo "Error no file for reads found"
    exit 1
fi

#Creation of report of our mapped reads
NanoPlot --fastq $FASTQ/mito_reads.fastq -o $REPORTS/Nanoplot --N50 --loglength

echo "Nanoplot report done"

conda deactivate
