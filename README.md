# Etude de la diversité mitochondriale et l’hétéroplasmie chez les Décapodes

## Objectifs
1. Phylogénie interspécifique (20 mitogénomes complets).
2. Détection d’hétéroplasmie (lectures brutes SRA de 4 espèces d’Astacidea : assemblage de novo, variants, profondeur, k-mers).

## Structure principale
- Scripts: [01_Scripts/](01_Scripts/)
- Phase phylogénie: données dans (.gitignore) `02_Phylogeny_part/`
- Phase Astacidea (hétéroplasmie): `03_Astacidea_Genome/`
- BLAST local: [Blast+/linux/](Blast+/linux/)
- Environnements Conda ignorés (voir [environment.yml](environment.yml))

## Conda / Environnements
Exemple création IQ-TREE:
```bash
conda create -n env_iqtree
conda activate /data/projet2/conda/envs/env_iqtree
conda install bioconda::iqtree
conda deactivate 
```
Export du conda dans un fichier: [environment.yml](environment.yml)

## Pipeline Phylogénie
1. Téléchargement jeux génomes: [01_Scripts/01_download_dataset_phylo.py](01_Scripts/01_download_dataset_phylo.py)
2. Extraction mitogénomes (annotation header): [`Mitogenome_seq`](01_Scripts/02_get_mitocondrial_genome.py)
3. Standardisation / filtrage (extraction "complete genome").
4. Recadrage des séquences sur un gène pivot: [01_Scripts/07_recouper_seq.py](01_Scripts/07_recouper_seq.py)
5. Fusion FASTA: [01_Scripts/08_fusioner_record.py](01_Scripts/08_fusioner_record.py)
6. Alignement MAFFT: [01_Scripts/10_alignement.py](01_Scripts/10_alignement.py)
7. Arbre ML IQ-TREE: [01_Scripts/11_arbre_phylo_updated.py](01_Scripts/11_arbre_phylo_updated.py)

## Pipeline Hétéroplasmie (Procambarus clarkii)
1. Téléchargement Réf / Astacidea: [01_Scripts/03_download_Astacidea_genome.py](01_Scripts/03_download_Astacidea_genome.py)
2. Extraction mitogénomes RefSeq: [01_Scripts/05_get_mito_ref.py](01_Scripts/05_get_mito_ref.py)
3. Lectures SRA: [01_Scripts/06_Dowload_Reads.sh](01_Scripts/06_Dowload_Reads.sh)
4. QC / stats lectures: [01_Scripts/09_Raw_Reads_PcBio_stat.sh](01_Scripts/09_Raw_Reads_PcBio_stat.sh), [01_Scripts/12_Raw_Read_PcBio_nanoplot.sh](01_Scripts/12_Raw_Read_PcBio_nanoplot.sh)
5. Mapping brut: [01_Scripts/15_Mapping_Raw_Reads.sh](01_Scripts/15_Mapping_Raw_Reads.sh)
6. Extraction lectures mitochondriales: [01_Scripts/16_Reads_for_assembly_and_stats.sh](01_Scripts/16_Reads_for_assembly_and_stats.sh)
7. Assemblage Flye: [01_Scripts/17_Flye_Assembly.sh](01_Scripts/17_Flye_Assembly.sh)
8. Remapping sur assemblage: [01_Scripts/18_Mapping_against_assembly.sh](01_Scripts/18_Mapping_against_assembly.sh)
9. Variants / hétéroplasmie: [01_Scripts/19_Variant_calling.sh](01_Scripts/19_Variant_calling.sh)

## Variants / Hétéroplasmie
Sorties clés:
- VCF compressé


## Citations / Outils
-- BLAST+ (NCBI) : https://ftp.ncbi.nih.gov/blast/executables/blast+/LATEST/
- MAFFT : https://mafft.cbrc.jp/alignment/software/
- IQ-TREE2 : https://www.iqtree.org/
- minimap2 : https://github.com/lh3/minimap2
- samtools : https://www.htslib.org/
- bcftools : https://www.htslib.org/
- Flye : https://github.com/fenderglass/Flye
- NanoPlot : https://github.com/wdecoster/NanoPlot
- seqkit : https://bioinf.shenwei.me/seqkit/

## Auteurs
Groupe: GORISSEN Marieke, MEGUEBLI Rayan, BADIONE Jean-Louis.

