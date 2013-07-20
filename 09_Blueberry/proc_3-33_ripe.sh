#!/bin/bash
#PBS -N P3-33_ripe
#PBS -l nodes=1:ppn=1
#PBS -l vmem=8000mb
#PBS -l walltime=20:00:00
cd $PBS_O_WORKDIR
procTopHat.py --delivery=bb_se_TH2.0.6_6K_processed --out_prefix=3-33_ripe --bam_file=bb_se_TH2.0.6_6K/3-33_ripe/accepted_hits.bam --wiggles=wiggles.linux --move
