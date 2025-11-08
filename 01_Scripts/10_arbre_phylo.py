import iqtree

# arbre Maximum de Vraisemblance , on a pu montrer que ML, associé à une bonne recherche heuristique, est la méthode 
#qui a le plus de chances de retrouver la vraie phylogénie. C’est son avantage majeur au vu de notre jeux de donner avec
# un nombre limité de séquences.

#Directories 
WORKDIR="data/projet2/02_Phylogeny_part/fasta_files/all_sequences_mito_aligned.fasta"
OUTPUT_DIR="results/projet2/02_Phylogeny_part/arbre_phylo"


cmd = ["iqtree2", "-s", WORKDIR, "-m", "MFP", "-bb", "1000", "-alrt", "1000", "-nt", "AUTO", "-pre", OUTPUT_DIR ]
subprocess.run(cmd, check=True)


