
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -q normal

logfile=`date "+20%y%m%d_%H%M"`".logfile"

echo '-----------------------------------------------' > $logfile
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $logfile

source /com/extra/samtools/0.1.19/load.sh

cd /home/vgupta/LotusGenome/BAMs
for f in *.bam; 
do 
echo  $f;
samtools index $f
samtools view $f chr1:1-2,000,000 > sample.$f
done;



echo 'All jobs are finished at:' `date` >> $logfile
echo '-----------------------------------------------' >> $logfile


