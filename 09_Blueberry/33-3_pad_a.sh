#!/bin/bash
#PBS -N 33-3_pad_a.I10000b
#PBS -l nodes=1:ppn=8
#PBS -l vmem=96000mb
#PBS -l walltime=80:00:00
cd $PBS_O_WORKDIR
tophat -p 8 -I 10000 -i 50 -o I10000b/33-3_pad_a /lustre/groups/lorainelab/index/bowtie2/V_corymbosum_scaffold_May_2013 fastq2/33-3_pad_a.fastq
