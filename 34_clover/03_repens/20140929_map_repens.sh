#!/bin/bash
#SBATCH -c 16
#SBATCH --mem=32g
#SBATCH --time=200:30:00
#SBATCH -p normal

logfile=`date "+20%y%m%d_%H%M"`".logfile"


source /com/extra/tophat/2.0.9/load.sh
source /com/extra/bowtie2/2.1.0/load.sh
source /com/extra/samtools/0.1.19/load.sh
source /com/extra/cufflinks/2.1.1/load.sh

echo '-----------------------------------------------' > $logfile
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $logfile

cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome

genome="/home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/20140923_repens_genome/contigs.fa"

fastq_dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/20140211_CloverRNAseq_Tr"
read1="$fastq_dir/TRfloral_1.fastq,$fastq_dir/TRleaf_1.fastq,$fastq_dir/TRroot_1.fastq,$fastq_dir/TRstolon_1.fastq"
read2="$fastq_dir/TRfloral_2.fastq,$fastq_dir/TRleaf_2.fastq,$fastq_dir/TRroot_2.fastq,$fastq_dir/TRstolon_2.fastq"
	

IFS='$'
run_dir=`pwd`
tophat_out_dir=`pwd`"/tophat"
mkdir -p $tophat_out_dir

out_dir=`pwd`"/"output
mkdir -p $out_dir


ref=$genome
index=${genome%.*}
IFS='/'
genome_array=( $genome )
genome_name="${genome_array[@]:(-1)}"

IFS="$"
cores=15
intron_size=30000

nice -n 19 bowtie2-build -f $ref $index

nice -n 19 tophat -p $cores -I $intron_size -o $tophat_out_dir $index $read1 $read2

## make pileup file
echo 'Creating a pileup file'
nice -n 19 samtools mpileup -f $genome $tophat_out_dir"/"accepted_hits.bam  > $tophat_out_dir"/"RNA-seq.pileup


python /home/vgupta/script/python/21l_pileup2GTF.py -p $tophat_out_dir"/"RNAseq.pileup > $tophat_out_dir"/"RNAseq.pileup.gtf
nice -n 19 perl -pe '$_=~s/exon/gene/' $tophat_out_dir"/"RNAseq.pileup.gtf > $tophat_out_dir"/"RNAseq.pileup.updated.gtf

### run cufflink
cufflinks \
        --pre-mrna-fraction 0.5 \
        --small-anchor-fraction 0.01 \
        --min-frags-per-transfrag 5 \
        --overhang-tolerance 20 \
        --max-bundle-length 10000000 \
        --min-intron-length 20 \
        --trim-3-dropoff-frac 0.01 \
        --multi-read-correct \
        --upper-quartile-norm  \
        --total-hits-norm \
        --max-mle-iterations 10000  \
        --max-intron-length $intron_size \
        --no-update-check \
        -p $cores \
        -o $tophat_out_dir $tophat_out_dir"/"accepted_hits.bam 
echo 'All jobs are finished at:' `date` >> $logfile
echo '-----------------------------------------------' >> $logfile

