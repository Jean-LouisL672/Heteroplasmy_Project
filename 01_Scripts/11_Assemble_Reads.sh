#!/bin/bash

set -euo pipefail # Stop the script if errors occur or undefined variable is used


THREADS=$(nproc)  # Utilisation de tous les cœurs disponibles
EXTRACT_DIR="/data/projet2/03_Astacidea_Genome/Reads/Extracted_Reads"
OUTPUT_DIR="/data/projet2/03_Astacidea_Genome/Reads/Assembled_Reads"


#Activate conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate /data/projet2/conda/envs/env_assembly_astra

# Vérifie que hifiasm est accessible
if ! command -v hifiasm >/dev/null 2>&1; then
  echo "[ERREUR] hifiasm introuvable dans l'environnement '$ENV_PATH'." >&2
  exit 1
fi

#Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

#Collecte des fichiers de lectures extraites
shopt -s nullglob
READS=("$EXTRACT_DIR"/*.fastq "$EXTRACT_DIR"/*.fastq.gz "$EXTRACT_DIR"/*.fq "$EXTRACT_DIR"/*.fq.gz)

if [ ${#READS[@]} -eq 0 ]; then
  echo "[ERREUR] Aucun fichier .fastq/.fq(.gz) trouvé dans : $EXTRACT_DIR" >&2
  exit 1
fi


#Assemblage hifiasm à partir des lectures mitochondriales extraites
hifiasm -o $OUTPUT_DIR/assembly -t $THREADS "${READS[@]}" 
for gfa in $OUTPUT_DIR/assembly*.gfa; do 
    fasta="${gfa%.gfa}.fasta"
    awk '/^S/{print ">"$2"\n"$3}' "$gfa" > "$fasta"
done 

echo "Assembled reads are saved in $OUTPUT_DIR"
exit 0






