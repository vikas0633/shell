#!/bin/bash
#PBS -l nodes=1:ppn=10
#PBS -l vmem=90000mb
#PBS -l walltime=100:00:00
#PBS -q compute
#export BLASTDB=$HOME/data

WORKDIR="/lustre/home/vgupta2/01_blueberry/03_error_correction"

LOGFILE=`date "+20%y%m%d_%H%M"`".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE


DATADIR="/lustre/groups/lorainelab/data/blueberry/illumina_DHMR/fastq/trimmed"
SCRIPTDIR="/lustre/home/vgupta2/script/python"
cd $DATADIR

#python $SCRIPTDIR/20_trim_reads.py 10 5

file="Loraine_110923HiSeqRun_Sample_3-33_green_combined.fastq_trimmed"

cp $file $file.fastq
file=$file.fastq
python /lustre/groups/lorainelab/sw/echo_v1_12/ErrorCorrection.py -b 2000000 --nh 4096 --ncpu 10 -o "$DATADIR/$file".corrected $DATADIR/$file
echo 'completed the error correction for: '$file >>$LOGFILE
rm $file	    
	    
echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE

