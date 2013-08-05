
#!/bin/bash
#PBS -l nodes=1:ppn=10
#PBS -q normal

logfile=`date "+20%y%m%d_%H%M"`".logfile"
source /com/extra/FastQC/0.10.1/load.sh
source /com/extra/samtools/0.1.18/load.sh
source /com/extra/bwa/0.7.5a/load.sh

echo '-----------------------------------------------' > $logfile
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $logfile

python ~/script/python/115_MapFastq.py \
-f /home/vgupta/LotusGenome/100_data/20130801_Japan_sequencing/data1,/home/vgupta/LotusGenome/100_data/20130801_Japan_sequencing/data2,/home/vgupta/LotusGenome/100_data/20130801_Japan_sequencing/data3,/home/vgupta/LotusGenome/100_data/20130801_Japan_sequencing/data4 \
-x fastq \
-r /home/vgupta/LotusGenome/ljr30/lj_r30.fa \
-u bz2 \
-p bwa


echo 'All jobs are finished at:' `date` >> $logfile
echo '-----------------------------------------------' >> $logfile


