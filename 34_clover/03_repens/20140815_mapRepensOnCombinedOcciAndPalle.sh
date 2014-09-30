
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

cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome

genome="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/occi_palle.final.assembly.fa"

fastq_dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/20140211_CloverRNAseq_Tr"
read1="$fastq_dir/TRfloral_1.fastq ,$fastq_dir/TRleaf_1.fastq,$fastq_dir/TRroot_1.fastq,$fastq_dir/TRstolon_1.fastq"
read2="$fastq_dir/TRfloral_2.fastq ,$fastq_dir/TRleaf_2.fastq,$fastq_dir/TRroot_2.fastq,$fastq_dir/TRstolon_2.fastq"

	

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

tophat -p $cores -I $intron_size -o $tophat_out_dir $index $read1 $read2 >> $logfile


echo 'All jobs are finished at:' `date` >> $logfile
echo '-----------------------------------------------' >> $logfile


