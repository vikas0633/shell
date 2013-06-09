### make a sample script for producing bam file from Burtti genomic data
set -e

### reference file
ref_file="/u/pm/data/2012_08_30_ljr30/lj_r30.fa"


### index the reference genome
#bwa index -a bwtsw $ref_file

### faidx for referance genome
#nice -n 19 samtools faidx "$ref_file"

### set directory
dir="/u/pm/data/2012_04_04_jin_mg_accessions/2013_week21"
cd "$dir"

### number of threads
nthreads=36

echo "processing fastq files from GHD-41"

### set read name variables
read_1_1="/u/pm/data/mg20_genomic_fasteris/ghd41_500bp/100608_s_8_1_seq_GHD-41-filt-PE.fastq.tagdusted.fq.repfiltered.fq"
read_1_2="/u/pm/data/mg20_genomic_fasteris/ghd41_500bp/100608_s_8_2_seq_GHD-41-filt-PE.fastq.tagdusted.fq.repfiltered.fq"
read_2_1="/u/pm/data/mg20_genomic_fasteris/ghd41_500bp/100810_s_2_1_GHD-41.fastq.tagdusted.fq.repfiltered.fq"
read_2_2="/u/pm/data/mg20_genomic_fasteris/ghd41_500bp/100810_s_2_2_GHD-41.fastq.tagdusted.fq.repfiltered.fq"

### define insert_size
insert_size="750"

####--------------align the reads -----------------------------------####
#for file in *.fastq;
#do 
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_1_1 > $read_1_1.sai;
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_1_2 > $read_1_2.sai;
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_2_1 > $read_2_1.sai;
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_2_2 > $read_2_2.sai;
#done;

####--------------mapping the reads ---------------------------------####
nice -n 19 bwa sampe -a "$insert_size" -P "$ref_file" "$read_1_1"".sai" "$read_1_2"".sai"  "$read_1_1" "$read_1_2" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1"_sorted
nice -n 19 bwa sampe -a "$insert_size" -P "$ref_file" "$read_2_1"".sai" "$read_2_2"".sai"  "$read_2_1" "$read_2_2" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_2_1"_sorted






echo "processing fastq files from GHD-42"

### set read name variables
read_1_1="/u/pm/data/mg20_genomic_fasteris/ghd42_250bp/100608_s_8_1_seq_GHD-42-filt-PE.fastq.tagdusted.fq.repfiltered.fq"
read_1_2="/u/pm/data/mg20_genomic_fasteris/ghd42_250bp/100608_s_8_2_seq_GHD-42-filt-PE.fastq.tagdusted.fq.repfiltered.fq"
read_2_1="/u/pm/data/mg20_genomic_fasteris/ghd42_250bp/100810_s_2_1_GHD-42.fastq.tagdusted.fq.repfiltered.fq"
read_2_2="/u/pm/data/mg20_genomic_fasteris/ghd42_250bp/100810_s_2_2_GHD-42.fastq.tagdusted.fq.repfiltered.fq"

### define insert_size
insert_size="300"

####--------------align the reads -----------------------------------####
#for file in *.fastq;
#do 
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_1_1 > $read_1_1.sai;
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_1_2 > $read_1_2.sai;
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_2_1 > $read_2_1.sai;
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_2_2 > $read_2_2.sai;
#done;

####--------------mapping the reads ---------------------------------####
nice -n 19 bwa sampe -a "$insert_size" -P "$ref_file" "$read_1_1"".sai" "$read_1_2"".sai"  "$read_1_1" "$read_1_2" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1"_sorted
nice -n 19 bwa sampe -a "$insert_size" -P "$ref_file" "$read_2_1"".sai" "$read_2_2"".sai"  "$read_2_1" "$read_2_2" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_2_1"_sorted



echo "processing fastq files from GHD-43"

### set read name variables
read_1_1="/u/pm/data/mg20_genomic_fasteris/ghd43_2kb/100625_s_3_1_GHD-43d-unique.fastq.tagdusted.fq.repfiltered.fq"
read_1_2="/u/pm/data/mg20_genomic_fasteris/ghd43_2kb/100625_s_3_2_GHD-43d-unique.fastq.tagdusted.fq.repfiltered.fq"
read_2_1="/u/pm/data/mg20_genomic_fasteris/ghd43_2kb/100826_s_8_1_seq_GHD-43.fastq.tagdusted.fq.repfiltered.fq"
read_2_2="/u/pm/data/mg20_genomic_fasteris/ghd43_2kb/100826_s_8_2_seq_GHD-43.fastq.tagdusted.fq.repfiltered.fq"

### define insert_size
insert_size="3000"

####--------------align the reads -----------------------------------####
#for file in *.fastq;
#do 
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_1_1 > $read_1_1.sai;
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_1_2 > $read_1_2.sai;
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_2_1 > $read_2_1.sai;
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_2_2 > $read_2_2.sai;
#done;

####--------------mapping the reads ---------------------------------####
nice -n 19 bwa sampe -a "$insert_size" -P "$ref_file" "$read_1_1"".sai" "$read_1_2"".sai"  "$read_1_1" "$read_1_2" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1"_sorted
nice -n 19 bwa sampe -a "$insert_size" -P "$ref_file" "$read_2_1"".sai" "$read_2_2"".sai"  "$read_2_1" "$read_2_2" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_2_1"_sorted


echo "processing fastq files from GHD-44"

### set read name variables
read_1_1="/u/pm/data/mg20_genomic_fasteris/ghd44_5kb/100625_s_3_1_GHD-44d-unique.fastq.tagdusted.fq.repfiltered.fq"
read_1_2="/u/pm/data/mg20_genomic_fasteris/ghd44_5kb/100625_s_3_2_GHD-44d-unique.fastq.tagdusted.fq.repfiltered.fq"
read_2_1="/u/pm/data/mg20_genomic_fasteris/ghd44_5kb/100826_s_8_1_seq_GHD-44.fastq.tagdusted.fq.repfiltered.fq"
read_2_2="/u/pm/data/mg20_genomic_fasteris/ghd44_5kb/100826_s_8_2_seq_GHD-44.fastq.tagdusted.fq.repfiltered.fq"

### define insert_size
insert_size="7500"

####--------------align the reads -----------------------------------####
#for file in *.fastq;
#do 
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_1_1 > $read_1_1.sai;
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_1_2 > $read_1_2.sai;
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_2_1 > $read_2_1.sai;
nice -n 19 bwa aln -t "$nthreads" -l 28 "$ref_file" $read_2_2 > $read_2_2.sai;
#done;

####--------------mapping the reads ---------------------------------####
nice -n 19 bwa sampe -a "$insert_size" -P "$ref_file" "$read_1_1"".sai" "$read_1_2"".sai"  "$read_1_1" "$read_1_2" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1"_sorted
nice -n 19 bwa sampe -a "$insert_size" -P "$ref_file" "$read_2_1"".sai" "$read_2_2"".sai"  "$read_2_1" "$read_2_2" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_2_1"_sorted





####--------------mapping the bams ---------------------------------####
read_1_1="/u/pm/data/mg20_genomic_fasteris/ghd41_500bp/100608_s_8_1_seq_GHD-41-filt-PE.fastq.tagdusted.fq.repfiltered.fq"
read_2_1="/u/pm/data/mg20_genomic_fasteris/ghd41_500bp/100810_s_2_1_GHD-41.fastq.tagdusted.fq.repfiltered.fq"
read_3_1="/u/pm/data/mg20_genomic_fasteris/ghd42_250bp/100608_s_8_1_seq_GHD-42-filt-PE.fastq.tagdusted.fq.repfiltered.fq"
read_4_1="/u/pm/data/mg20_genomic_fasteris/ghd42_250bp/100810_s_2_1_GHD-42.fastq.tagdusted.fq.repfiltered.fq"
read_5_1="/u/pm/data/mg20_genomic_fasteris/ghd43_2kb/100625_s_3_1_GHD-43d-unique.fastq.tagdusted.fq.repfiltered.fq"
read_6_1="/u/pm/data/mg20_genomic_fasteris/ghd43_2kb/100826_s_8_1_seq_GHD-43.fastq.tagdusted.fq.repfiltered.fq"
read_7_1="/u/pm/data/mg20_genomic_fasteris/ghd44_5kb/100625_s_3_1_GHD-44d-unique.fastq.tagdusted.fq.repfiltered.fq"
read_8_1="/u/pm/data/mg20_genomic_fasteris/ghd44_5kb/100826_s_8_1_seq_GHD-44.fastq.tagdusted.fq.repfiltered.fq"



samtools merge MG20_genomic_20130609.bam \
               "$read_1_1"_sorted.bam \
               "$read_2_1"_sorted.bam \
               "$read_3_1"_sorted.bam \
               "$read_4_1"_sorted.bam \
               "$read_5_1"_sorted.bam \
               "$read_6_1"_sorted.bam \
               "$read_7_1"_sorted.bam \
               "$read_8_1"_sorted.bam 
               

### remove index file
rm *.sai
#rm *_trimmed

