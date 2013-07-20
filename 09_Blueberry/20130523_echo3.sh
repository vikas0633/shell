#!/bin/bash
#PBS -l nodes=1:ppn=10
#PBS -l vmem=90000mb
#PBS -l walltime=400:00:00
#PBS -q compute
#export BLASTDB=$HOME/data

WORKDIR="/lustre/home/vgupta2/01_blueberry/03_error_correction"

LOGFILE=`date "+20%y%m%d_%H%M"`".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE


DATADIR="/lustre/groups/lorainelab/data/blueberry/pe_blueberry/ch1/PE_100521_UNC3-RDR300156_0006/fastq/trimmed"
SCRIPTDIR="/lustre/home/vgupta2/script/python"
cd $DATADIR

#python $SCRIPTDIR/20_trim_reads.py 10 5


for file in *_trimmed
do
	
cp $file $file.fastq
file=$file.fastq
python /lustre/groups/lorainelab/sw/echo_v1_12/ErrorCorrection.py -b 2000000 --nh 4096 --ncpu 10 -o "$DATADIR/$file".corrected $DATADIR/$file
echo 'completed the error correction for: '$file >>$LOGFILE
rm $file	    
done
	    
echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE

