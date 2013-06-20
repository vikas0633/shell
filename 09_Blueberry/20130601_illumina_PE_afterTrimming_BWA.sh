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
SCRIPT_NAME="20130601_illumina_PE_afterTrimming_BWA.sh"
LOGFILE=`date "+20%y%m%d_%H%M"`."$SCRIPT_NAME"".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE


echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

GENOME="/lustre/groups/lorainelab/data/blueberry/01_genome/bberry/newbler/454Scaffolds.fna" 

echo "Staring indexing the genome: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
#nice -n 19 bwa index -a bwtsw "$GENOME"
### faidx for referance genome
#nice -n 19 samtools faidx "$GENOME"
echo "Genome has been indexed: " `date "+20%y%m%d_%H%M"` >> $LOGFILE


echo "Aligning the pair end illumina reads: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

DATADIR="/lustre/groups/lorainelab/data/blueberry/pe_blueberry/ch1/PE_100521_UNC3-RDR300156_0006/fastq/trimmed"
read_1_1="$DATADIR/"'s_1_1_sequence.fastq_trimmed'
read_1_2="$DATADIR/"'s_1_2_sequence.fastq_trimmed'
read_6_1="$DATADIR/"'s_6_1_sequence.fastq_trimmed'
read_6_2="$DATADIR/"'s_6_2_sequence.fastq_trimmed'

cd "$DATADIR"

### align the reads 
for file in *_trimmed;
do nice -n 19 bwa aln -t $nthreads -l 28 "$GENOME" $file > $file.sai;
	echo $file "has been aligned on" `date "+20%y%m%d_%H%M"` >> $LOGFILE
done

### make sam files
nice -n 19 bwa sampe -P -n 30 "$GENOME" "$read_1_1".sai "$read_1_2".sai  "$read_1_1" "$read_1_2" | nice -n 19 samtools view -bt "$GENOME".fai -| nice -n 19 samtools sort - "$read_1_1"_sorted
echo "$read_1_1" "has been converted to sam format on" `date "+20%y%m%d_%H%M"` >> $LOGFILE

nice -n 19 bwa sampe -P -n 30 "$GENOME" "$read_6_1".sai "$read_6_2".sai  "$read_6_1" "$read_6_2" | nice -n 19 samtools view -bt "$GENOME".fai -| nice -n 19 samtools sort - "$read_6_1"_sorted
echo "$read_6_1" "has been converted to sam format on" `date "+20%y%m%d_%H%M"` >> $LOGFILE

DATADIR="/lustre/groups/lorainelab/data/blueberry/pe_blueberry/ch1/PE_100527_UNC8-RDR3001640_0006/fastq/trimmed"
read_1_1="$DATADIR/"'s_1_1_sequence.fastq_trimmed'
read_1_2="$DATADIR/"'s_1_2_sequence.fastq_trimmed'
read_2_1="$DATADIR/"'s_2_1_sequence.fastq_trimmed'
read_2_2="$DATADIR/"'s_2_2_sequence.fastq_trimmed'

cd "$DATADIR"

### align the reads 
for file in *_trimmed;
do nice -n 19 bwa aln -t $nthreads -l 28 "$GENOME" $file > $file.sai;
	echo $file "has been aligned on" `date "+20%y%m%d_%H%M"` >> $LOGFILE
done

### make sam files
nice -n 19 bwa sampe -P -n 30 "$GENOME" "$read_1_1".sai "$read_1_2".sai  "$read_1_1" "$read_1_2" | nice -n 19 samtools view -bt "$GENOME".fai -| nice -n 19 samtools sort - "$read_1_1"_sorted
echo "$read_1_1" "has been converted to sam format on" `date "+20%y%m%d_%H%M"` >> $LOGFILE

nice -n 19 bwa sampe -P -n 30 "$GENOME" "$read_2_1".sai "$read_2_2".sai  "$read_2_1" "$read_2_2" | nice -n 19 samtools view -bt "$GENOME".fai -| nice -n 19 samtools sort - "$read_2_1"_sorted
echo "$read_2_1" "has been converted to sam format on" `date "+20%y%m%d_%H%M"` >> $LOGFILE

DATADIR="/lustre/groups/lorainelab/data/blueberry/pe_blueberry/ch1/PE_100604_UNC2-RDR300275_0010-61LV4AAXX/fastq/trimmed"

read_2_1="$DATADIR/"'s_2_1_sequence.fastq_trimmed'
read_2_2="$DATADIR/"'s_2_2_sequence.fastq_trimmed'
read_3_1="$DATADIR/"'s_3_1_sequence.fastq_trimmed'
read_3_2="$DATADIR/"'s_3_2_sequence.fastq_trimmed'



cd "$DATADIR"

### align the reads 
for file in *_trimmed;
do nice -n 19 bwa aln -t $nthreads -l 28 "$GENOME" $file > $file.sai;
echo $file "has been aligned on" `date "+20%y%m%d_%H%M"` >> $LOGFILE
done

### make sam files

nice -n 19 bwa sampe -P -n 30 "$GENOME" "$read_2_1".sai "$read_2_2".sai  "$read_2_1" "$read_2_2" | nice -n 19 samtools view -bt "$GENOME".fai -| nice -n 19 samtools sort - "$read_2_1"_sorted
echo "$read_2_1" "has been converted to sam format on" `date "+20%y%m%d_%H%M"` >> $LOGFILE

nice -n 19 bwa sampe -P -n 30 "$GENOME" "$read_3_1".sai "$read_3_2".sai  "$read_3_1" "$read_3_2" | nice -n 19 samtools view -bt "$GENOME".fai -| nice -n 19 samtools sort - "$read_3_1"_sorted
echo "$read_3_1" "has been converted to sam format on" `date "+20%y%m%d_%H%M"` >> $LOGFILE


DATADIR="/lustre/groups/lorainelab/data/blueberry/pe_blueberry/ch2/PE_100903_UNC5-RDR300700_00024_FC_622CHAAXX/fastq/trimmed"
read_1_1="$DATADIR/"'s_1_1_sequence.fastq_trimmed'
read_1_2="$DATADIR/"'s_1_2_sequence.fastq_trimmed'
read_2_1="$DATADIR/"'s_2_1_sequence.fastq_trimmed'
read_2_2="$DATADIR/"'s_2_2_sequence.fastq_trimmed'


cd "$DATADIR"
### align the reads 
for file in *_trimmed;
do nice -n 19 bwa aln -t $nthreads -l 28 "$GENOME" $file > $file.sai;
echo $file "has been aligned on" `date "+20%y%m%d_%H%M"` >> $LOGFILE
done

### make sam files
nice -n 19 bwa sampe -P -n 30 "$GENOME" "$read_1_1".sai "$read_1_2".sai  "$read_1_1" "$read_1_2" | nice -n 19 samtools view -bt "$GENOME".fai -| nice -n 19 samtools sort - "$read_1_1"_sorted
echo "$read_1_1" "has been converted to sam format on" `date "+20%y%m%d_%H%M"` >> $LOGFILE

nice -n 19 bwa sampe -P -n 30 "$GENOME" "$read_2_1".sai "$read_2_2".sai  "$read_2_1" "$read_2_2" | nice -n 19 samtools view -bt "$GENOME".fai -| nice -n 19 samtools sort - "$read_2_1"_sorted
echo "$read_2_1" "has been converted to sam format on" `date "+20%y%m%d_%H%M"` >> $LOGFILE




echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE




