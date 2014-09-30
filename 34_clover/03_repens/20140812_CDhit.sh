#!/bin/bash
#PBS -l nodes=1:ppn=20
#PBS -q qfat2
#PBS -l walltime=348:0:0

cores=20
memory=400000
logfile=`date "+20%y%m%d_%H%M"`".logfile"

echo '-----------------------------------------------' > $logfile
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $logfile

cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/02_CDhit

file="/home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/20140211_CloverRNAseq_Tr/TRfloral/consensus/TRfloral.consensus.fasta"
cd-hit-est -i $file -o $file.cdout -T $cores -c 0.9 -G 1 -M $memory -l 300 > $file.log 2>&1

echo 'Finished CDhit on first file' `date` >> $logfile

file="/home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/20140211_CloverRNAseq_Tr/TRleaf/consensus/TRleaf.consensus.fasta"
cd-hit-est -i $file -o $file.cdout -T $cores -c 0.9 -G 1 -M $memory -l 300 > $file.log 2>&1

echo 'Finished CDhit on second file' `date` >> $logfile

file="/home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/20140211_CloverRNAseq_Tr/TRroot/consensus/TRroot.consensus.fasta"
cd-hit-est -i $file -o $file.cdout -T $cores -c 0.9 -G 1 -M $memory -l 300 > $file.log 2>&1

echo 'Finished CDhit on third file' `date` >> $logfile

file="/home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/20140211_CloverRNAseq_Tr/TRstolon/consensus/TRstolon.consensus.fasta"
cd-hit-est -i $file -o $file.cdout -T $cores -c 0.9 -G 1 -M $memory -l 300 > $file.log 2>&1

echo 'Finished CDhit on fourth file' `date` >> $logfile

cat "/home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/20140211_CloverRNAseq_Tr/TRfloral/consensus/TRfloral.consensus.fasta.cdout" \
"/home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/20140211_CloverRNAseq_Tr/TRleaf/consensus/TRleaf.consensus.fasta.cdout" \
"/home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/20140211_CloverRNAseq_Tr/TRroot/consensus/TRroot.consensus.fasta.cdout" \
"/home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/20140211_CloverRNAseq_Tr/TRstolon/consensus/TRstolon.consensus.fasta.cdout" >  Merge_CDhit_assemblies


file="Merge_CDhit_assemblies"
cd-hit-est -i $file -o $file.cdout -T $cores -c 0.9 -G 1 -M $memory -l 300 > $file.log 2>&1

echo 'Finished CDhit on merged file' `date` >> $logfile

echo 'All jobs are finished at:' `date` >> $logfile
echo '-----------------------------------------------' >> $logfile