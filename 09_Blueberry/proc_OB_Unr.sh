#!/bin/bash
#PBS -N PPEOB_Unr
#PBS -l nodes=1:ppn=1
#PBS -l vmem=8000mb
#PBS -l walltime=20:00:00
cd $PBS_O_WORKDIR
procTopHat.py --delivery=pe_TH2.0.6_processed --out_prefix=OB_Unr --bam_file=pe_TH2.0.6/OB_Unr/accepted_hits.bam --wiggles=wiggles.linux --move
