
### nodes to be used
cores=28
intron_size=30000

### tRNA
ref1="/array/users/vgupta/lotus_3.0/LotusJaponicus_tRNA.fa"
index1="/array/users/vgupta/lotus_3.0/LotusJaponicus_tRNA"
bowtie2-build -f $ref1 $index1

# rRNA
ref2="/array/users/vgupta/lotus_3.0/LotusJaponicus_ribosomal_RNA.fa"
index2="/array/users/vgupta/lotus_3.0/LotusJaponicus_ribosomal_RNA"
bowtie2-build -f $ref2 $index2

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
work_dir=$data_dir/"tRNA_"$f

mkdir -p $work_dir

### Run tophat
tophat -p $cores -I $intron_size -o $work_dir $index1 $file

work_dir=$data_dir/"rRNA_"$f

mkdir -p $work_dir

### Run tophat
tophat -p $cores -I $intron_size -o $work_dir $index2 $file

### run cufflink

#cufflinks -G $GFF3 --pre-mrna-fraction 0.5 --max-intron-length $intron_size -p $cores -o $work_dir $work_dir"/"$bam

done