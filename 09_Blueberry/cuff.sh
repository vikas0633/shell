#!/bin/bash
#PBS -l nodes=1:ppn=10
#PBS -l vmem=90000mb
#PBS -l walltime=200:00:00
#PBS -q compute
#PBS -N run3_6K_se_sm

nthreads=10

### Load module
module load cufflinks/2.1.1

WORKDIR="/lustre/groups/lorainelab/data/blueberry/03_cufflinksAnnotation/run3_6K_se_sm"
SCRIPT_NAME="cuff.sh"
LOGFILE=`date "+20%y%m%d_%H%M"`."$SCRIPT_NAME"".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE


echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

OUTDIR="/lustre/groups/lorainelab/data/blueberry/02_mergedBam/run3_6K_se_sm"

### merge single end reads
echo "Merging single ends bam files: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

cd /lustre/groups/lorainelab/data/blueberry/illumina_DHMR/se_trimmed/bb_se_TH2.0.6_6K_processed
samtools merge "$OUTDIR"/SE_sm_merged.bam \
                2-41_cup.sm.bam \
                2-41_green.sm.bam \
                2-41_pad.sm.bam \
                2-41_pink.sm.bam \
                2-41_ripe.sm.bam \
                2-42_cup.sm.bam \
                2-42_green.sm.bam \
                2-42_pink.sm.bam \
                2-42_ripe.sm.bam \
                3-33_cup.sm.bam \
                3-33_green.sm.bam \
                3-33_pad_a.sm.bam \
                3-33_pad_b.sm.bam \
                3-33_pink.sm.bam \
                3-33_ripe.sm.bam
                
cd "$OUTDIR" 

### bam_file
bam="SE_sm_merged.bam"
sam="SE_sm_merged.sam"

echo "Converting Bam file to Sam: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
### convert bam to sam
samtools view "$OUTDIR"/"$bam" > "$OUTDIR"/"$sam"

### run cufflink
echo "Running Cufflinks: " `date "+20%y%m%d_%H%M"` >> $LOGFILE

:<<COMMENT
pre-mrna-fraction=0.5
small-anchor-fraction=0.01
min-frags-per-transfrag=5
overhang-tolerance=20
max-bundle-length=10000000
min-intron-length=20
trim-3-dropoff-frac=0.01
max-multiread-fraction=0.09
max-mle-iterations=10000
max-intron-length=6000

COMMENT

cd "$OUTDIR"

cufflinks --pre-mrna-fraction 0.5 \
          --small-anchor-fraction 0.01 \
          --min-frags-per-transfrag 5 \
          --overhang-tolerance 20 \
          --max-bundle-length 10000000 \
          --min-intron-length 20 \
          --trim-3-dropoff-frac 0.01 \
          --max-multiread-fraction 0.09 \
          --no-effective-length-correction \
          --no-length-correction \
          --multi-read-correct \
          --upper-quartile-norm  \
          --total-hits-norm \
          --max-mle-iterations 10000 \
          --max-intron-length 6000 \
          --no-update-check \
          -p $nthreads \
          -o "$OUTDIR" \
          "$OUTDIR"/$sam
          
echo "cufflinks is done" >>$LOGFILE

echo "All Jobs finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE

