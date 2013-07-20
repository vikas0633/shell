#!/bin/sh

# make fasta format file from Glimmer bed

B=20130611_glimmerHMM_arabidopsis
G=/lustre/groups/lorainelab/data/blueberry/01_genome/bberry/newbler/454Scaffolds.fna

# makes gene sequence from start of transcript to end, including introns
gunzip -c $B.bed.gz | cut -f1-12 | bedtools getfasta -name -s -bed stdin -fi $G -fo - | fold -w 60 > $B.genomic.fa
chmod g+rw $B.genomic.fa

# makes mRNA sequence (no introns)
gunzip -c $B.bed.gz | cut -f1-12 | bedtools getfasta -split -name -s -bed stdin -fi $G -fo - | fold -w 60 > $B.mRNA.fa
chmod g+rw $B.mRNA.fa

