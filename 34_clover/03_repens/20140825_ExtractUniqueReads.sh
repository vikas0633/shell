### take out the uniquely mapped reads
work_dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat"
cd $work_dir
### bam_file
bam="accepted_hits.bam"
### extract uniquely mapped reads
samtools view -h $work_dir/$bam | grep  "^@" > $work_dir/accepted_hits.unique.sam
samtools view $work_dir/accepted_hits.bam | grep -w "NH:i:1" >> $work_dir/accepted_hits.unique.sam
samtools view -Shb $work_dir/accepted_hits.unique.sam | samtools sort - $work_dir/$bam".uniq.sorted."
rm accepted_hits.unique.sam