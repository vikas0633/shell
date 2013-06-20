#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l vmem=18000mb
#PBS -l walltime=40:00:00
#PBS -q compute
#export BLASTDB=$HOME/data

LOGFILE=`date "+20%y%m%d_%H%M"`".logfile"

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE


DATADIR="/lustre/groups/lorainelab/data/blueberry/dhmri_ONeal_454_run_2009_06_18/fastq"
SCRIPTDIR="/lustre/home/vgupta2/script/python"
cd $DATADIR

python $SCRIPTDIR/20_trim_reads.py 10 0

echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $logfile
echo '----------------------------------------------' >> $logfile
