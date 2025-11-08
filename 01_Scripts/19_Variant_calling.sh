#!/bin/bash

set -euo pipefail # Stop the script if errors occur or undefined variable is used

#Directories
WORKDIR="/data/projet2/03_Astacidea_Genome"
BAM_SORTED_FILE="$WORKDIR/Mapping_after_Assembly/remapped_after_assembly.sorted.bam"
REF_FILE="/data/projet2/03_Astacidea_Genome/Assembly/fly_result/assembly.fasta"
MAPPING_DIR="$WORKDIR/Mapping_after_Assembly"
BAM_SORTED_FILE="$MAPPING_DIR/remapped_after_assembly.sorted.bam"
VARIANT_DIR="$MAPPING_DIR/Variant_detect"
STATSDIR="$MAPPING_DIR/stats"

mkdir -p $VARIANT_DIR

#Activate conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate /data/projet2/conda/envs/env_mapping_astra

cd $VARIANT_DIR

if [ ! -f "$BAM_SORTED_FILE" ] ; then
    echo "Error no file for bam found"
    exit 1
fi

# mpileup : add probality genotypes
#    option : -f specifed the reference file
# call : call SNP and indels
#   -mv : multiallelic and rare-variant calling and output variant sites only
#   -Oz : define the output type
#   -o : output file
bcftools mpileup -f $REF_FILE $BAM_SORTED_FILE | \
bcftools call -mv -Oz -o $VARIANT_DIR/mitochrondrial_variants.vcf.gz

#Indexing the gz file
bcftools index $VARIANT_DIR/mitochrondrial_variants.vcf.gz


{
  # Adding header to the file we would create
  echo -e "CHROM\tPOS\tREF\tALT\tDP\tAD_REF\tAD_ALT\tAF"
  
  #query -f : recuperate the informations of the vcf file for adding them in tsv file for analyse. By adding the column AF for see the frequency of variation
  #Extraction and calcul of AF
  bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%INFO/DP\t[%AD]\n' \
    $VARIANT_DIR/mitochrondrial_variants.vcf.gz | \
  awk -F'\t' '
  BEGIN { OFS="\t" }
  {
    chrom = $1
    pos = $2
    ref = $3
    alt = $4
    dp = $5
    ad = $6
    
    split(ad, ad_array, ",")
    ref_depth = ad_array[1]
    alt_depth = ad_array[2]
    
    if (ref_depth == "" || ref_depth == ".") ref_depth = 0
    if (alt_depth == "" || alt_depth == ".") alt_depth = 0

    total = ref_depth + alt_depth
    if (total > 0) {
      af = alt_depth / total
    } else {
      af = 0
    }
    
    printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%.4f\n", 
           chrom, pos, ref, alt, dp, ref_depth, alt_depth, af
  }'
} > $VARIANT_DIR/mitochrondrial_snps.tsv

# Filtering the possible heteroplasmy
awk -F'\t' 'NR==1 || ($8 >= 0.05 && $8 <= 0.95)' \
  $VARIANT_DIR/mitochrondrial_snps.tsv > $VARIANT_DIR/heteroplasmy.tsv

conda deactivate
echo 'Variant detection done'