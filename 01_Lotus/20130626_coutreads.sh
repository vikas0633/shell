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


### MG20 re-accessions

read1=("/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-1_Undetermined_L001_R1_001.fastq_output/JIN-1_Undetermined_L001_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-1_Undetermined_L001_R1_001.fastq_output/JIN-1_Undetermined_L001_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-1_Undetermined_L001_R1_001.fastq_output/JIN-1_Undetermined_L001_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-1_Undetermined_L001_R1_001.fastq_output/JIN-1_Undetermined_L001_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-2_Undetermined_L002_R1_001.fastq_output/JIN-2_Undetermined_L002_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-2_Undetermined_L002_R1_001.fastq_output/JIN-2_Undetermined_L002_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-2_Undetermined_L002_R1_001.fastq_output/JIN-2_Undetermined_L002_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-2_Undetermined_L002_R1_001.fastq_output/JIN-2_Undetermined_L002_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-3_Undetermined_L003_R1_001.fastq_output/JIN-3_Undetermined_L003_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-3_Undetermined_L003_R1_001.fastq_output/JIN-3_Undetermined_L003_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-3_Undetermined_L003_R1_001.fastq_output/JIN-3_Undetermined_L003_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-3_Undetermined_L003_R1_001.fastq_output/JIN-3_Undetermined_L003_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-4_Undetermined_L004_R1_001.fastq_output/JIN-4_Undetermined_L004_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-4_Undetermined_L004_R1_001.fastq_output/JIN-4_Undetermined_L004_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-4_Undetermined_L004_R1_001.fastq_output/JIN-4_Undetermined_L004_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-4_Undetermined_L004_R1_001.fastq_output/JIN-4_Undetermined_L004_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-5_Undetermined_L005_R1_001.fastq_output/JIN-5_Undetermined_L005_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-5_Undetermined_L005_R1_001.fastq_output/JIN-5_Undetermined_L005_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-5_Undetermined_L005_R1_001.fastq_output/JIN-5_Undetermined_L005_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-5_Undetermined_L005_R1_001.fastq_output/JIN-5_Undetermined_L005_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-6_Undetermined_L006_R1_001.fastq_output/JIN-6_Undetermined_L006_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-6_Undetermined_L006_R1_001.fastq_output/JIN-6_Undetermined_L006_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-6_Undetermined_L006_R1_001.fastq_output/JIN-6_Undetermined_L006_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-6_Undetermined_L006_R1_001.fastq_output/JIN-6_Undetermined_L006_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-7_Undetermined_L007_R1_001.fastq_output/JIN-7_Undetermined_L007_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-7_Undetermined_L007_R1_001.fastq_output/JIN-7_Undetermined_L007_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-7_Undetermined_L007_R1_001.fastq_output/JIN-7_Undetermined_L007_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-7_Undetermined_L007_R1_001.fastq_output/JIN-7_Undetermined_L007_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq")


read2=("/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-1_Undetermined_L001_R2_001.fastq_output/JIN-1_Undetermined_L001_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-1_Undetermined_L001_R2_001.fastq_output/JIN-1_Undetermined_L001_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-1_Undetermined_L001_R2_001.fastq_output/JIN-1_Undetermined_L001_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-1_Undetermined_L001_R2_001.fastq_output/JIN-1_Undetermined_L001_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-2_Undetermined_L002_R2_001.fastq_output/JIN-2_Undetermined_L002_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-2_Undetermined_L002_R2_001.fastq_output/JIN-2_Undetermined_L002_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-2_Undetermined_L002_R2_001.fastq_output/JIN-2_Undetermined_L002_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-2_Undetermined_L002_R2_001.fastq_output/JIN-2_Undetermined_L002_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-3_Undetermined_L003_R2_001.fastq_output/JIN-3_Undetermined_L003_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-3_Undetermined_L003_R2_001.fastq_output/JIN-3_Undetermined_L003_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-3_Undetermined_L003_R2_001.fastq_output/JIN-3_Undetermined_L003_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-3_Undetermined_L003_R2_001.fastq_output/JIN-3_Undetermined_L003_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-4_Undetermined_L004_R2_001.fastq_output/JIN-4_Undetermined_L004_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-4_Undetermined_L004_R2_001.fastq_output/JIN-4_Undetermined_L004_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-4_Undetermined_L004_R2_001.fastq_output/JIN-4_Undetermined_L004_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-4_Undetermined_L004_R2_001.fastq_output/JIN-4_Undetermined_L004_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-5_Undetermined_L005_R2_001.fastq_output/JIN-5_Undetermined_L005_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-5_Undetermined_L005_R2_001.fastq_output/JIN-5_Undetermined_L005_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-5_Undetermined_L005_R2_001.fastq_output/JIN-5_Undetermined_L005_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-5_Undetermined_L005_R2_001.fastq_output/JIN-5_Undetermined_L005_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-6_Undetermined_L006_R2_001.fastq_output/JIN-6_Undetermined_L006_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-6_Undetermined_L006_R2_001.fastq_output/JIN-6_Undetermined_L006_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-6_Undetermined_L006_R2_001.fastq_output/JIN-6_Undetermined_L006_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-6_Undetermined_L006_R2_001.fastq_output/JIN-6_Undetermined_L006_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-7_Undetermined_L007_R2_001.fastq_output/JIN-7_Undetermined_L007_R1_001.fastq.barcoded.fq_002_AACGATT.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-7_Undetermined_L007_R2_001.fastq_output/JIN-7_Undetermined_L007_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-7_Undetermined_L007_R2_001.fastq_output/JIN-7_Undetermined_L007_R1_001.fastq.barcoded.fq_300_GCATTGG.fq_trimmed.repfiltered.fq" \
"/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-7_Undetermined_L007_R2_001.fastq_output/JIN-7_Undetermined_L007_R1_001.fastq.barcoded.fq_301_TGTACCA.fq_trimmed.repfiltered.fq")

BAM=("mg004" \
"mg010" \
"mg012" \
"mg019" \
"mg023" \
"mg036" \
"mg049" \
"mg051" \
"mg062" \
"mg072" \
"mg073" \
"mg077" \
"mg080" \
"mg082" \
"mg083" \
"mg086" \
"mg089" \
"mg093" \
"mg095" \
"mg097" \
"mg101" \
"mg107" \
"mg109" \
"mg112" \
"mg113" \
"mg118" \
"mg123" \
"mg128" )

len=${#read1[*]}
for (( i=0; i<len; i++ ))
do
file=${read1[$i]}
lines=` wc -l $file | cut -d ' ' -f 1`
count=`expr $lines / 4`
bam="/u/pm/data/2012_04_04_jin_mg_accessions/2013_week21/BAMs/"${BAM[$i]}".bam"
### read1
mapped_reads=`samtools view -f 0x0040 $bam | cut -f 1| sort | uniq | wc  -l`
echo -e "$file" "," "$count" "," "$mapped_reads"
### read2
file=${read2[$i]}
mapped_reads=`samtools view -f 0x0080 $bam | cut -f 1| sort | uniq | wc  -l`
echo -e "$file" "," "$count" "," "$mapped_reads"
done

