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
module load cufflinks/2.1.1


WORKDIR="/lustre/groups/lorainelab/data/blueberry/16_CuffDiff"
SCRIPT_NAME="20130701_cuffDiff.sh"
LOGFILE=`date "+20%y%m%d_%H%M"`."$SCRIPT_NAME"".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE


echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

GENOME="/lustre/groups/lorainelab/data/blueberry/01_genome/bberry/newbler/454Scaffolds.fna" 
cd $WORKDIR
data_dir="/lustre/groups/lorainelab/data/blueberry/illumina_DHMR/se_trimmed/bb_se_TH2.0.6_6K_processed"
cuffdiff -v -p $nthreads cuffcmp.combined.gtf \
	"$data_dir/""2-41_cup.bam" \
	"$data_dir/""2-41_green.bam" \
	"$data_dir/""2-41_pad.bam" \
	"$data_dir/""2-41_pink.bam" \
	"$data_dir/""2-41_ripe.bam" \
	"$data_dir/""2-42_cup.bam" \
	"$data_dir/""2-42_green.bam" \
	"$data_dir/""2-42_pink.bam" \
	"$data_dir/""2-42_ripe.bam" \
	"$data_dir/""3-33_cup.bam" \
	"$data_dir/""3-33_green.bam" \
	"$data_dir/""3-33_pad_a.bam" \
	"$data_dir/""3-33_pad_b.bam" \
	"$data_dir/""3-33_pink.bam" \
	"$data_dir/""3-33_ripe.bam" >> $LOGFILE


echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE


