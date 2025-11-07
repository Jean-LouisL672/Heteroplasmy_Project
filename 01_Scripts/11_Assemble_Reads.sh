#!/bin/bash

set -euo pipefail # Stop the script if errors occur or undefined variable is used


THREADS=16
EXTRACT_DIR="/data/projet2/03_Astacidea_Genome/Reads/Extracted_Reads"
OUTPUT_DIR="/data/projet2/03_Astacidea_Genome/Reads/Assembled_Reads"


#Activate conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate /data/projet2/conda/envs/env_assembly_astra

# Vérifie que hifiasm est accessible
if ! command -v hifiasm >/dev/null 2>&1; then
  echo "[ERREUR] hifiasm introuvable dans l'environnement '$ENV_PATH'." >&2
  exit 1

#Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

READS =("$EXTRACT_DIR"/*.fastq "$EXTRACT_DIR"/*.gz)


#Assemblage hifiasm à partir des lectures mitochondriales extraites
hifiasm -o $OUTPUT_DIR/assembly -t $THREADS "${READS[@]}" 
for fq in $OUTPUT_DIR/assembly*.gfa; do 
    awk '/^S/{print ">"$2"\n"$3}' $fq > ${fq%.gfa}.fasta 
done 

echo "Assembled reads are saved in $OUTPUT_DIR"
exit 0

#générer un fichier statistiques de l'assemblage
assembly_stats.py $OUTPUT_DIR/assembly.fasta > $OUTPUT_DIR/assembly_stats.txt 




