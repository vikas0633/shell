
#!/bin/csh
#PBS -l nodes=1:ppn=28
#PBS -q qfat1

echo "========= Job started  at `date` =========="

### get the tools from rune's directory
source /com/extra/bowtie2/2.2.2/load.sh
source /com/extra/tophat/2.0.4/load.sh
source /com/extra/cufflinks/2.0.2/load.sh
source /com/extra/samtools/0.1.18/load.sh

### nodes to be used
cores=28
intron_size=30000

### data_dir
data_dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/01_RogerMoraga"

### work dir
work_dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/03_tophat"
tophat_out_dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/03_tophat"


### log file
logfile=$work_dir"/20140805.logfile"

### reference genome
ref="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/01_RogerMoraga/final_pallescens.fa"
index="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/01_RogerMoraga/final_pallescens"


### fastq files
read1=\
"/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/01_RogerMoraga/T_pal_stolon_1_1_9_1.fastq",\
"/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/01_RogerMoraga/Tp_F1_pooled_1.fastq",\
"/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/01_RogerMoraga/Tp_L4_1_1.fastq",\
"/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/01_RogerMoraga/Tp_root_3e1_47_1.fastq"

read2=\
"/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/01_RogerMoraga/T_pal_stolon_1_1_9_2.fastq",\
"/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/01_RogerMoraga/Tp_F1_pooled_2.fastq",\
"/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/01_RogerMoraga/Tp_L4_1_2.fastq",\
"/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/01_RogerMoraga/Tp_root_3e1_47_2.fastq"

### Run tophat
bowtie2-build -f $ref $index
tophat -p $cores -I $intron_size -o $tophat_out_dir $index $read1 $read2

### bam_file
bam="accepted_hits.bam"
sam="accepted_hits.sam"

### convert bam to sam
#samtools view $work_dir"/"$bam > $work_dir"/"$sam


## make pileup file
echo 'Creating a pileup file'
samtools mpileup -f $ref $tophat_out_dir"/"accepted_hits.bam > $tophat_out_dir"/"RNAseq.pileup

python ~/scripts/21l_pileup2GTF.py -p $tophat_out_dir"/"RNAseq.pileup > $tophat_out_dir"/"RNAseq.pileup.gtf
perl -pe '$_=~s/exon/gene/' $tophat_out_dir"/"RNAseq.pileup.gtf > $tophat_out_dir"/"RNAseq.pileup.updated.gtf


### run cufflink

#cufflinks --pre-mrna-fraction 0.5 --small-anchor-fraction 0.01 --min-frags-per-transfrag 5 --overhang-tolerance 20 --max-bundle-length 10000000 --min-intron-length 20 --trim-3-dropoff-frac 0.01 --max-multiread-fraction 0.99 --no-effective-length-correction --no-length-correction --multi-read-correct --upper-quartile-norm  --total-hits-norm --max-mle-iterations 10000  --max-intron-length $intron_size --no-update-check -p $cores -o $work_dir $work_dir"/"$bam

echo "cufflinks is done" >>$logfile