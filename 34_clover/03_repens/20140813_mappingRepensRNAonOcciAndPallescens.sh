
#!/bin/bash
#PBS -l nodes=1:ppn=16
#PBS -q normal
#PBS -l walltime=500:0:0

logfile=`date "+20%y%m%d_%H%M"`".logfile"


source /com/extra/tophat/2.0.9/load.sh
source /com/extra/bowtie2/2.1.0/load.sh
source /com/extra/samtools/0.1.19/load.sh
source /com/extra/cufflinks/2.1.1/load.sh


echo '-----------------------------------------------' > $logfile
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $logfile

cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle

genome="/home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/AllPaths/occidentale/final.assembly.fa"

fastq_dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/01_occi_RNAseq"
read1="$fastq_dir/To_1_1.fastq,$fastq_dir/To_3_1.fastq,$fastq_dir/To_6_1.fastq,$fastq_dir/To_F2_pooled_1.fastq"
read2="$fastq_dir/To_1_2.fastq,$fastq_dir/To_3_2.fastq,$fastq_dir/To_6_2.fastq,$fastq_dir/To_F2_pooled_2.fastq"

	

IFS='$'
run_dir=`pwd`
tophat_out_dir=`pwd`"/tophat"
mkdir -p $tophat_out_dir

out_dir=`pwd`"/"output
mkdir -p $out_dir


g_dir=`pwd`"/gene_evidences"
mkdir -p $g_dir

ref=$genome
index=${genome%.*}
IFS='/'
genome_array=( $genome )
genome_name="${genome_array[@]:(-1)}"

IFS="$"
cores=15
intron_size=30000

#bowtie2-build -f $ref $index

tophat -p $cores -I $intron_size -o $tophat_out_dir $index $read1 $read2

## make pileup file
echo 'Creating a pileup file'
samtools mpileup -f $genome $tophat_out_dir"/"accepted_hits.bam  > $tophat_out_dir"/"RNA-seq.pileup


python /home/vgupta/script/python/21l_pileup2GTF.py -p $tophat_out_dir"/"RNAseq.pileup > $tophat_out_dir"/"RNAseq.pileup.gtf
perl -pe '$_=~s/exon/gene/' $tophat_out_dir"/"RNAseq.pileup.gtf > $tophat_out_dir"/"RNAseq.pileup.updated.gtf

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


