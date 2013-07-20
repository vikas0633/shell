#!/bin/bash
#PBS -N OB_Unr.I10000e
#PBS -l nodes=1:ppn=8
#PBS -l vmem=96000mb
#PBS -l walltime=80:00:00
cd $PBS_O_WORKDIR
tophat -p 8 -I 10000 -i 50 -o I10000e/OB_Unr /lustre/groups/lorainelab/index/bowtie2/V_corymbosum_scaffold_May_2013 fastq/OB_Unr_Read1.fastq fastq/OB_Unr_Read2.fastq
