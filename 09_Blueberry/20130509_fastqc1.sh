#!/bin/bash
#PBS -N test
#PBS -l nodes=1:ppn=1
#PBS -l vmem=18000mb
#PBS -l walltime=40:00:00

#export BLASTDB=$HOME/data

logfile=`date "+20%y%m%d_%H%M"`".logfile"

echo '----------------------------------------------' > $logfile
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $logfile


datadir="/lustre/groups/lorainelab/data/blueberry/illumina_DHMR"
fastqc $datadir/*.fastq -o /lustre/home/vgupta2/01_blueberry/01_fastqc



echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $logfile
echo '----------------------------------------------' >> $logfile
