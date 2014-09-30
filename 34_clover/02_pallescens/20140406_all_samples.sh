
#!/bin/bash
#PBS -l nodes=1:ppn=16
#PBS -q normal
#PBS -l walltime=148:0:0

logfile=`date "+20%y%m%d_%H%M"`".logfile"

echo '-----------------------------------------------' > $logfile
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $logfile


cd /home/vgupta/LotusGenome/01_vgupta/11_clover/02_cdhit
dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/02_cdhit"
file="05_all_samples.fa"
cores=14
memory=40000

cd-hit-est -i $file -o $file.cdout -T $cores -c 0.9 -G 1 -M $memory -l 300 > $file.log 

echo 'All jobs are finished at:' `date` >> $logfile
echo '-----------------------------------------------' >> $logfile


