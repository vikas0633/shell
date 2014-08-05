
### nodes to be used
cores=28
intron_size=30000
GFF3="/array/users/vgupta/lotus_3.0/20140314_Lj30.gff3"
### reference genome
ref="/array/users/vgupta/35_Simon_RNAseq/2014-07-10/lj_r30.fa"
#index=$(basename $ref)
index="/array/users/vgupta/35_Simon_RNAseq/2014-07-10/lj_r30"
#bowtie2-build -f $ref $index

### data_dir
data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-10"

cd $data_dir

for file in NG-*.fastq
do
echo $file

### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f

#mkdir -p $work_dir

### Run tophat
#tophat -p $cores -I $intron_size -G $GFF3 -o $work_dir $index $file

### bam_file
bam="accepted_hits.2unique"

### convert bam to sam
#samtools view $work_dir"/"$bam > $work_dir"/"$sam

### extract uniquely mapped reads
#samtools view -h $work_dir/accepted_hits.bam | grep  "^@" > #$work_dir/accepted_hits.2unique.sam
#samtools view $work_dir/accepted_hits.bam | grep -w "NH:i:1" >> #$work_dir/accepted_hits.2unique.sam
#samtools view $work_dir/accepted_hits.bam | grep -w "NH:i:2" >> #$work_dir/accepted_hits.2unique.sam
#samtools view -Shb $work_dir/accepted_hits.2unique.sam > $work_dir/$bam".bam"
# Sort the BAM file - not needed for tophat output 
samtools sort $work_dir/$bam".bam" $work_dir/$bam".sorted"

rm -f *.sam

### run cufflink

cufflinks -G $GFF3 --pre-mrna-fraction 0.5 --max-intron-length $intron_size -p $cores -o $work_dir $work_dir/$bam".sorted.bam"

done