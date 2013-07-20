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
module load ncbi-blast+/2.2.27

WORKDIR="/lustre/groups/lorainelab/data/blueberry/18_blastx"
SCRIPT_NAME="20130705_blastx1.sh"
LOGFILE=`date "+20%y%m%d_%H%M"`."$SCRIPT_NAME"".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE



cd $WORKDIR

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

GENOME="/lustre/groups/lorainelab/data/blueberry/01_genome/bberry/newbler/454Scaffolds.fna" 
DB="/lustre/groups/lorainelab/data/blueberry/80_blastDatabase/nr"
QUERY="20130630_final_cdna.refined.part-09.fa"


#makeblastdb -in $DB -dbtype 'prot'

blastx -query "$QUERY" -out "$QUERY".blastx.out -db "$DB" -evalue 0.01 -max_target_seqs 5 -num_threads $nthreads -outfmt "6 qseqid sseqid pident evalue score qstart qend sstart send qframe sframe qlen slen length mismatch sacc" >> $LOGFILE


echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE


