#!/bin/bash

# Script de vérification du téléchargement et conversion

READDIR="/data/projet2/03_Astracidea_Genome/Reads"
LOGFILE="/data/projet2/reads.log"
FASTQ="SRR14457194.fastq"

echo "=========================================="
echo "VÉRIFICATION TÉLÉCHARGEMENT & CONVERSION"
echo "Date: $(date)"
echo "=========================================="
echo ""

# 1. Vérifier si le processus tourne
echo "--- Processus actifs ---"
if pgrep -f "06_Dowload_Reads.sh" > /dev/null; then
    echo "✅ Script principal actif"
    ps aux | grep "06_Dowload_Reads.sh" | grep -v grep
else
    echo "❌ Script principal terminé"
fi

if pgrep -f "fasterq-dump" > /dev/null; then
    echo "✅ fasterq-dump actif"
    PID=$(pgrep fasterq-dump)
    ps -p $PID -o pid,%cpu,%mem,etime,cmd
    echo "   Temps écoulé: $(ps -p $PID -o etime=)"
else
    echo "❌ fasterq-dump terminé"
fi

echo ""

# 2. Vérifier les fichiers
echo "--- Fichiers dans $READDIR ---"
if [ -d "$READDIR" ]; then
    cd $READDIR
    ls -lh | tail -10
    echo ""
    
    # Vérifier le fichier FASTQ
    if [ -f "$FASTQ" ]; then
        SIZE=$(ls -lh $FASTQ | awk '{print $5}')
        echo "📁 Fichier FASTQ: $SIZE"
        
        # Compter les lignes
        echo "🔢 Comptage des lignes (peut prendre 1-2 min pour 14GB)..."
        LINES=$(wc -l < $FASTQ)
        REMAINDER=$((LINES % 4))
        READS=$((LINES / 4))
        
        if [ $REMAINDER -eq 0 ]; then
            echo "✅ Fichier FASTQ VALIDE"
            echo "   Lignes totales: $LINES"
            echo "   Nombre de reads: $READS"
        else
            echo "⚠️  Fichier FASTQ INCOMPLET"
            echo "   Lignes: $LINES (reste: $REMAINDER sur 4)"
            echo "   → Conversion probablement en cours"
        fi
        
        # Afficher les dernières lignes
        echo ""
        echo "--- Dernières lignes du FASTQ ---"
        tail -4 $FASTQ
    else
        echo "❌ Fichier $FASTQ introuvable"
    fi
else
    echo "❌ Répertoire $READDIR introuvable"
fi

echo ""

# 3. Afficher les logs
echo "--- Dernières lignes du log ---"
if [ -f "$LOGFILE" ]; then
    tail -20 $LOGFILE
    
    # Chercher le message de fin
    if grep -q "Download and conversion are done" $LOGFILE; then
        echo ""
        echo "🎉 TÉLÉCHARGEMENT ET CONVERSION TERMINÉS !"
    fi
    
    # Chercher des erreurs
    ERROR_COUNT=$(grep -c -i "error\|failed" $LOGFILE 2>/dev/null || echo 0)
    if [ $ERROR_COUNT -gt 0 ]; then
        echo ""
        echo "⚠️  $ERROR_COUNT erreur(s) détectée(s):"
        grep -i "error\|failed" $LOGFILE | tail -5
    fi
else
    echo "❌ Fichier log introuvable: $LOGFILE"
fi

echo ""
echo "=========================================="
echo "RÉSUMÉ"
echo "=========================================="

# Conclusion
if [ -f "$READDIR/$FASTQ" ]; then
    LINES=$(wc -l < "$READDIR/$FASTQ")
    REMAINDER=$((LINES % 4))
    
    if [ $REMAINDER -eq 0 ] && ! pgrep -f "fasterq-dump" > /dev/null; then
        echo "✅ TÉLÉCHARGEMENT COMPLET - Prêt pour l'analyse"
        echo ""
        echo "Prochaine étape:"
        echo "  bash /data/projet2/01_Scripts/02_quality_control.sh"
    elif pgrep -f "fasterq-dump" > /dev/null; then
        echo "⏳ CONVERSION EN COURS - Patience..."
        echo ""
        echo "Pour suivre: tail -f $LOGFILE"
    else
        echo "⚠️  STATUT INCERTAIN - Vérifier manuellement"
    fi
else
    echo "❌ FICHIER FASTQ MANQUANT"
fi

echo "=========================================="