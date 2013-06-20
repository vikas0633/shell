#!/bin/bash
#PBS -N 20130522_fastqc2.sh
#PBS -l nodes=1:ppn=1
#PBS -l vmem=180000mb
#PBS -l walltime=40:00:00
#PBS -q bigiron
#export BLASTDB=$HOME/data

logfile=`date "+20%y%m%d_%H%M"`".logfile"

echo '----------------------------------------------' > $logfile
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $logfile


datadir="/lustre/groups/lorainelab/data/blueberry/pe_blueberry/ch1/PE_100527_UNC8-RDR3001640_0006/fastq/trimmed"
fastqc $datadir/* -o $datadir



echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $logfile
echo '----------------------------------------------' >> $logfile
