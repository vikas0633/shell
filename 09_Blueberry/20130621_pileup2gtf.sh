#!/bin/bash
#PBS -l nodes=1:ppn=10
#PBS -l vmem=90000mb
#PBS -l walltime=200:00:00
#PBS -q compute
#export BLASTDB=$HOME/data



nthreads=10

### Load module
module load gmap/2013-05-09
module load fastx-toolkit/0.0.13.2
module load samtools/0.1.19
module load bwa/0.6.2

WORKDIR="/lustre/home/vgupta2/01_blueberry/07_pileup"
SCRIPT_NAME="20130621_pileup2gtf.sh"
LOGFILE=`date "+20%y%m%d_%H%M"`."$SCRIPT_NAME"".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE

cd /lustre/groups/lorainelab/data/blueberry/02_mergedBam/BAMs

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

GENOME="/lustre/groups/lorainelab/data/blueberry/01_genome/bberry/newbler/454Scaffolds.fna" 

pile="Transcriptomic_data.bam.pileup"
perl /lustre/home/vgupta2/01_blueberry/05_genemark/gmes/vikas_gm_es.pl $GENOME
python /lustre/home/vgupta2/script/python/21l_pileup2GTF.py -c 0 -l 1 -i 1 -p $pile > $pile".gtf"

echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE


