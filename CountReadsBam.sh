
echo -e "file" "\t" "count" "\t" "mapped_reads" "\t" "percentage" "\t" "paired_reads" "\t" "percaentage_pairs"

for file in mg*.bam
do 
# mapped reads only
mapped_reads=`samtools view -c -F 4 $file`
 
# Unmapped reads only
unmapped_reads=`samtools view -c -f 4 $file`

# both reads mapped 
paired_reads=`samtools view -c -F 12 $file`

# total reads
count=`expr $mapped_reads + $unmapped_reads`

# Percentage of reads mapped
mapped_reads100=`expr $mapped_reads \* 100`
mapped_pairs100=`expr $paired_reads \* 100`
per=`expr $mapped_reads100 / $count`
per_pairs=`expr $mapped_pairs100 / $count`

echo -e "$file" "\t" "$count" "\t" "$mapped_reads" "\t" "$per" "\t" "$paired_reads" "\t" "$per_pairs"
done

file="Burtii_20130605.bam"
# mapped reads only
mapped_reads=`samtools view -c -F 4 $file`
 
# Unmapped reads only
unmapped_reads=`samtools view -c -f 4 $file`

# both reads mapped 
paired_reads=`samtools view -c -F 12 $file`

# total reads
count=`expr $mapped_reads + $unmapped_reads`

# Percentage of reads mapped
mapped_reads100=`expr $mapped_reads \* 100`
mapped_pairs100=`expr $paired_reads \* 100`
per=`expr $mapped_reads100 / $count`
per_pairs=`expr $mapped_pairs100 / $count`

echo -e "$file" "\t" "$count" "\t" "$mapped_reads" "\t" "$per" "\t" "$paired_reads" "\t" "$per_pairs"

file="Gifu_20130609.bam"
# mapped reads only
mapped_reads=`samtools view -c -F 4 $file`
 
# Unmapped reads only
unmapped_reads=`samtools view -c -f 4 $file`

# both reads mapped 
paired_reads=`samtools view -c -F 12 $file`

# total reads
count=`expr $mapped_reads + $unmapped_reads`

# Percentage of reads mapped
mapped_reads100=`expr $mapped_reads \* 100`
mapped_pairs100=`expr $paired_reads \* 100`
per=`expr $mapped_reads100 / $count`
per_pairs=`expr $mapped_pairs100 / $count`

echo -e "$file" "\t" "$count" "\t" "$mapped_reads" "\t" "$per" "\t" "$paired_reads" "\t" "$per_pairs"

file="MG20_genomic_20130609.bam"
# mapped reads only
mapped_reads=`samtools view -c -F 4 $file`
 
# Unmapped reads only
unmapped_reads=`samtools view -c -f 4 $file`

# both reads mapped 
paired_reads=`samtools view -c -F 12 $file`

# total reads
count=`expr $mapped_reads + $unmapped_reads`

# Percentage of reads mapped
mapped_reads100=`expr $mapped_reads \* 100`
mapped_pairs100=`expr $paired_reads \* 100`
per=`expr $mapped_reads100 / $count`
per_pairs=`expr $mapped_pairs100 / $count`

echo -e "$file" "\t" "$count" "\t" "$mapped_reads" "\t" "$per" "\t" "$paired_reads" "\t" "$per_pairs"