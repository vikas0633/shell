### make a sample script for producing bam file from Burtti genomic data
set -e

### reference file
ref_file="/u/pm/data/2012_08_30_ljr30/lj_r30.fa"


### index the reference genome
#bwa index -a bwtsw $ref_file

### faidx for referance genome
nice -n 19 samtools faidx "$ref_file"

### set directory
dir="/u/pm/data/2012_04_04_jin_mg_accessions/2013_week21"
cd "$dir"

echo "processing fastq files from sample-1"

### set read name variables
read_1_1="/u/pm/data/2012_10_09_sym10_sym43/Sample_P0079_N047-01/sym10_R1.fastq"
read_1_2="/u/pm/data/2012_10_09_sym10_sym43/Sample_P0079_N047-01/sym10_R2.fastq"


####--------------align the reads -----------------------------------####
#for file in *.fastq;
#do 
nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $read_1_1 > $read_1_1.sai;
nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $read_1_2 > $read_1_2.sai;
#done;

####--------------mapping the reads ---------------------------------####
nice -n 19 bwa sampe -P "$ref_file" "$read_1_1"".sai" "$read_1_2"".sai"  "$read_1_1" "$read_1_2" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1"_sorted


echo "processing fastq files from sample-2"

### set read name variables
read_1_1="/u/pm/data/2012_10_09_sym10_sym43/Sample_P0079_N047-02/sym43_R1.fastq"
read_1_2="/u/pm/data/2012_10_09_sym10_sym43/Sample_P0079_N047-02/sym43_R2.fastq"

####--------------align the reads -----------------------------------####
#for file in *.fastq;
#do 
nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $read_1_1 > $read_1_1.sai;
nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $read_1_2 > $read_1_2.sai;
#done;

####--------------mapping the reads ---------------------------------####
nice -n 19 bwa sampe -P "$ref_file" "$read_1_1"".sai" "$read_1_2"".sai"  "$read_1_1" "$read_1_2" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1"_sorted



echo "processing fastq files from sample-3"

### set read name variables
read_1_1="/u/pm/data/2012_10_09_sym10_sym43/Sample_P0079_N047-03/sym103_1_R1.fastq"
read_1_2="/u/pm/data/2012_10_09_sym10_sym43/Sample_P0079_N047-03/sym103_1_R2.fastq"

####--------------align the reads -----------------------------------####
#for file in *.fastq;
#do 
nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $read_1_1 > $read_1_1.sai;
nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $read_1_2 > $read_1_2.sai;
#done;

####--------------mapping the reads ---------------------------------####
nice -n 19 bwa sampe -P "$ref_file" "$read_1_1"".sai" "$read_1_2"".sai"  "$read_1_1" "$read_1_2" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1"_sorted


echo "processing fastq files from sample-4"

### set read name variables
read_1_1="/u/pm/data/2012_10_09_sym10_sym43/Sample_P0079_N047-04/sym103_2_R1.fastq"
read_1_2="/u/pm/data/2012_10_09_sym10_sym43/Sample_P0079_N047-04/sym103_2_R2.fastq"

####--------------align the reads -----------------------------------####
#for file in *.fastq;
#do 
nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $read_1_1 > $read_1_1.sai;
nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $read_1_2 > $read_1_2.sai;
#done;

####--------------mapping the reads ---------------------------------####
nice -n 19 bwa sampe -P "$ref_file" "$read_1_1"".sai" "$read_1_2"".sai"  "$read_1_1" "$read_1_2" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1"_sorted



####--------------mapping the bams ---------------------------------####
read_1_1="/u/pm/data/2012_10_09_sym10_sym43/Sample_P0079_N047-01/sym10_R1.fastq"
read_2_1="/u/pm/data/2012_10_09_sym10_sym43/Sample_P0079_N047-02/sym43_R1.fastq"
read_3_1="/u/pm/data/2012_10_09_sym10_sym43/Sample_P0079_N047-03/sym103_1_R1.fastq"
read_4_1="/u/pm/data/2012_10_09_sym10_sym43/Sample_P0079_N047-04/sym103_2_R1.fastq"

samtools merge Gifu_20130609.bam \
               "$read_1_1"_sorted.bam \
               "$read_2_1"_sorted.bam \
               "$read_3_1"_sorted.bam \
               "$read_4_1"_sorted.bam 
               

### remove index file
rm *.sai
#rm *_trimmed

