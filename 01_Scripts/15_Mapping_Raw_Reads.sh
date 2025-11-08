#!/bin/bash

set -euo pipefail # Stop the script if errors occur or undefined variable is used

#Directories
WORKDIR="/data/projet2/03_Astacidea_Genome"
READ_FILE="$WORKDIR/Reads/SRR14457194.fastq"
REF_FILE="/data/projet2/03_Astacidea_Genome/Reference_mitogenome/Procambarus_clarkii_mitogenome_ref.fasta"
MAPPING_DIR="$WORKDIR/Mapping_raw_reads"
STATSDIR="$MAPPING_DIR/stats"

#Create output directory if it doesn't exist
mkdir -p $MAPPING_DIR
mkdir -p $STATSDIR

#Activate conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate /data/projet2/conda/envs/env_mapping_astra

#Mapping PacBio reads to the reference using minimap2
cd $MAPPING_DIR

if [ ! -f "$READ_FILE" ] ; then
    echo "Error no file for reads found"
    exit 1
fi
if [ ! -f "$REF_FILE" ] ; then
    echo "Error no file for the reference found"
    exit 1
fi
#Index the reference : 
#-d : create binary index
minimap2 -d Procambarus_clarkii_mitogenome.mmi $REF_FILE

echo "Index created"

#Map the reads to the reference : 
# -a : output SAM format
# -x : preset for PacBio RS
#samtools view : Convert SAM to BAM
#-b : output BAM format
#-F 4: Exclude non maped reads
minimap2 -t 4 -ax map-pb Procambarus_clarkii_mitogenome.mmi $READ_FILE | samtools view -@ 4 -b -F 4 > mapped_raw_reads.bam
echo "Mapping done"

#Convert SAM to BAM, sort and index
samtools sort mapped_raw_reads.bam -o mapped_raw_reads.sorted.bam
samtools index mapped_raw_reads.sorted.bam

echo "Sorted & Index of BAM done"

#Stats on the mapping
#flagstat : count mapped reads,unmapped,duplicate
samtools flagstat mapped_raw_reads.sorted.bam > $STATSDIR/stats_flags.txt

#coverage : coverage per contig, rapide view on the ensemble of the coverage
samtools coverage mapped_raw_reads.sorted.bam > $STATSDIR/stat_coverage.txt

#depth : depth at each position : can be useful for graphical reprensentation of the depth along the contigs
samtools depth mapped_raw_reads.sorted.bam > $STATSDIR/coverage_depth.txt

#stats : quality of the mapping,length of the reads and more global informations on the mapping
samtools stats mapped_raw_reads.sorted.bam > $STATSDIR/global_stats_mapping.txt

echo "Stats reports done"

conda deactivate