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
     - I creatd a scipt that extract all mitocondrial files from the, i installed biopytonin inside the work environement and advenced the scipt for blasting all the mitocondrial genome and cutting them so they all start at the same genes for future alignment