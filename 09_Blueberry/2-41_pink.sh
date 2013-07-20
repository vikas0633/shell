#!/bin/bash
#PBS -N 2-41_pink.TH
#PBS -l nodes=1:ppn=8
#PBS -l vmem=96000mb
#PBS -l walltime=80:00:00
cd $PBS_O_WORKDIR
tophat -p 8 -I 6000 -i 50 -o TH/2-41_pink /lustre/groups/lorainelab/index/bowtie2/V_corymbosum_scaffold_May_2013 fastq/2-41_pink.fastq
