#!/bin/bash
#PBS -N PSE33-3_pad_a
#PBS -l nodes=1:ppn=1
#PBS -l vmem=8000mb
#PBS -l walltime=20:00:00
cd $PBS_O_WORKDIR
procTopHat.py --delivery=bb_se_TH2.0.6_processed --out_prefix=33-3_pad_a --bam_file=bb_se_TH2.0.6/33-3_pad_a/accepted_hits.bam --wiggles=wiggles.linux --move
