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


datadir="/lustre/groups/lorainelab/data/blueberry/ncsu_ONeal_454_Aug_2010/files_from_ncsu_gsl/fastq"
fastqc $datadir/*.fastq -o $datadir



echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $logfile
echo '----------------------------------------------' >> $logfile
