#!/bin/bash

set -euo pipefail # Stop the script if errors occur or undefined variable is used

#Directories
WORKDIR="/data/projet2/03_Astacidea_Genome"
FASTQ_FILE="$WORKDIR/Assembly/fastq/mito_reads.fastq"
REF_FILE="/data/projet2/03_Astacidea_Genome/Assembly/fly_result/assembly.fasta"
MAPPING_DIR="$WORKDIR/Mapping_after_Assembly"
STATSDIR="$MAPPING_DIR/stats"

#Create output directory if it doesn't exist
mkdir -p $MAPPING_DIR
mkdir -p $STATSDIR

#Activate conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate /data/projet2/conda/envs/env_mapping_astra

#Mapping PacBio reads to the reference using minimap2
cd $MAPPING_DIR

if [ ! -f "$FASTQ_FILE" ] ; then
    echo "Error no file for reads found"
    exit 1
fi
if [ ! -f "$REF_FILE" ] ; then
    echo "Error no file for the reference found"
    exit 1
fi
#Index the reference : 
#-d : create binary index
minimap2 -d assembly.mmi $REF_FILE

echo "Index created"

#Map the reads to the reference : 
# -a : output SAM format
# -x : preset for PacBio RS
#samtools view : Convert SAM to BAM
#-b : output BAM format
#-F 4: Exclude non maped reads
minimap2 -t 2 -ax map-pb assembly.mmi $FASTQ_FILE | samtools view -@2 -b > remapped_after_assembly.bam
echo "Mapping done"

#Convert SAM to BAM, sort and index
samtools sort remapped_after_assembly.bam -o remapped_after_assembly.sorted.bam
samtools index remapped_after_assembly.sorted.bam

echo "Sorted & Index of BAM done"

#Stats on the mapping
#flagstat : count mapped reads,unmapped,duplicate
samtools flagstat remapped_after_assembly.sorted.bam > $STATSDIR/stats_flags_remap.txt

#coverage : coverage per contig, rapide view on the ensemble of the coverage
samtools coverage remapped_after_assembly.sorted.bam > $STATSDIR/stat_coverage_remap.txt

#depth : depth at each position : can be useful for graphical reprensentation of the depth along the contigs
samtools depth remapped_after_assembly.sorted.bam > $STATSDIR/coverage_depth_remap.txt

#stats : quality of the mapping,length of the reads and more global informations on the mapping
samtools stats remapped_after_assembly.sorted.bam > $STATSDIR/global_stats_mapping_remap.txt

echo "Stats reports done"

conda deactivate