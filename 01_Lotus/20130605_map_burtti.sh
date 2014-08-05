### make a sample script for producing bam file from Burtti genomic data
set -e

### reference file
ref_file="/u/pm/data/2012_08_30_ljr30/lj_r30.fa"


### index the reference genome
#bwa index -a bwtsw $ref_file

echo "processing fastq files"

### set directory
dir="/u/pm/data/2012_04_04_jin_mg_accessions/2013_week21"
cd "$dir"

### set read name variables
read_1_1="$dir"/"110401_SN132_A_s_4_1_corrected_GPH-3.txt"
read_1_2="$dir"/"110401_SN132_A_s_4_2_corrected_GPH-3.txt"
read_2_1="$dir"/"110401_SN132_A_s_4_1_corrected_GPH-4.txt"
read_2_2="$dir"/"110401_SN132_A_s_4_2_corrected_GPH-4.txt"
read_3_1="$dir"/"110421_SN365_B_s_4_1_seq_GPH-3.txt"
read_3_2="$dir"/"110421_SN365_B_s_4_2_seq_GPH-3.txt"
read_4_1="$dir"/"110421_SN365_B_s_4_1_seq_GPH-4.txt"
read_4_2="$dir"/"110421_SN365_B_s_4_2_seq_GPH-4.txt"



####--------------align the reads -----------------------------------####
for file in *.txt;
do nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $file > $file.sai;
done;


### faidx for referance genome
nice -n 19 samtools faidx "$ref_file"

####--------------mapping the reads ---------------------------------####

rg="110401_SN132_A_s_4_1_corrected_GPH-3.txt"
rg="@RG\tID:$rg\tSM:$rg\tPL:illumina\tLB:lib1\tPU:unit"
nice -n 19 bwa sampe -P -r $rg "$ref_file" "$read_1_1"".sai" "$read_1_2"".sai"  "$read_1_1" "$read_1_2" | nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1"_sorted

rg="110401_SN132_A_s_4_1_corrected_GPH-4.txt"
rg="@RG\tID:$rg\tSM:$rg\tPL:illumina\tLB:lib1\tPU:unit"

nice -n 19 bwa sampe -P -r $rg "$ref_file" "$read_2_1"".sai" "$read_2_2"".sai"  "$read_2_1" "$read_2_2" | nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_2_1"_sorted


rg="110421_SN365_B_s_4_1_seq_GPH-3.txt"
rg="@RG\tID:$rg\tSM:$rg\tPL:illumina\tLB:lib1\tPU:unit"
nice -n 19 bwa sampe -P -r $rg "$ref_file" "$read_3_1"".sai" "$read_3_2"".sai"  "$read_3_1" "$read_3_2" | nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_3_1"_sorted

rg="110421_SN365_B_s_4_1_seq_GPH-4.txt"
rg="@RG\tID:$rg\tSM:$rg\tPL:illumina\tLB:lib1\tPU:unit"
nice -n 19 bwa sampe -P -r $rg "$ref_file" "$read_4_1"".sai" "$read_4_2"".sai"  "$read_4_1" "$read_4_2" | nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_4_1"_sorted


samtools merge Burtii_20130605.bam \
               "$read_1_1"_sorted.bam \
               "$read_2_1"_sorted.bam \
               "$read_3_1"_sorted.bam \
               "$read_4_1"_sorted.bam 
               

### remove index file
#rm *.sai
#rm *_trimmed

