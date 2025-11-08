# Cahier de laboratoire - Projet Hétéroplasmie

### Membres du groupe :
- BADIONE Jean-Louis
- GORISSEN Marieke
- MEGUEBLI Rayan

## 10 Septembre : ~ 1h30
- Jean-Louis & Marieke

1. Create GitHub repository and link to the server
2. Install Conda et create environment :
     - environment_projet : python environment
     - ncbi_datasets : environment downloading NCBI datasets genomes


## 28 Septembre : 
- Marieke ~ 1h30
     - Try to create bash script for download Decapoda Genome from NCBI :
     > /projet2/01_Scripts/download_genome_phylo.sh
     - For the moment is dowloading 21 genomes sequences in a zip file in a new directory :
     >/projet2/02_Phylogeny_part
     - Maybe see if it's possible to use the zip file for our project or modified him or downloading each genome in one file separate.

**- may be create a python file for unzip the file for use it next time**

## 02 octobre :
- Marieke ~50 min

     - Try to run and rewrite the previous file
          > download_genome_phylo.sh
     
     - to
          > /projet2/01_Scripts/download_genome_phylo.py


     - The file is now a python file who can be run after enter this command lines :

      conda activate environment_projet
      python3 download_genome_phylo.py

     - It's continue to downloading 21 ncbi dataset files, may be it's possible to have only fasta file.
     - The step two for unzip the file is not test for the moment

## 05 octobre : 
- Jean-Louis ~ 1H
     - Create a clean working folder for processing downloaded genomes by Marieke
     - The downloaded files will be in FASTA format (.fasta), which is a standard text-based format containing nucleotide sequences (A, T, G, C) and their corresponding identifiers (NCBI accession numbers). Each file will contain a single complete mitochondrial sequence (circular genome) for a given decapod species.

## 06 octobre :
- Marieke ~ 1h15

    - First file for **downloading data_set** from ncbi, need to :
          
          - cd 01_Scripts
          - conda activate environment_projet
          - python3 01_download_dataset_phylo.py

     - the python file activate the ncbi environnement and downloading a zip file containing 21 sequences in fasta format

     - Second file for unzip the **decapoda_genomes.zip**

           - cd 01_Scripts
           - conda activate environment_projet
           - python3 02_unzip_ncbi_data.py         

**It's need to see if the second file work great for unzip.**

## 06 Octobre : 
- Jean-Louis ~ 2H00
     - I create a Python script named Standardize_and_control to verify the quality and consistency of the downloaded mitochondrial genomes, rename them in a standardized way, and generate a control report. This step ensures that all FASTA files are properly formatted and ready for further phylogenetic analyses such as alignment (MSA) and annotation.
     - The ZIP archive containing the mitochondrial genomes (decapoda_genomes.zip) was extracted into the output directory. After extraction, all Decapoda mitochondrial genome files were accessible for processing.
     - A renaming system was implemented to extract the accession number and species name from each FASTA header and rename the files according to a standardized naming convention. This guarantees that all files follow a consistent structure.
     - Each FASTA file was checked to ensure:
     It starts with a proper FASTA header (line beginning with “>”).
     The nucleotide sequence contains only valid characters (A, T, G, C, or N).
     A status message (“OK” or the type of issue) was recorded for every file.
     - All files that passed the verification step were renamed following the standardized naming convention. This ensures consistent and easily identifiable filenames across all mitochondrial genomes.



## 07 octobre
- Marieke ~ 20 min

     - Delete the file 02_unzip_ncbi_data.py, for using a command line to unzip : **decapoda_genomes.zip**


           From folder projet2 in terminal :
           - cd 02_Phylogeny_part
           - conda activate environment_projet
           - python3 -m zipfile -e decapoda_genomes.zip fasta_files
     
     - This command line permit to extract files from the zip file, we obtain fasta file where we have to find the mitochondrion genome.


## 09 octobre 
- Marieke, Jean - Louis, Rayan ~ 2h00

     - Brainstorming together about the organisation of the rest of the project concerning extraction of mitochondrial genome of our fasta file from ncbi (*.fna)
     - Decide to put all the fasta file in the same folder /data/projet2/02_Phylogeny_part/fasta_files

          - for give more facilities to extract sequence with the help of a script


## 13 octobre 
- Jean-Louis ~ 2H 

     - I fixed the last remaining issues with the Git repository, as there were still some errors to correct (mainly related to file structure and synchronization). After these adjustments, the repository is now fully functional and properly organized.
     - I also designed a script to identify mitochondrial genomes among the sequences contained in the fasta_files directory.
     The goal of this script is to automatically go through all FASTA files, detect those containing a single complete sequence (corresponding to a mitochondrial genome), and extract them into a dedicated folder for further analyses.

## 14 octobre
- rayan ~  3h
     - I creatd a scipt that extract all mitocondrial files from the complete genome files, the script work by copying the recrd containing "mitochondrion" in it because Other genome without it have their mitochondrion genome dispatched in diffrent scafold.
     and created the draft of a scipt for blasting all the mitocondrial genome and cutting them so they all start at the same genes for future alignment. I put the blast program inside the Blast+ files so we can process it in local with out own database of micodrial genes withpout depending of an extern servor than can go down


## 15 octobre
 - rayan ~ 1h30
 I tried to install biopython into the conda environment unsuccesfully, it installed inside my path instead of the python path in conda even with "conda install"


## 17 octobre 
- Marieke ~ 20 min

     - **Move the all fasta file** from ncbi-dataset in

      /data/projet2/02_Phylogeny_part/fasta_files 

     - This was done to make it easier to create the code that allows us to extract mitochondrial genomes later.


## 18 octobre 
- Jean-Louis ~ 10 min 

     - creating a conda environment to install biopython with : 
     conda create -n  biopython biopython


- Marieke ~ 2h30

     - modified the file test_mitochondrial.py created  by Rayan for being adapted on or directories 
     - i rename the file : **02_get_mitochondrial_genome.py**
     - i first test the file on one .fna files for seeing if the script work 

          - GENOMEDIR="/data/projet2/02_Phylogeny_part/fasta_files/subset"

      - cd 01_Scripts 
      - conda activate /data/projet2/conda/biopython
      - python3 02_get_mitocondrial_genome.py &
      - conda deactivate

     - The job was a succed so i run the script on the all file after changing the GENOMEDIR path : /data/projet2/02_Phylogeny_part/fasta_files


      - cd 01_Scripts 
      - conda activate /data/projet2/conda/biopython
      - nohup python3 /data/projet2/01_Scripts/02_get_mitocondrial_genome.py > /data/projet2/01_Scripts/mito.log 2>&1 & 
      - conda deactivate

     - nohup permit to run the script in background for see the avancment of the job : ps aux | grep 02_get_mitocondrial_genome.py
     - to see the complete log : cat /data/projet2/01_Scripts/mito.log
     - to see the files created : ls -lh /data/projet2/02_Phylogeny_part/mitochondrion/


## 19 octobre :
- Marieke ~ 1h

     - The jobs was done great and we find in mito.log our print of the script.
     - With : **cat /data/projet2/01_Scripts/mito.log | grep "^No" | wc -l**, we can see their is 5 genomes where the term "mitochondrion" is not found and 16 genomes where we find the term (**cat /data/projet2/01_Scripts/mito.log | grep "^Written" | wc -l**)

     -> Goal : see if their is another word for the mitochondrial genome in the 5 files where we dont find "mitochondrion"

      - conda activate /data/projet2/conda/environment_projet
      - conda install bioconda::seqkit
      - seqkit version : seqkit v2.10.1

     - use of seqkit for see if their is an other term for mitochondrial genome in this 5 files and their is no mitochondrial genome header in the 5 files.

- rayan ~ 2h
      I advenced the scipt named "wip (Work in progress) blast" that blast all the mitocondrial genome with a target genes commun to all, this gens will be then rearanged so the target genes is the first one of the genomes, for the alignment. i created the blast output folder that will contain the "blasdte.xml" out files



## 28 octobre :
- Marieke ~15min

     - I created the files missing_mito_mention.txt in /data/projet2/02_Phylogeny_part/mitochondrion
     - this file can be helpful for the process of finding the part of the genome can be correspond to mitochonrdial geneome by a blast against the other 16 mitochondrion genome

           cat *.fasta > 16_mito_genome_ref.fasta
     - Concact all the mitochondrion genome of our 16 genomes where a mitochondrion was found
     - After looking the content by : 
     
           grep "^>" 16_mito_genome_ref.fasta | wc -l
     
     - 17 header are found, so in one file, their is two header containing mitochondrion mention

     - The created file 16_mito_genome_ref.fasta can help us for the blast to find in the 5 files mitochondrion sequence

## 30 octobre : 
- Jean-Louis ~ 2H

     - Inspection and detection of mitochondrial sequences in genomes
     Objective: To identify mitochondrial sequences present in the genomic files in the 02_Phylogeny_part/fasta_files folder, either through explicit annotation in the headers or by sequence similarity with a reference mitochondrial gene.

     - Inspection of headers:
     For each .fna file, I started by displaying the first 10 lines to view the headers and assess whether mitochondrial annotation was already present.
          for f in 02_Phylogeny_part/fasta_files/*.fna; do
           echo "== $f =="
           head -n 10 "$f"
           echo "---"

     - Searching for mitochondrial patterns:
     I planned to use a grep command to search the headers for keywords such as mitochondrion, mitochondrial, mitogenome, mito, plasmid, etc., in order to identify potentially mitochondrial sequences.

          grep -iHn -E "mitochondrion|mito|mitochondrie|mitochondrial|mitogenome|plasmid|mitochondr"
     
     - Identification by similarity (BLAST):
     For files that do not contain explicit annotations, I have prepared a BLAST-based approach:
     Use a reference mitochondrial gene (reference_mito_gene.fasta) to search for homologous regions in each genome.
     Build a BLAST database for each genome.
     Run blastn with appropriate parameters (e-value = 1e-6, max 50 hits).

     - The script has not yet been tested and is probably not complete.
     Some variables (such as the path to the reference gene) will need to be adjusted before execution.

     - Finally, we're going to use the script made by Rayan, so mine is deleted.


## 31 octobre 

- Jean-Louis ~ 1H 
     
     - Creation of a script: This script is used to automatically download the reference genomes of Astacidae (Astacidea clade) from the NCBI database using the datasets command.
     
     - Defining the working directories: The script creates the necessary directories to store the downloaded ZIP file and the future FASTA files.
     
     - Preparing the NCBI command
     It constructs a Bash command that:
     activates the conda environment containing the datasets command,
     downloads the genomes of the "Astacidea" taxon (it is better to use TaxID 6712),
     limits the search to complete or chromosome-level assemblies,
     and saves everything in an astacidea_genomes.zip file.

     - Executing the download
     The command is executed via Python (os.system).
     If the download is successful, the message "Downloading is done" is displayed; otherwise, an error is reported.

     - Preparation for extraction
     The zipfile module is imported to, eventually, extract the FASTA sequences from the ZIP file to a dedicated folder (this function is not yet activated in this version).
     
     - This script sets up an automated and reproducible procedure to obtain the complete RefSeq genomes of Astacidea species, using the NCBI Datasets command-line tool in a conda environment configured for this project.

## 3 novembre 
- Jean-Louis ~ 1H 

     - I tried to modify the Astacidea genome download script so that all the FASTA files are merged into a single file


## 4 novembre 
- Marieke ~ 2h

     - Reflections on what tools can i use and reading the documentation of them

     - Creating a new conda environnement for the mapping step of the Astracidea Genome :

      conda create -n env_mapping_astra
     - to activate the environment run :

      conda activate /data/projet2/conda/envs/env_mapping_astra

     - Installing packages necessary for this step 
     
          - sra-tools version 3.2.1 : for recuparate the raw reads of genome :
          - minimap2 version 2.30 : for the mapping step because we have long reads to map to the reference

      conda install bioconda::sra-tools
      conda install bioconda::minimap2


- Jean-Louis ~ 1H 

     - I keep thinking about how to make my code work.

## 5 novembre
- Marieke ~ 1h30

     - like the first part of the project, i create a fasta file folder where i would like to put the fasta file dowload from the ncbi by Jean Louis in /data/projet2/03_Astacidea_Genome.
     - I would also extract the mitochondrion genome from the reference file by using the script /01_Scripts/04_get_mito_genome_Astracidea.py
     - I create the file /01_Scripts/05_Dowload_Reads.sh for dowloading reads of genome from one of the Astacidea genome we have. I start to complete the script.

- Jean-Louis ~ 30 min 

     - Retrieval of the 4 sequences that are stored in 03_Astacidea_genome/Astacidea_genome/ncbi_dataset

## 6 novembre 
- Marieke ~ 4h

     - I move the fasta file from the ncbi of Astacidea genome into the folder in this directory : /data/projet2/03_Astacidea_Genome/fasta_files
     
     - I run the script : 04_get_mito_genome_Astracidea.py for keep only mitochondrial genome annotate in the header


      - cd 01_Scripts 
      - conda activate /data/projet2/conda/biopython
      - nohup python3 /data/projet2/01_Scripts/04_get_mito_genome_Astacidea.py > /data/projet2/01_Scripts/mito_2.log 2>&1 & 
      - conda deactivate   

     - No mitogenome find in the four files, so i search the mention mitochondrion but is not present because it's GenBank fasta.
     - So i decided to download the 2 files genomes from Refseq for having the mitochondrial genome reference for the mapping 

           - conda activate /data/projet2/conda/ncbi_datasets
           - datasets download genome taxon "Astacidea" --assembly-level chromosome --assembly-source RefSeq --filename "/data/projet2/03_Astacidea_Genome/fasta_files/astacidea_ref_genome.zip" 
           - conda deactivate

     - I extract the genome by unzip the file
      
           - cd 03_Astacidea_Genome/fasta_files/
           - conda activate /data/projet2/conda/environment_projet
           - python3 -m zipfile -e astacidea_ref_genome.zip genome_refseq
           - conda deactivate

     - I delete the file and folder which are unecessary and created the 05_get_mito_ref.py for running process on the new genomes files and rename 05_Download_Reads.sh in 06_Download_Reads.sh

      - cd 01_Scripts 
      - conda activate /data/projet2/conda/biopython
      - nohup python3 /data/projet2/01_Scripts/05_get_mito_ref.py > /data/projet2/01_Scripts/mito_ref.log 2>&1 & 
      - conda deactivate


     - I rename the two files with the name of the species in the header in /data/projet2/03_Astacidea_Genome/Reference_mitogenome

     - I run the script 06_Dowload_Reads.sh for extract reads for the species _Procambarus clarkii_ from SRA by using SRA-tool and the environnement for it :

      
      - nohup bash /data/projet2/01_Scripts/06_Dowload_Reads.sh > reads.log 2>&1 &



     - I install other tools in the environment for step before the mapping

      - conda install bioconda::nanoplot
      - conda install bioconda::filtlong
      - conda install bioconda::seqkit

     - nanoplot version 1.46.1 for quality analyses of PacBio reads
     - filtlong  version 0.3.1 for filtering the reads maybe
     - seqkit version  2.10.1 for doing statistic on the reads
     
     - I created the 09_Reads_PcBio_analyse.sh for the analyse of the reads with Nanoplot for creating QC report file and see the quality of the reads

- Jean-Louis ~ 1H
     
     - The Git workflow has been improved to ensure clearer version tracking and better readability of the project history

     - I created the 11_Assemble_Reads.sh script to run a genome assembler (hifiasm) on the extracted reads and to generate statistics for the resulting assembly files


## 7 novembre 
- Jean-Louis ~ 2H

     - Create an environment.yml file to export the conda environment using the following command: 

          conda env export --from-history > environment.yml

     Then add it to the git tracking

     - Modification of the .gitignore file by adding large files such as conda environments, .log files, .zip files, and sequences.

     - I modified script 11, but it still needs to be tested once the sequences have been downloaded.


- Marieke ~ 3h30

     - I created the conda environment for iq-tree :

      - conda create -n env_iqtree
      - conda activate /data/projet2/conda/envs/env_iqtree
      - conda install bioconda::iqtree
      - conda deactivate 

     - iqtree version : 3.0.1

     - i install fastqc also for having a review on the quality of the reads
     
      - conda activate /data/projet2/conda/envs/env_mapping_astra 
      - conda install bioconda::fastqc
      - conda deactivate

     - I modified the 09_Reads_PcBio_analyse.sh for doing some analysis and statistics on it
     - I try to run it for seqkit analyse:

      - nohup bash /data/projet2/01_Scripts/09_Raw_Reads_PcBio_stat.sh > raw_read_stat.log 2>&1 &

     - I created /data/projet2/01_Scripts/12_Raw_Read_PcBio_nanoplot.sh script for run Nanoplot on the reads for having a visual view of the quality og or read and some other statistical data.

      - nohup bash /data/projet2/01_Scripts/12_Raw_Read_PcBio_nanoplot.sh > raw_read_nano.log 2>&1 & 

     - I created the script 14_Mapping_Reads.sh for run the mapping of the reads.

     - I install 2 other tools in the conda environment env_mapping_astra
      - conda activate /data/projet2/conda/envs/env_mapping_astra
      - conda install bioconda::samtools
      - conda install bioconda::bcftools

     - bcftools version  1.22 
     - samtools version  1.22.1 

     - I install filtlong tools also for filtering the long reads 
      - conda activate /data/projet2/conda/envs/env_mapping_astra
      - conda install bioconda::filtlong
      - conda deactivate 

     filtlong version : 0.3.1

     - I created next the 13_Filtering_lenght_reads.sh for filtering the raw reads before mapping step

      - cd 01_Scripts
      - nohup bash /data/projet2/01_Scripts/13_Filtering_lenght_reads.sh > filtering_step.log 2>&1 &


## 8 novembre
- Marieke : 6h

     - I modified the script for the mapping and run it :

      - cd 01_Scripts
      - nohup bash /data/projet2/01_Scripts/14_Mapping_Reads.sh > mapping.log 2>&1 &

     - I created 15_Mapping_Raw_Reads.sh and i deleted the files corresponding to the script 13_Filtering_lenght_reads.sh because it's probably selected NUMT's due to the filter after reflexion because their drastics and after the mapping with filtered reads we have 395 reads mapped on the genome reference, so i run the mapping on raw reads for comparing the two results of making.

      - cd 01_Scripts
      - nohup bash /data/projet2/01_Scripts/15_Mapping_Raw_Reads.sh > mapping_raw_reads.log 2>&1 &

     - This script allow us to have 728 read map to the reference genome so i decided to keep this for the rest of the project

     - I created a script for extract read from the bam file and turn them into a fastq file for perform the assembly on it after fiew analyse with nanoplot on the reads.

      - cd 01_Scripts
      - nohup bash /data/projet2/01_Scripts/16_Reads_for_assembly_and_stats.sh > nano_read_mapped.log 2>&1 &


     - I create a new environnment for running FLYE Assembly programme on our mapped reads extract

      - conda create -n env_assemblage_asta
      - conda activate /data/projet2/conda/envs/env_assemblage_asta
      - conda install bioconda::flye
      - conda deactivate

     - flye version 2.9.6

     - I run the script :
     
      - cd 01_Scripts
      - nohup bash /data/projet2/01_Scripts/17_Flye_Assembly.sh > assembly_fly.log 2>&1 &

     - Index the assembly file : samtools faidx /data/projet2/03_Astacidea_Genome/Assembly/fly_result/assembly.fasta
     - Stats on the file : seqkit stats /data/projet2/03_Astacidea_Genome/Assembly/fly_result/assembly.fasta > /data/projet2/03_Astacidea_Genome/Assembly/fly_result/stats_assemblage.txt
     

     - For see if their is real variation and maybe some other mitochondrial genome we perform a second mapping of or mitochondrial reads extract against the assembly which is a consensus sequence of these reads
     - I created the scripts 18_Mapping_against_assembly.sh for doing the second Mapping

      - cd 01_Scripts
      - nohup bash /data/projet2/01_Scripts/18_Mapping_against_assembly.sh > mapping_2.log 2>&1 &

     - I also created a script for detect variants and run it :

      - cd 01_Script
      - nohup bash /data/projet2/01_Scripts/19_Variant_calling.sh > variant_call.log 2>&1 &