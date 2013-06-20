#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -q normal

logfile=`date "+20%y%m%d_%H%M"`".logfile"

echo '-----------------------------------------------' > $logfile
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $logfile

cd /home/vgupta/05_blueberry/08_GeneMark
GENOME="/u/vgupta/09_blueberry/01_genome/454Scaffolds.fna"
perl /home/vgupta/01_genome_annotation/tools/gm_es_bp_linux64_v2.3e/gmes/vikas_gm_es.pl $GENOME

echo 'All jobs are finished at:' `date` >> $logfile
echo '-----------------------------------------------' >> $logfile
