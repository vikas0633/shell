#!/bin/bash
#PBS -l nodes=1:ppn=10
#PBS -l vmem=90000mb
#PBS -l walltime=40:00:00
#PBS -q compute
#export BLASTDB=$HOME/data



nthreads=10

### Load module
module load gmap/2013-05-09
module load fastx-toolkit/0.0.13.2
module load samtools/0.1.19
WORKDIR="/lustre/home/vgupta2/01_blueberry/04_mapping"

LOGFILE=`date "+20%y%m%d_%H%M"`".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

#DATADIR="/lustre/groups/lorainelab/data/blueberry/dhmri_ONeal_454_run_2009_06_18/fastq/trimmed"
#SCRIPTDIR="/lustre/home/vgupta2/script/python"
GENOME_DIR="/lustre/groups/lorainelab/sw/gmap/2013-05-09/share/454Scaffolds"
cd $DATADIR

#python $SCRIPTDIR/20_trim_reads.py 10 5

### build the database for gmap
nice -n 19 gmap_build -D "/lustre/groups/lorainelab/sw/gmap/2013-05-09/share/454Scaffolds" -d '454Scaffolds' /lustre/groups/lorainelab/data/blueberry/01_genome/bberry/newbler/454Scaffolds.fna

### index genome with samtools
nice -n 19 samtools faidx /lustre/groups/lorainelab/data/blueberry/01_genome/bberry/newbler/454Scaffolds.fna

file="/lustre/groups/lorainelab/data/blueberry/dhmri_ONeal_454_run_2009_06_18/fastq/trimmed/GI3MI6V01.fastq_trimmed"
nice -n 19 gmap -D "/lustre/groups/lorainelab/sw/gmap/2013-05-09/share/454Scaffolds" -d '454Scaffolds' -f samse --intronlength=30000 --nthreads=$nthreads $file | nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$file"_sorted 
echo 'completed the mapping for: '$file >>$LOGFILE

file="/lustre/groups/lorainelab/data/blueberry/dhmri_ONeal_454_run_2009_06_18/fastq/trimmed/GI3MI6V02.fastq_trimmed"
nice -n 19 gmap -D "/lustre/groups/lorainelab/sw/gmap/2013-05-09/share/454Scaffolds" -d '454Scaffolds' -f samse --intronlength=30000 --nthreads=$nthreads $file | nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$file"_sorted 
echo 'completed the mapping for: '$file >>$LOGFILE

file="/lustre/groups/lorainelab/data/blueberry/ncsu_ONeal_454_Aug_2010/files_from_ncsu_gsl/fastq/trimmed/onrip.fastq_trimmed"
nice -n 19 gmap  -D "/lustre/groups/lorainelab/sw/gmap/2013-05-09/share/454Scaffolds" -d '454Scaffolds' -f samse --intronlength=30000 --nthreads=$nthreads $file | nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$file"_sorted 
echo 'completed the mapping for: '$file >>$LOGFILE

file="/lustre/groups/lorainelab/data/blueberry/ncsu_ONeal_454_Aug_2010/files_from_ncsu_gsl/fastq/trimmed/onunr.fastq_trimmed"
nice -n 19 gmap  -D "/lustre/groups/lorainelab/sw/gmap/2013-05-09/share/454Scaffolds" -d '454Scaffolds' -f samse --intronlength=30000 --nthreads=$nthreads $file | nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$file"_sorted 
echo 'completed the mapping for: '$file >>$LOGFILE
	    
echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE

