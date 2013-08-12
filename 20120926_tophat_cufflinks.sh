 -l nodes=1:ppn=16
#PBS -q normal

echo "========= Job started  at `date` =========="

### get the tools from rune's directory
source /com/extra/bowtie/0.12.8/load.sh
source /com/extra/tophat/2.0.4/load.sh
source /com/extra/cufflinks/2.0.2/load.sh
source /com/extra/samtools/0.1.18/load.sh

### nodes to be used
cores=15

### data_dir
data_dir="/home/vgupta/01_genome_annotation/02_transcriptomics_data"

### work dir
work_dir="/home/vgupta/01_genome_annotation/11_tophat/05"

### log file
logfile=$work_dir"/20120926.logfile"


### reference genome
ref="/home/vgupta/01_genome_annotation/01_genome/Ljchr0-6_pseudomol_20120830.chlo.mito.fa"
index="/home/vgupta/01_genome_annotation/01_genome/Ljchr0-6_pseudomol_20120830.chlo.mito.fa"


### bam_file
bam="accepted_hits.bam"
sam="accepted_hits.sam"

### convert bam to sam

samtools view $work_dir"/"$bam > $work_dir"/"$sam

### run cufflink

cufflinks --pre-mrna-fraction 0.5 --small-anchor-fraction 0.01 --min-frags-per-transfrag 5 --overhang-tolerance 20 --max-bundle-length 10000000 --min-intron-length 20 --trim-3-dropoff-frac 0.01 --max-multiread-fraction 0.99 --no-effective-length-correction --no-length-correction --multi-read-correct --upper-quartile-norm  --total-hits-norm --max-mle-iterations 10000  --max-intron-length 50000 --no-update-check -p $cores -o $work_dir $work_dir"/"$sam
echo "cufflinks is done" >>$logfile



