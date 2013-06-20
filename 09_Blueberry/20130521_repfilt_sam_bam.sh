### make a sample script for tagdust filtering till the producing bam file
set -e

### reference file
ref_file="/u/pm/data/2012_08_30_ljr30/lj_r30.fa"

### repititve element file 
rep_file="/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/lotus_rep.fa"

### script dir
script_dir="/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15"

### index the reference genome
#bwa index -a bwtsw $ref_file

### index the lotus rep
#bowtie-build $rep_file $rep_file


#### Lane-1 ####
echo "processing Lane-1"
### set directory
dir="/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-1_Undetermined_L001_R1_001.fastq_output/"
cd "$dir"

###----------trimming the reads ------------------------####

### number of based removed from 5' and 3'
# trim_off5=9
# trim_off3=60
# nice -n 19 python /u/pm/data/2012_04_04_jin_mg_accessions/sample_test/20b_trim_reads.py $trim_off5 $trim_off3 $dir


####-------------- rep-filtering the reads--------------------------------------------------#####


### set read name variables
read_1_1="$dir"'JIN-1_Undetermined_L001_R1_001.fastq.barcoded.fq_002_AACGATT.fq'
read_1_2="$dir"'JIN-1_Undetermined_L001_R2_001.fastq.barcoded.fq_002_AACGATT.fq'
read_2_1="$dir"'JIN-1_Undetermined_L001_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_2_2="$dir"'JIN-1_Undetermined_L001_R2_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_3_1="$dir"'JIN-1_Undetermined_L001_R1_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_3_2="$dir"'JIN-1_Undetermined_L001_R2_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_4_1="$dir"'JIN-1_Undetermined_L001_R1_001.fastq.barcoded.fq_301_TGTACCA.fq'
read_4_2="$dir"'JIN-1_Undetermined_L001_R2_001.fastq.barcoded.fq_301_TGTACCA.fq'

### generate test files
#cd /u/vgupta/2011_jin_stig/110401_SN132_A_GPH-3-8/Sequences/
#for y in 110401_SN132_A*;
#do nice -n 19 awk 'NR >= 1; NR == 1000 {exit}' $y > $y.txt
#done;

<<Tagdust

## tagdust all fastq files
echo ""
echo "--------- tagdust all fastq files ---------"
export PATH=$PATH:/u/vgupta/2011_jin_stig/programs/TagDust
cd "$dir"
for y in *.txt;
do nice -n 19 tagdust /u/vgupta/2011_jin_stig/programs/TagDust/test/solexa_paired_end_primers.fa $y -fdr 0.01 -a $y.dust;
done;

### make non-redundant dust lists
echo ""
echo "------- make non-redundant dust lists -----------"
nice -n 19 perl "$script_dir"/55_parse.pl "$read_1_1".dust "$read_1_2".dust "$read_1_1".dust.nonred "$read_1_2".dust.nonred
nice -n 19 perl "$script_dir"/55_parse.pl "$read_2_1".dust "$read_2_2".dust "$read_2_1".dust.nonred "$read_2_2".dust.nonred
nice -n 19 perl "$script_dir"/55_parse.pl "$read_3_1".dust "$read_3_2".dust "$read_3_1".dust.nonred "$read_3_2".dust.nonred
nice -n 19 perl "$script_dir"/55_parse.pl "$read_4_1".dust "$read_4_2".dust "$read_4_1".dust.nonred "$read_4_2".dust.nonred

### split original fastq file into tagdusted and dust fractions
echo ""
echo "--- split original fastq file into tagdusted and dust fractions -----"
cd "$dir"
for y in *.txt;
do nice -n 19 perl "$script_dir"/54_parse.pl $y $y.dust.nonred $y.tagdusted.fq $y.dust.fq;
done;

Tagdust


### bowtie map tagdusted fastq files against ljrep sequences and filter sam alignment for hits
# echo ""
# echo "--- bowtie map against ljrep sequences -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 bowtie --seedmms 3 --maqerr 800 --seedlen 32 -k 1 --sam --time --offbase 0 --threads 6 $rep_file $y $y.ljrep.temp.sam; nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' $y.ljrep.temp.sam > $y.ljrep.sam; rm $y.ljrep.temp.sam;
# done;
# 
# ### make nonredundant list of lj_rep mapping tags
# echo ""
# echo "--- make nonredundant list of lj_rep mapping tags -----"
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_1_1""_trimmed".ljrep.sam "$read_1_2""_trimmed".ljrep.sam "$read_1_1""_trimmed".ljrep.nonred "$read_1_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_2_1""_trimmed".ljrep.sam "$read_2_2""_trimmed".ljrep.sam "$read_2_1""_trimmed".ljrep.nonred "$read_2_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_3_1""_trimmed".ljrep.sam "$read_3_2""_trimmed".ljrep.sam "$read_3_1""_trimmed".ljrep.nonred "$read_3_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_4_1""_trimmed".ljrep.sam "$read_4_2""_trimmed".ljrep.sam "$read_4_1""_trimmed".ljrep.nonred "$read_4_2""_trimmed".ljrep.nonred
# 
# 
# ### split tagdusted fastq file into refiltered and repseq fractions
# echo ""
# echo "--- split tagdusted fastq file into refiltered and repseq fractions -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 perl "$script_dir"/20120426_54_parse.pl $y $y.ljrep.nonred $y.repfiltered.fq $y.repseq.fq;
# done;
# 
# ### remove temporary files
# echo ""
# echo "----- remove temporary files -----"
# cd "$dir"
# #rm *.txt
# #rm *.dust
# rm *.nonred
# rm *.sam
# #rm *.tagdusted.fq
# rm *.repseq.fq
# ####--------------------- end---------------------------------------#####
# 


####--------------align the reads -----------------------------------####
for y in *.repfiltered.fq;
do nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $y > $y.sai;
done;

### faidx for referance genome
nice -n 19 samtools faidx "$ref_file"

####--------------mapping the reads ---------------------------------####

nice -n 19 bwa sampe -P "$ref_file" "$read_1_1""_trimmed.repfiltered.fq"".sai" "$read_1_2""_trimmed.repfiltered.fq"".sai"  "$read_1_1""_trimmed.repfiltered.fq" "$read_1_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_2_1""_trimmed.repfiltered.fq"".sai" "$read_2_2""_trimmed.repfiltered.fq"".sai"  "$read_2_1""_trimmed.repfiltered.fq" "$read_2_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_2_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_3_1""_trimmed.repfiltered.fq"".sai" "$read_3_2""_trimmed.repfiltered.fq"".sai"  "$read_3_1""_trimmed.repfiltered.fq" "$read_3_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_3_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_4_1""_trimmed.repfiltered.fq"".sai" "$read_4_2""_trimmed.repfiltered.fq"".sai"  "$read_4_1""_trimmed.repfiltered.fq" "$read_4_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_4_1""_trimmed.repfiltered.fq"_sorted


### remove index file
rm *.sai
#rm *_trimmed



#### Lane-2 ####
echo "processing Lane-2"
### set directory
dir="/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-2_Undetermined_L002_R1_001.fastq_output/"
cd "$dir"

###----------trimming the reads ------------------------####

# ### number of based removed from 5' and 3'
# trim_off5=9
# trim_off3=60
# nice -n 19 python /u/pm/data/2012_04_04_jin_mg_accessions/sample_test/20b_trim_reads.py $trim_off5 $trim_off3 $dir


####-------------- rep-filtering the reads--------------------------------------------------#####

### set read name variables
read_1_1="$dir"'JIN-2_Undetermined_L002_R1_001.fastq.barcoded.fq_002_AACGATT.fq'
read_1_2="$dir"'JIN-2_Undetermined_L002_R2_001.fastq.barcoded.fq_002_AACGATT.fq'
read_2_1="$dir"'JIN-2_Undetermined_L002_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_2_2="$dir"'JIN-2_Undetermined_L002_R2_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_3_1="$dir"'JIN-2_Undetermined_L002_R1_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_3_2="$dir"'JIN-2_Undetermined_L002_R2_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_4_1="$dir"'JIN-2_Undetermined_L002_R1_001.fastq.barcoded.fq_301_TGTACCA.fq'
read_4_2="$dir"'JIN-2_Undetermined_L002_R2_001.fastq.barcoded.fq_301_TGTACCA.fq'

### bowtie map tagdusted fastq files against ljrep sequences and filter sam alignment for hits
# echo ""
# echo "--- bowtie map against ljrep sequences -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 bowtie --seedmms 3 --maqerr 800 --seedlen 32 -k 1 --sam --time --offbase 0 --threads 6 $rep_file $y $y.ljrep.temp.sam; nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' $y.ljrep.temp.sam > $y.ljrep.sam; rm $y.ljrep.temp.sam;
# done;
# 
# ### make nonredundant list of lj_rep mapping tags
# echo ""
# echo "--- make nonredundant list of lj_rep mapping tags -----"
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_1_1""_trimmed".ljrep.sam "$read_1_2""_trimmed".ljrep.sam "$read_1_1""_trimmed".ljrep.nonred "$read_1_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_2_1""_trimmed".ljrep.sam "$read_2_2""_trimmed".ljrep.sam "$read_2_1""_trimmed".ljrep.nonred "$read_2_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_3_1""_trimmed".ljrep.sam "$read_3_2""_trimmed".ljrep.sam "$read_3_1""_trimmed".ljrep.nonred "$read_3_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_4_1""_trimmed".ljrep.sam "$read_4_2""_trimmed".ljrep.sam "$read_4_1""_trimmed".ljrep.nonred "$read_4_2""_trimmed".ljrep.nonred
# 
# 
# ### split tagdusted fastq file into refiltered and repseq fractions
# echo ""
# echo "--- split tagdusted fastq file into refiltered and repseq fractions -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 perl "$script_dir"/20120426_54_parse.pl $y $y.ljrep.nonred $y.repfiltered.fq $y.repseq.fq;
# done;
# 
# ### remove temporary files
# echo ""
# echo "----- remove temporary files -----"
# cd "$dir"
# #rm *.txt
# #rm *.dust
# rm *.nonred
# rm *.sam
# #rm *.tagdusted.fq
# rm *.repseq.fq
####--------------------- end---------------------------------------#####



####--------------align the reads -----------------------------------####
for y in *.repfiltered.fq;
do nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $y > $y.sai;
done;

### faidx for referance genome
nice -n 19 samtools faidx "$ref_file"

####--------------mapping the reads ---------------------------------####

nice -n 19 bwa sampe -P "$ref_file" "$read_1_1""_trimmed.repfiltered.fq"".sai" "$read_1_2""_trimmed.repfiltered.fq"".sai"  "$read_1_1""_trimmed.repfiltered.fq" "$read_1_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_2_1""_trimmed.repfiltered.fq"".sai" "$read_2_2""_trimmed.repfiltered.fq"".sai"  "$read_2_1""_trimmed.repfiltered.fq" "$read_2_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_2_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_3_1""_trimmed.repfiltered.fq"".sai" "$read_3_2""_trimmed.repfiltered.fq"".sai"  "$read_3_1""_trimmed.repfiltered.fq" "$read_3_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_3_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_4_1""_trimmed.repfiltered.fq"".sai" "$read_4_2""_trimmed.repfiltered.fq"".sai"  "$read_4_1""_trimmed.repfiltered.fq" "$read_4_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_4_1""_trimmed.repfiltered.fq"_sorted


### remove index file
rm *.sai
#rm *_trimmed

#### Lane-3 ####
echo "processing Lane-3"
### set directory
dir="/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-3_Undetermined_L003_R1_001.fastq_output/"
cd "$dir"

###----------trimming the reads ------------------------####

# ### number of based removed from 5' and 3'
# trim_off5=9
# trim_off3=60
# nice -n 19 python /u/pm/data/2012_04_04_jin_mg_accessions/sample_test/20b_trim_reads.py $trim_off5 $trim_off3 $dir


####-------------- rep-filtering the reads--------------------------------------------------#####

### set read name variables
read_1_1="$dir"'JIN-3_Undetermined_L003_R1_001.fastq.barcoded.fq_002_AACGATT.fq'
read_1_2="$dir"'JIN-3_Undetermined_L003_R2_001.fastq.barcoded.fq_002_AACGATT.fq'
read_2_1="$dir"'JIN-3_Undetermined_L003_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_2_2="$dir"'JIN-3_Undetermined_L003_R2_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_3_1="$dir"'JIN-3_Undetermined_L003_R1_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_3_2="$dir"'JIN-3_Undetermined_L003_R2_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_4_1="$dir"'JIN-3_Undetermined_L003_R1_001.fastq.barcoded.fq_301_TGTACCA.fq'
read_4_2="$dir"'JIN-3_Undetermined_L003_R2_001.fastq.barcoded.fq_301_TGTACCA.fq'

### bowtie map tagdusted fastq files against ljrep sequences and filter sam alignment for hits
# echo ""
# echo "--- bowtie map against ljrep sequences -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 bowtie --seedmms 3 --maqerr 800 --seedlen 32 -k 1 --sam --time --offbase 0 --threads 6 $rep_file $y $y.ljrep.temp.sam; nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' $y.ljrep.temp.sam > $y.ljrep.sam; rm $y.ljrep.temp.sam;
# done;
# 
# ### make nonredundant list of lj_rep mapping tags
# echo ""
# echo "--- make nonredundant list of lj_rep mapping tags -----"
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_1_1""_trimmed".ljrep.sam "$read_1_2""_trimmed".ljrep.sam "$read_1_1""_trimmed".ljrep.nonred "$read_1_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_2_1""_trimmed".ljrep.sam "$read_2_2""_trimmed".ljrep.sam "$read_2_1""_trimmed".ljrep.nonred "$read_2_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_3_1""_trimmed".ljrep.sam "$read_3_2""_trimmed".ljrep.sam "$read_3_1""_trimmed".ljrep.nonred "$read_3_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_4_1""_trimmed".ljrep.sam "$read_4_2""_trimmed".ljrep.sam "$read_4_1""_trimmed".ljrep.nonred "$read_4_2""_trimmed".ljrep.nonred
# 
# 
# ### split tagdusted fastq file into refiltered and repseq fractions
# echo ""
# echo "--- split tagdusted fastq file into refiltered and repseq fractions -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 perl "$script_dir"/20120426_54_parse.pl $y $y.ljrep.nonred $y.repfiltered.fq $y.repseq.fq;
# done;
# 
# ### remove temporary files
# echo ""
# echo "----- remove temporary files -----"
# cd "$dir"
# #rm *.txt
# #rm *.dust
# rm *.nonred
# rm *.sam
# #rm *.tagdusted.fq
# rm *.repseq.fq
# ####--------------------- end---------------------------------------#####



####--------------align the reads -----------------------------------####
for y in *.repfiltered.fq;
do nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $y > $y.sai;
done;

### faidx for referance genome
nice -n 19 samtools faidx "$ref_file"

####--------------mapping the reads ---------------------------------####

nice -n 19 bwa sampe -P "$ref_file" "$read_1_1""_trimmed.repfiltered.fq"".sai" "$read_1_2""_trimmed.repfiltered.fq"".sai"  "$read_1_1""_trimmed.repfiltered.fq" "$read_1_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_2_1""_trimmed.repfiltered.fq"".sai" "$read_2_2""_trimmed.repfiltered.fq"".sai"  "$read_2_1""_trimmed.repfiltered.fq" "$read_2_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_2_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_3_1""_trimmed.repfiltered.fq"".sai" "$read_3_2""_trimmed.repfiltered.fq"".sai"  "$read_3_1""_trimmed.repfiltered.fq" "$read_3_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_3_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_4_1""_trimmed.repfiltered.fq"".sai" "$read_4_2""_trimmed.repfiltered.fq"".sai"  "$read_4_1""_trimmed.repfiltered.fq" "$read_4_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_4_1""_trimmed.repfiltered.fq"_sorted


### remove index file
rm *.sai
#rm *_trimmed


#### Lane-4 ####
echo "processing Lane-4"
### set directory
dir="/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-4_Undetermined_L004_R1_001.fastq_output/"
cd "$dir"

###----------trimming the reads ------------------------####

### number of based removed from 5' and 3'
# trim_off5=9
# trim_off3=60
# nice -n 19 python /u/pm/data/2012_04_04_jin_mg_accessions/sample_test/20b_trim_reads.py $trim_off5 $trim_off3 $dir
# 

####-------------- rep-filtering the reads--------------------------------------------------#####

### set read name variables
read_1_1="$dir"'JIN-4_Undetermined_L004_R1_001.fastq.barcoded.fq_002_AACGATT.fq'
read_1_2="$dir"'JIN-4_Undetermined_L004_R2_001.fastq.barcoded.fq_002_AACGATT.fq'
read_2_1="$dir"'JIN-4_Undetermined_L004_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_2_2="$dir"'JIN-4_Undetermined_L004_R2_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_3_1="$dir"'JIN-4_Undetermined_L004_R1_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_3_2="$dir"'JIN-4_Undetermined_L004_R2_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_4_1="$dir"'JIN-4_Undetermined_L004_R1_001.fastq.barcoded.fq_301_TGTACCA.fq'
read_4_2="$dir"'JIN-4_Undetermined_L004_R2_001.fastq.barcoded.fq_301_TGTACCA.fq'

### bowtie map tagdusted fastq files against ljrep sequences and filter sam alignment for hits
# echo ""
# echo "--- bowtie map against ljrep sequences -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 bowtie --seedmms 3 --maqerr 800 --seedlen 32 -k 1 --sam --time --offbase 0 --threads 6 $rep_file $y $y.ljrep.temp.sam; nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' $y.ljrep.temp.sam > $y.ljrep.sam; rm $y.ljrep.temp.sam;
# done;
# 
# ### make nonredundant list of lj_rep mapping tags
# echo ""
# echo "--- make nonredundant list of lj_rep mapping tags -----"
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_1_1""_trimmed".ljrep.sam "$read_1_2""_trimmed".ljrep.sam "$read_1_1""_trimmed".ljrep.nonred "$read_1_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_2_1""_trimmed".ljrep.sam "$read_2_2""_trimmed".ljrep.sam "$read_2_1""_trimmed".ljrep.nonred "$read_2_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_3_1""_trimmed".ljrep.sam "$read_3_2""_trimmed".ljrep.sam "$read_3_1""_trimmed".ljrep.nonred "$read_3_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_4_1""_trimmed".ljrep.sam "$read_4_2""_trimmed".ljrep.sam "$read_4_1""_trimmed".ljrep.nonred "$read_4_2""_trimmed".ljrep.nonred
# 
# 
# ### split tagdusted fastq file into refiltered and repseq fractions
# echo ""
# echo "--- split tagdusted fastq file into refiltered and repseq fractions -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 perl "$script_dir"/20120426_54_parse.pl $y $y.ljrep.nonred $y.repfiltered.fq $y.repseq.fq;
# done;
# 
# ### remove temporary files
# echo ""
# echo "----- remove temporary files -----"
# cd "$dir"
# #rm *.txt
# #rm *.dust
# rm *.nonred
# rm *.sam
# #rm *.tagdusted.fq
# rm *.repseq.fq
# ####--------------------- end---------------------------------------#####



####--------------align the reads -----------------------------------####
for y in *.repfiltered.fq;
do nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $y > $y.sai;
done;

### faidx for referance genome
nice -n 19 samtools faidx "$ref_file"

####--------------mapping the reads ---------------------------------####

nice -n 19 bwa sampe -P "$ref_file" "$read_1_1""_trimmed.repfiltered.fq"".sai" "$read_1_2""_trimmed.repfiltered.fq"".sai"  "$read_1_1""_trimmed.repfiltered.fq" "$read_1_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_2_1""_trimmed.repfiltered.fq"".sai" "$read_2_2""_trimmed.repfiltered.fq"".sai"  "$read_2_1""_trimmed.repfiltered.fq" "$read_2_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_2_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_3_1""_trimmed.repfiltered.fq"".sai" "$read_3_2""_trimmed.repfiltered.fq"".sai"  "$read_3_1""_trimmed.repfiltered.fq" "$read_3_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_3_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_4_1""_trimmed.repfiltered.fq"".sai" "$read_4_2""_trimmed.repfiltered.fq"".sai"  "$read_4_1""_trimmed.repfiltered.fq" "$read_4_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_4_1""_trimmed.repfiltered.fq"_sorted


### remove index file
rm *.sai
#rm *_trimmed


#### Lane-5 ####
echo "processing Lane-5"
### set directory
dir="/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-5_Undetermined_L005_R1_001.fastq_output/"
cd "$dir"

###----------trimming the reads ------------------------####

### number of based removed from 5' and 3'
# trim_off5=9
# trim_off3=60
# nice -n 19 python /u/pm/data/2012_04_04_jin_mg_accessions/sample_test/20b_trim_reads.py $trim_off5 $trim_off3 $dir


####-------------- rep-filtering the reads--------------------------------------------------#####

### set read name variables
read_1_1="$dir"'JIN-5_Undetermined_L005_R1_001.fastq.barcoded.fq_002_AACGATT.fq'
read_1_2="$dir"'JIN-5_Undetermined_L005_R2_001.fastq.barcoded.fq_002_AACGATT.fq'
read_2_1="$dir"'JIN-5_Undetermined_L005_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_2_2="$dir"'JIN-5_Undetermined_L005_R2_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_3_1="$dir"'JIN-5_Undetermined_L005_R1_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_3_2="$dir"'JIN-5_Undetermined_L005_R2_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_4_1="$dir"'JIN-5_Undetermined_L005_R1_001.fastq.barcoded.fq_301_TGTACCA.fq'
read_4_2="$dir"'JIN-5_Undetermined_L005_R2_001.fastq.barcoded.fq_301_TGTACCA.fq'

### bowtie map tagdusted fastq files against ljrep sequences and filter sam alignment for hits
# echo ""
# echo "--- bowtie map against ljrep sequences -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 bowtie --seedmms 3 --maqerr 800 --seedlen 32 -k 1 --sam --time --offbase 0 --threads 6 $rep_file $y $y.ljrep.temp.sam; nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' $y.ljrep.temp.sam > $y.ljrep.sam; rm $y.ljrep.temp.sam;
# done;
# 
# ### make nonredundant list of lj_rep mapping tags
# echo ""
# echo "--- make nonredundant list of lj_rep mapping tags -----"
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_1_1""_trimmed".ljrep.sam "$read_1_2""_trimmed".ljrep.sam "$read_1_1""_trimmed".ljrep.nonred "$read_1_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_2_1""_trimmed".ljrep.sam "$read_2_2""_trimmed".ljrep.sam "$read_2_1""_trimmed".ljrep.nonred "$read_2_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_3_1""_trimmed".ljrep.sam "$read_3_2""_trimmed".ljrep.sam "$read_3_1""_trimmed".ljrep.nonred "$read_3_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_4_1""_trimmed".ljrep.sam "$read_4_2""_trimmed".ljrep.sam "$read_4_1""_trimmed".ljrep.nonred "$read_4_2""_trimmed".ljrep.nonred
# 
# 
# ### split tagdusted fastq file into refiltered and repseq fractions
# echo ""
# echo "--- split tagdusted fastq file into refiltered and repseq fractions -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 perl "$script_dir"/20120426_54_parse.pl $y $y.ljrep.nonred $y.repfiltered.fq $y.repseq.fq;
# done;
# 
# ### remove temporary files
# echo ""
# echo "----- remove temporary files -----"
# cd "$dir"
# #rm *.txt
# #rm *.dust
# rm *.nonred
# rm *.sam
# #rm *.tagdusted.fq
# rm *.repseq.fq
####--------------------- end---------------------------------------#####



####--------------align the reads -----------------------------------####
for y in *.repfiltered.fq;
do nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $y > $y.sai;
done;

### faidx for referance genome
nice -n 19 samtools faidx "$ref_file"

####--------------mapping the reads ---------------------------------####

nice -n 19 bwa sampe -P "$ref_file" "$read_1_1""_trimmed.repfiltered.fq"".sai" "$read_1_2""_trimmed.repfiltered.fq"".sai"  "$read_1_1""_trimmed.repfiltered.fq" "$read_1_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_2_1""_trimmed.repfiltered.fq"".sai" "$read_2_2""_trimmed.repfiltered.fq"".sai"  "$read_2_1""_trimmed.repfiltered.fq" "$read_2_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_2_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_3_1""_trimmed.repfiltered.fq"".sai" "$read_3_2""_trimmed.repfiltered.fq"".sai"  "$read_3_1""_trimmed.repfiltered.fq" "$read_3_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_3_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_4_1""_trimmed.repfiltered.fq"".sai" "$read_4_2""_trimmed.repfiltered.fq"".sai"  "$read_4_1""_trimmed.repfiltered.fq" "$read_4_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_4_1""_trimmed.repfiltered.fq"_sorted


### remove index file
rm *.sai
#rm *_trimmed



#### Lane-6 ####
echo "processing Lane-6"
### set directory
dir="/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-6_Undetermined_L006_R1_001.fastq_output/"
cd "$dir"

###----------trimming the reads ------------------------####

### number of based removed from 5' and 3'
# trim_off5=9
# trim_off3=60
# nice -n 19 python /u/pm/data/2012_04_04_jin_mg_accessions/sample_test/20b_trim_reads.py $trim_off5 $trim_off3 $dir


####-------------- rep-filtering the reads--------------------------------------------------#####

### set read name variables
read_1_1="$dir"'JIN-6_Undetermined_L006_R1_001.fastq.barcoded.fq_002_AACGATT.fq'
read_1_2="$dir"'JIN-6_Undetermined_L006_R2_001.fastq.barcoded.fq_002_AACGATT.fq'
read_2_1="$dir"'JIN-6_Undetermined_L006_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_2_2="$dir"'JIN-6_Undetermined_L006_R2_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_3_1="$dir"'JIN-6_Undetermined_L006_R1_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_3_2="$dir"'JIN-6_Undetermined_L006_R2_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_4_1="$dir"'JIN-6_Undetermined_L006_R1_001.fastq.barcoded.fq_301_TGTACCA.fq'
read_4_2="$dir"'JIN-6_Undetermined_L006_R2_001.fastq.barcoded.fq_301_TGTACCA.fq'

### bowtie map tagdusted fastq files against ljrep sequences and filter sam alignment for hits
# echo ""
# echo "--- bowtie map against ljrep sequences -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 bowtie --seedmms 3 --maqerr 800 --seedlen 32 -k 1 --sam --time --offbase 0 --threads 6 $rep_file $y $y.ljrep.temp.sam; nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' $y.ljrep.temp.sam > $y.ljrep.sam; rm $y.ljrep.temp.sam;
# done;
# 
# ### make nonredundant list of lj_rep mapping tags
# echo ""
# echo "--- make nonredundant list of lj_rep mapping tags -----"
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_1_1""_trimmed".ljrep.sam "$read_1_2""_trimmed".ljrep.sam "$read_1_1""_trimmed".ljrep.nonred "$read_1_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_2_1""_trimmed".ljrep.sam "$read_2_2""_trimmed".ljrep.sam "$read_2_1""_trimmed".ljrep.nonred "$read_2_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_3_1""_trimmed".ljrep.sam "$read_3_2""_trimmed".ljrep.sam "$read_3_1""_trimmed".ljrep.nonred "$read_3_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_4_1""_trimmed".ljrep.sam "$read_4_2""_trimmed".ljrep.sam "$read_4_1""_trimmed".ljrep.nonred "$read_4_2""_trimmed".ljrep.nonred
# 
# 
# ### split tagdusted fastq file into refiltered and repseq fractions
# echo ""
# echo "--- split tagdusted fastq file into refiltered and repseq fractions -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 perl "$script_dir"/20120426_54_parse.pl $y $y.ljrep.nonred $y.repfiltered.fq $y.repseq.fq;
# done;
# 
# ### remove temporary files
# echo ""
# echo "----- remove temporary files -----"
# cd "$dir"
# #rm *.txt
# #rm *.dust
# rm *.nonred
# rm *.sam
# #rm *.tagdusted.fq
# rm *.repseq.fq
# ####--------------------- end---------------------------------------#####
# 


####--------------align the reads -----------------------------------####
for y in *.repfiltered.fq;
do nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $y > $y.sai;
done;

### faidx for referance genome
nice -n 19 samtools faidx "$ref_file"

####--------------mapping the reads ---------------------------------####

nice -n 19 bwa sampe -P "$ref_file" "$read_1_1""_trimmed.repfiltered.fq"".sai" "$read_1_2""_trimmed.repfiltered.fq"".sai"  "$read_1_1""_trimmed.repfiltered.fq" "$read_1_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_2_1""_trimmed.repfiltered.fq"".sai" "$read_2_2""_trimmed.repfiltered.fq"".sai"  "$read_2_1""_trimmed.repfiltered.fq" "$read_2_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_2_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_3_1""_trimmed.repfiltered.fq"".sai" "$read_3_2""_trimmed.repfiltered.fq"".sai"  "$read_3_1""_trimmed.repfiltered.fq" "$read_3_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_3_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_4_1""_trimmed.repfiltered.fq"".sai" "$read_4_2""_trimmed.repfiltered.fq"".sai"  "$read_4_1""_trimmed.repfiltered.fq" "$read_4_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_4_1""_trimmed.repfiltered.fq"_sorted


### remove index file
rm *.sai
#rm *_trimmed


#### Lane-7 ####
echo "processing Lane-7"
### set directory
dir="/u/pm/data/2012_04_04_jin_mg_accessions/2012_week15/JIN-7_Undetermined_L007_R1_001.fastq_output/"
cd "$dir"

###----------trimming the reads ------------------------####

### number of based removed from 5' and 3'
# trim_off5=9
# trim_off3=60
# nice -n 19 python /u/pm/data/2012_04_04_jin_mg_accessions/sample_test/20b_trim_reads.py $trim_off5 $trim_off3 $dir
# 

####-------------- rep-filtering the reads--------------------------------------------------#####

### set read name variables
read_1_1="$dir"'JIN-7_Undetermined_L007_R1_001.fastq.barcoded.fq_002_AACGATT.fq'
read_1_2="$dir"'JIN-7_Undetermined_L007_R2_001.fastq.barcoded.fq_002_AACGATT.fq'
read_2_1="$dir"'JIN-7_Undetermined_L007_R1_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_2_2="$dir"'JIN-7_Undetermined_L007_R2_001.fastq.barcoded.fq_101_CTGCGAC.fq'
read_3_1="$dir"'JIN-7_Undetermined_L007_R1_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_3_2="$dir"'JIN-7_Undetermined_L007_R2_001.fastq.barcoded.fq_300_GCATTGG.fq'
read_4_1="$dir"'JIN-7_Undetermined_L007_R1_001.fastq.barcoded.fq_301_TGTACCA.fq'
read_4_2="$dir"'JIN-7_Undetermined_L007_R2_001.fastq.barcoded.fq_301_TGTACCA.fq'

### bowtie map tagdusted fastq files against ljrep sequences and filter sam alignment for hits
# echo ""
# echo "--- bowtie map against ljrep sequences -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 bowtie --seedmms 3 --maqerr 800 --seedlen 32 -k 1 --sam --time --offbase 0 --threads 6 $rep_file $y $y.ljrep.temp.sam; nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' $y.ljrep.temp.sam > $y.ljrep.sam; rm $y.ljrep.temp.sam;
# done;
# 
# ### make nonredundant list of lj_rep mapping tags
# echo ""
# echo "--- make nonredundant list of lj_rep mapping tags -----"
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_1_1""_trimmed".ljrep.sam "$read_1_2""_trimmed".ljrep.sam "$read_1_1""_trimmed".ljrep.nonred "$read_1_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_2_1""_trimmed".ljrep.sam "$read_2_2""_trimmed".ljrep.sam "$read_2_1""_trimmed".ljrep.nonred "$read_2_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_3_1""_trimmed".ljrep.sam "$read_3_2""_trimmed".ljrep.sam "$read_3_1""_trimmed".ljrep.nonred "$read_3_2""_trimmed".ljrep.nonred
# nice -n 19 perl "$script_dir"/52_parse_20120424.pl "$read_4_1""_trimmed".ljrep.sam "$read_4_2""_trimmed".ljrep.sam "$read_4_1""_trimmed".ljrep.nonred "$read_4_2""_trimmed".ljrep.nonred
# 
# 
# ### split tagdusted fastq file into refiltered and repseq fractions
# echo ""
# echo "--- split tagdusted fastq file into refiltered and repseq fractions -----"
# cd "$dir"
# for y in *_trimmed;
# do nice -n 19 perl "$script_dir"/20120426_54_parse.pl $y $y.ljrep.nonred $y.repfiltered.fq $y.repseq.fq;
# done;
# 
# ### remove temporary files
# echo ""
# echo "----- remove temporary files -----"
# cd "$dir"
# #rm *.txt
# #rm *.dust
# rm *.nonred
# rm *.sam
# #rm *.tagdusted.fq
# rm *.repseq.fq
# ####--------------------- end---------------------------------------#####



####--------------align the reads -----------------------------------####
for y in *.repfiltered.fq;
do nice -n 19 bwa aln -t 6 -l 28 "$ref_file" $y > $y.sai;
done;

### faidx for referance genome
nice -n 19 samtools faidx "$ref_file"

####--------------mapping the reads ---------------------------------####

nice -n 19 bwa sampe -P "$ref_file" "$read_1_1""_trimmed.repfiltered.fq"".sai" "$read_1_2""_trimmed.repfiltered.fq"".sai"  "$read_1_1""_trimmed.repfiltered.fq" "$read_1_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_1_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_2_1""_trimmed.repfiltered.fq"".sai" "$read_2_2""_trimmed.repfiltered.fq"".sai"  "$read_2_1""_trimmed.repfiltered.fq" "$read_2_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_2_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_3_1""_trimmed.repfiltered.fq"".sai" "$read_3_2""_trimmed.repfiltered.fq"".sai"  "$read_3_1""_trimmed.repfiltered.fq" "$read_3_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_3_1""_trimmed.repfiltered.fq"_sorted

nice -n 19 bwa sampe -P "$ref_file" "$read_4_1""_trimmed.repfiltered.fq"".sai" "$read_4_2""_trimmed.repfiltered.fq"".sai"  "$read_4_1""_trimmed.repfiltered.fq" "$read_4_2""_trimmed.repfiltered.fq" | nice -n 19 perl -lane 'print $_ if ($F[3] > 0 || $F[0] =~ m/^@/)'| nice -n 19 samtools view -bt "$ref_file".fai -| nice -n 19 samtools sort - "$read_4_1""_trimmed.repfiltered.fq"_sorted


### remove index file
rm *.sai
#rm *_trimmed
