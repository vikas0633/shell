#!/bin/bash
#PBS -N P2-42_green
#PBS -l nodes=1:ppn=1
#PBS -l vmem=8000mb
#PBS -l walltime=20:00:00
cd $PBS_O_WORKDIR
procTopHat.py --delivery=bb_se_TH2.0.6_6K_processed --out_prefix=2-42_green --bam_file=bb_se_TH2.0.6_6K/2-42_green/accepted_hits.bam --wiggles=wiggles.linux --move
