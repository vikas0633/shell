### nodes to be used
cores=2

### reference genome
ref="/array/users/vgupta/35_Simon_RNAseq/2014-07-10/lj_r30.fa"

### data_dir
data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-10"

chr="/array/users/vgupta/lotus_3.0/chromsizes.txt"

cd $data_dir

for file in NG-*.fastq
do
echo $file

### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f

local_file="accepted_hits.2unique"

# 1. Convert SAM to BAM
#samtools view -S -T $ref -b -o $work_dir/$local_file".bam" $work_dir/$local_file".sam"
# 2. Sort the BAM file - not needed for tophat output 
#samtools sort $work_dir/$local_file".bam" $work_dir/$local_file".sorted"
# 3. make depth graph
samtools depth $work_dir/$local_file".sorted.bam" | awk '{print $1,"\t",$2,"\t",$2+1,"\t",$3}' > $work_dir/$local_file".bedgraph"
# 4. Convert the BedGraph file to BigWig
bedGraphToBigWig $work_dir/$local_file".bedgraph" $chr $work_dir/$file".refined.bw"

done
 
