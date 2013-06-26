### set read name variables

echo -e "file name"",""FastqReads"",""Mapped reads"

read1=("/u/pm/data/mg20_genomic_fasteris/ghd41_500bp/100608_s_8_1_seq_GHD-41-filt-PE.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd41_500bp/100810_s_2_1_GHD-41.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd42_250bp/100608_s_8_1_seq_GHD-42-filt-PE.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd42_250bp/100810_s_2_1_GHD-42.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd43_2kb/100625_s_3_1_GHD-43d-unique.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd43_2kb/100826_s_8_1_seq_GHD-43.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd44_5kb/100625_s_3_1_GHD-44d-unique.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd44_5kb/100826_s_8_1_seq_GHD-44.fastq.tagdusted.fq.repfiltered.fq")

read2=("/u/pm/data/mg20_genomic_fasteris/ghd41_500bp/100608_s_8_2_seq_GHD-41-filt-PE.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd41_500bp/100810_s_2_2_GHD-41.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd42_250bp/100608_s_8_2_seq_GHD-42-filt-PE.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd42_250bp/100810_s_2_2_GHD-42.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd43_2kb/100625_s_3_2_GHD-43d-unique.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd43_2kb/100826_s_8_2_seq_GHD-43.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd44_5kb/100625_s_3_2_GHD-44d-unique.fastq.tagdusted.fq.repfiltered.fq" \
"/u/pm/data/mg20_genomic_fasteris/ghd44_5kb/100826_s_8_2_seq_GHD-44.fastq.tagdusted.fq.repfiltered.fq")

len=${#read1[*]}
for (( i=0; i<len; i++ ))
do
file=${read1[$i]}
lines=` wc -l $file | cut -d ' ' -f 1`
count=`expr $lines / 4`
bam="$file"_sorted.bam
### read1
mapped_reads=`samtools view -f 0x0040 $bam | cut -f 1| sort | uniq | wc  -l`
echo -e "$file" "," "$count" "," "$mapped_reads"
### read2
file=${read2[$i]}
mapped_reads=`samtools view -f 0x0080 $bam | cut -f 1| sort | uniq | wc  -l`
echo -e "$file" "," "$count" "," "$mapped_reads"
done

