#!/bin/bash
#PBS -l nodes=1:ppn=10
#PBS -l vmem=90000mb
#PBS -l walltime=80:00:00
#PBS -q compute
#export BLASTDB=$HOME/data



nthreads=10

### Load module
module load gmap/2013-05-09
module load fastx-toolkit/0.0.13.2
module load samtools/0.1.19
module load bwa/0.6.2

WORKDIR="/lustre/home/vgupta2/01_blueberry/04_mapping"
SCRIPT_NAME="20130324_illumina_SE_noTrimming_BWA.sh"
LOGFILE=`date "+20%y%m%d_%H%M"`."$SCRIPT_NAME"".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE


echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

DATADIR="/lustre/groups/lorainelab/data/blueberry/illumina_DHMR/fastq"
GENOME="/lustre/groups/lorainelab/data/blueberry/01_genome/bberry/newbler/454Scaffolds.fna" 

echo "Staring indexing the genome: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
#nice -n 19 bwa index -a bwtsw "$GENOME"
### faidx for referance genome
#nice -n 19 samtools faidx "$GENOME"
echo "Genome has been indexed: " `date "+20%y%m%d_%H%M"` >> $LOGFILE


echo "Aligning the single end illumina reads: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

cd "$DATADIR"
for file in *.fastq;
do nice -n 19 bwa aln -t $nthreads -l 28 "$GENOME" $file > $file.sai;
	echo $file "has been aligned on" `date "+20%y%m%d_%H%M"` >> $LOGFILE
	nice -n 19 bwa samse -n 30 $file.sai $file | nice -n 19 samtools view -bt "GENOME".fai -| nice -n 19 samtools sort - "$file"_sorted
	echo $file "has been converted to sam format on" `date "+20%y%m%d_%H%M"` >> $LOGFILE
done;


echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE



