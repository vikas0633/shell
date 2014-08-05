### nodes to be used
cores=4

file="Gifu_accepted_hits"

### data_dir
data_dir="/array/users/vgupta/01_genome_annotation/30_Gifu_MG20_RNAseq"
ref="/array/users/vgupta/lotus_3.0/lj_r30.fa"
cd $data_dir

# 1. Convert SAM to BAM
#samtools view -S -T $ref -b -o $data_dir/$file".bam" $data_dir/$file".sam"
# 2. Sort the BAM file - NOT needed with Tophat
#samtools sort $data_dir/$file".bam" $data_dir/$file".sorted"
# 3. Create BedGraph coverage file
genomeCoverageBed -bg -ibam $data_dir/$file".bam" -g $data_dir/"chromsizes.txt" > $data_dir/$file".bedgraph"
# 4. Convert the BedGraph file to BigWig
bedGraphToBigWig $data_dir/$file".bedgraph" $data_dir/"chromsizes.txt" $data_dir/$file".refined.bw"

file="MG20_accepted_hits"
# 1. Convert SAM to BAM
#samtools view -S -T $ref -b -o $data_dir/$file".bam" $data_dir/$file".sam"
# 2. Sort the BAM file - NOT needed with Tophat
#samtools sort $data_dir/$file".bam" $data_dir/$file".sorted"
# 3. Create BedGraph coverage file
genomeCoverageBed -bg -ibam $data_dir/$file".bam" -g $data_dir/"chromsizes.txt" > $data_dir/$file".bedgraph"
# 4. Convert the BedGraph file to BigWig
bedGraphToBigWig $data_dir/$file".bedgraph" $data_dir/"chromsizes.txt" $data_dir/$file".refined.bw"



#### On Zombie
#/var/www/lotus0.1/data
 
