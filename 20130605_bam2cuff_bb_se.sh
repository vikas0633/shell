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


echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

GENOME="/lustre/groups/lorainelab/data/blueberry/01_genome/bberry/newbler/454Scaffolds.fna" 
WORKDIR="/lustre/groups/lorainelab/data/blueberry/02_mergedBam"

### merged single end reads
echo "Merging single ends bam files: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

cd /lustre/groups/lorainelab/data/blueberry/illumina_DHMR/se_trimmed/bb_se_TH2.0.6_processed
samtools merge "$WORKDIR/SE_merged.bam" \
                2-41_cup.bam \
                2-41_green.bam \
                2-41_pad.bam \
                2-41_pink.bam \
                2-41_ripe.bam \
                2-42_cup.bam \
                2-42_green.bam \
                2-42_pink.bam \
                2-42_ripe.bam \
                3-33_cup.bam \
                3-33_green.bam \
                33-3_pad_a.bam \
                33-3_pad_b.bam \
                3-33_pink.bam \
                3-33_ripe.bam
                
### merged pair end reads
echo "Merging pair ends bam files: " `date "+20%y%m%d_%H%M"` >> $LOGFILE


### merge bam files


### bam_file
bam="accepted_hits.bam"
sam="accepted_hits.sam"

### convert bam to sam

samtools view $work_dir"/"$bam > $work_dir"/"$sam

### run cufflink
pre-mrna-fraction=0.5
small-anchor-fraction=0.01
min-frags-per-transfrag=5
overhang-tolerance=20
max-bundle-length=10000000
min-intron-length=20
trim-3-dropoff-frac=0.01
max-multiread-fraction=0.09
max-mle-iterations=10000
max-intron-length=10000

cufflinks --pre-mrna-fraction "$pre-mrna-fraction" \
          --small-anchor-fraction "$small-anchor-fraction" \
          --min-frags-per-transfrag "$min-frags-per-transfrag" \
          --overhang-tolerance "$overhang-tolerance" \
          --max-bundle-length "$max-bundle-length" \
          --min-intron-length "$min-intron-length" \
          --trim-3-dropoff-frac "$trim-3-dropoff-frac" \
          --max-multiread-fraction "$max-multiread-fraction" \
          --no-effective-length-correction \
          --no-length-correction \
          --multi-read-correct \
          --upper-quartile-norm  \
          --total-hits-norm \
          --max-mle-iterations "$max-mle-iterations" \
          --max-intron-length "$max-intron-length" \
          --no-update-check \
          -p $nthreads \
          -o $work_dir \
          $work_dir"/"$sam
          
echo "cufflinks is done" >>$logfile



echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE

