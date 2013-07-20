#!/bin/bash
#PBS -N 3-33_pad_b.TH
#PBS -l nodes=1:ppn=8
#PBS -l vmem=96000mb
#PBS -l walltime=80:00:00
cd $PBS_O_WORKDIR
tophat -p 8 -I 6000 -i 50 -o TH/3-33_pad_b /lustre/groups/lorainelab/index/bowtie2/V_corymbosum_scaffold_May_2013 fastq/3-33_pad_b.fastq
