#!/bin/bash
#PBS -N bwa
#PBS -l nodes=1:ppn=1
#PBS -l vmem=18000mb
#PBS -l walltime=40:00:00
#PBS -V
#export BLASTDB=$HOME/data

module load bwa/0.5.6

WorkDir=""

logfile=$WorkDir`date "+20%y%m%d_%H%M"`".logfile"

echo '----------------------------------------------' > $logfile
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $logfile


echo 'bwa' >> $logfile
bwa >> $logfile

echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $logfile
echo '----------------------------------------------' >> $logfile
