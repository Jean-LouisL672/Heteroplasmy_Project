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