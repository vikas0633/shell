#### map the degradome reads

#!/bin/bash
#PBS -l nodes=1:ppn=12
#PBS -q normal



source /com/extra/bowtie2/2.0.0-beta7/load.sh
source /com/extra/tophat/2.0.4/load.sh

threads=10
Max_intron_size=10000

logfile=`date "+20%y%m%d_%H%M"`".logfile"

echo '-----------------------------------------------' > $logfile
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $logfile

ref="/home/vgupta/LotusGenome/ljr30/lj_r30.fa"
index="/home/vgupta/LotusGenome/ljr30/lj_r30"


read=(\
     "/home/vgupta/LotusGenome/100_data/02_degradome_GXP/GXP307-308_PARE.fastq/KM09.fastq" \
     "/home/vgupta/LotusGenome/100_data/02_degradome_GXP/GXP307-308_PARE.fastq/KM10.fastq" \
     "/home/vgupta/LotusGenome/100_data/02_degradome_GXP/GXP307-308_PARE.fastq/KM11.fastq" \
     "/home/vgupta/LotusGenome/100_data/02_degradome_GXP/GXP323-325_PARE.fastq/KM09_R1_tagdust.fastq.noDuplicates" \
     "/home/vgupta/LotusGenome/100_data/02_degradome_GXP/GXP323-325_PARE.fastq/KM10_R1_tagdust.fastq.noDuplicates" \
     "/home/vgupta/LotusGenome/100_data/02_degradome_GXP/GXP323-325_PARE.fastq/KM11_R1_tagdust.fastq.noDuplicates" \
     )


### index the reference file
bowtie2-build -f $ref $index


### Map the reads using GMAP
len=${#read1[*]}
for (( i=0; i<len; i++ ))
do
file=${read1[$i]}

mkdir $file.tophat
file_name=`echo $file | awk '{split ($0, arr, "/"); print arr[length(arr)]}'`.bam
rg-id=$file_name
rg-sample=$file_name
rg-library=$file_name
rg-description="degradome"
rg-platform-unit="GenExPro"
rg-center='-'
rg-date='20130715'
rg-platform='GenExPro'

### run tophat
tophat \
--num-threads $threads \
--max-intron-length $Max_intron_size \
-o $file.tophat \
--rg-id $rg-id \
--rg-sample $rg-sample \
--rg-library $rg-library \
--rg-description $rg-description \ 
--rg-platform-unit $rg-platform-unit \
--rg-center $rg-center \
--rg-date $rg-date \
--rg-platform $rg-platform \
$index $file

echo "tophat is done" >>$LOGFILE

done


echo 'All jobs are finished at:' `date` >> $logfile
echo '-----------------------------------------------' >> $logfile

