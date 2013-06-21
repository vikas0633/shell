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

WORKDIR="/lustre/home/vgupta2/01_blueberry/04_mapping"
SCRIPT_NAME="20130601_GeneMark_scaffolds.sh"
LOGFILE=`date "+20%y%m%d_%H%M"`."$SCRIPT_NAME"".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE

# samtools documentation
# http://davetang.org/wiki/tiki-index.php?page=SAMTools

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

GENOME="/lustre/groups/lorainelab/data/blueberry/01_genome/bberry/newbler/454Scaffolds.fna" 

### count reads in illumina fastq files
cd /lustre/groups/lorainelab/data/blueberry/illumina_DHMR/se_trimmed/fastq
echo -e "file name"",""FastqReads"",""Mapped reads"
for file in *.fastq
do
	lines=` wc -l $file | cut -d ' ' -f 1`
	count=`expr $lines / 4`
	bam_name=`echo $file | awk '{split ($0, arr, "."); print arr[1]}'`.bam
	bam="/lustre/groups/lorainelab/data/blueberry/illumina_DHMR/se_trimmed/bb_se_TH2.0.6_6K_processed/""$bam_name"
	mapped_reads=`samtools view -F 4 $bam | wc -l`
	echo -e "$file" "," "$count" "," "$mapped_reads"
done


cd /lustre/groups/lorainelab/data/blueberry/pe_blueberry/trimmed_pe/fastq
echo -e "file name"",""FastqReads"",""Mapped reads"
for file in *Read1.fastq
do
	lines=` wc -l $file | cut -d ' ' -f 1`
	count=`expr $lines / 4`
	bam_name=`echo $file | awk '{split ($0, arr, "_"); print arr[1]"_"arr[2]}'`.bam
	bam="/lustre/groups/lorainelab/data/blueberry/pe_blueberry/trimmed_pe/pe_TH2.0.6_processed/""$bam_name"
	mapped_reads=`samtools view -F 4 $bam | wc  -l`
	echo -e "$file" "," "$count" "," "$mapped_reads"
done


cd /lustre/groups/lorainelab/data/blueberry/dhmri_ONeal_454_run_2009_06_18/fastq/trimmed
echo -e "file name"",""FastqReads"",""Mapped reads"
for file in *trimmed
do
	lines=` wc -l $file | cut -d ' ' -f 1`
	count=`expr $lines / 4`
	bam_name="$file""_sorted.bam"
	bam="$bam_name"
	mapped_reads=`samtools view -F 4 $bam | wc  -l`
	echo -e "$file" "," "$count" "," "$mapped_reads"
done

cd /lustre/groups/lorainelab/data/blueberry/ncsu_ONeal_454_Aug_2010/files_from_ncsu_gsl/fastq/trimmed
echo -e "file name"",""FastqReads"",""Mapped reads"
for file in *trimmed
do
	lines=` wc -l $file | cut -d ' ' -f 1`
	count=`expr $lines / 4`
	bam_name="$file""_sorted.bam"
	bam="$bam_name"
	mapped_reads=`samtools view -F 4 $bam | wc -l`
	echo -e "$file" "," "$count" "," "$mapped_reads"
done 

echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE


