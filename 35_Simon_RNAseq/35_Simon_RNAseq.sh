### data folder
/array/users/vgupta/35_Simon_RNAseq/2014-07-10


### unzip files
for file in *.bz2
do 
echo $file
bunzip2 --verbose --fast $file
done

### Run FastQ
for file in *.fastq
do 
echo $file
fastqc $file
done

### run TopHat/Cufflinks
cd /array/users/vgupta/35_Simon_RNAseq/2014-07-10
nohup sh ~/script/shell/35_Simon_RNAseq/20140714_TophatCufflinks.sh &

## create wig files
nohup sh ~/script/shell/35_Simon_RNAseq/20140717_40samples2_wig.sh &

## create tracks
sh ~/script/shell/35_Simon_RNAseq/20140717_json_paragraph.sh

## test for rRNA contamination
nohup sh ~/script/shell/20140717_map2_tRNA_rRNA.sh &

## extract all the transcript based FPKM values for 2unique mapped reads from tophat run
mkdir -p 01_40_samples_2unique_transcript_FPKM
data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-10"
cd $data_dir
for file in NG-*.fastq
do
echo $file
### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f
local_file="transcript.fpkm"
awk '$3=="transcript"' $work_dir/transcripts.gtf | cut -d '"' --output-delimiter=","  -f 4,6 | sort > $data_dir/"01_40_samples_2unique_transcript_FPKM/"$f"."$local_file
done

## merge all the fpkm values
cd /array/users/vgupta/35_Simon_RNAseq/2014-07-10/01_40_samples_2unique_transcript_FPKM
paste -d ',' NG-* > 40_samples.transcript.fpkm
cut -d ',' -f 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80 40_samples.transcript.fpkm | sed -e 's/,/\t/g' > 40_samples.transcript.fpkm.values

### grant access to mysql database
GRANT SELECT, UPDATE, CREATE ON 35_Simon_RNAseq.* TO 'user'@'%' IDENTIFIED BY "12345";
mysql -u user -h zombie.bioxray.au.dk -p 35_Simon_RNAseq --password="12345"


## create MySQL table on ZOMBIE
CREATE TABLE `20140718_40sample_2unique_transcript_FPKM` 
( ID VARCHAR(100),
7441_277_exoU_24_B2_lib45054_2601_3_1 FLOAT,
7441_277_exoU_24_B3_lib45078_2601_4_1 FLOAT,
7441_277_exoU_72_B2_lib45063_2601_2_1 FLOAT,
7441_277_exoU_72_B3_lib45087_2601_5_1 FLOAT,
7441_277_exoYF_24_B2_lib45048_2601_1_1 FLOAT,
7441_277_exoYF_24_B3_lib45072_2601_4_1 FLOAT,
7441_277_exoYF_72_B2_lib45060_2601_2_1 FLOAT,
7441_277_H2O_24_B3_lib45069_2601_3_1 FLOAT,
7441_277_nodC_24_B2_lib45051_2601_1_1 FLOAT,
7441_277_nodC_24_B3_lib45075_2601_4_1 FLOAT,
7441_277_R7A_24_B3_lib45066_2601_3_1 FLOAT,
7441_277_R7A_72_B2_lib45057_2601_3_1 FLOAT,
7441_277_R7A_72_B3_lib45081_2601_5_1 FLOAT,
7441_311_exoU_24_B2_lib45055_2601_2_1 FLOAT,
7441_311_exoU_24_B3_lib45079_2601_5_1 FLOAT,
7441_311_exoU_72_B2_lib45064_2601_3_1 FLOAT,
7441_311_exoU_72_B3_lib45088_2601_5_1 FLOAT,
7441_311_exoYF_24_B2_lib45049_2601_1_1 FLOAT,
7441_311_exoYF_24_B3_lib45073_2601_4_1 FLOAT,
7441_311_exoYF_72_B2_lib45061_2601_2_1 FLOAT,
7441_311_H2O_24_B3_lib45070_2601_3_1 FLOAT,
7441_311_nodC_24_B2_lib45052_2601_1_1 FLOAT,
7441_311_nodC_24_B3_lib45076_2601_4_1 FLOAT,
7441_311_R7A_24_B3_lib45067_2601_2_1 FLOAT,
7441_311_R7A_72_B2_lib45058_2601_1_1 FLOAT,
7441_311_R7A_72_B3_lib45082_2601_5_1 FLOAT,
7441_G_exoU_24_B2_lib45053_2601_1_1 FLOAT,
7441_G_exoU_24_B3_lib45077_2601_4_1 FLOAT,
7441_G_exoU_72_B2_lib45062_2601_2_1 FLOAT,
7441_G_exoU_72_B3_lib45086_2601_5_1 FLOAT,
7441_G_exoYF_24_B2_lib45047_2601_1_1 FLOAT,
7441_G_exoYF_24_B3_lib45071_2601_4_1 FLOAT,
7441_G_exoYF_72_B2_lib45059_2601_2_1 FLOAT,
7441_G_exoYF_72_B3_lib45083_2601_5_1 FLOAT,
7441_G_H2O_24_B3_lib45068_2601_3_1 FLOAT,
7441_G_nodC_24_B2_lib45050_2601_1_1 FLOAT,
7441_G_nodC_24_B3_lib45074_2601_4_1 FLOAT,
7441_G_R7A_24_B3_lib45065_2601_3_1 FLOAT,
7441_G_R7A_72_B2_lib45056_2601_2_1 FLOAT,
7441_G_R7A_72_B3_lib45080_2601_5_1 FLOAT 
);

LOAD DATA LOCAL INFILE '/u/vgupta/35_Simon_RNAseq/2014-07-10/01_40_samples_2unique_transcript_FPKM/40_samples.transcript.fpkm.values' INTO TABLE  `20140718_40sample_2unique_transcript_FPKM` IGNORE 1 LINES;

CREATE INDEX `20140718_40sample_2unique_transcript_FPKM.index` ON `20140718_40sample_2unique_transcript_FPKM` (ID); 

## add annotations
CREATE TABLE 20140718_40sample_2unique_transcript_FPKM_anno AS 
(
SELECT Lj30_ID,Chromosome,Start,END,nr_anno,cdsSeq_len,
7441_277_exoU_24_B2_lib45054_2601_3_1,
7441_277_exoU_24_B3_lib45078_2601_4_1,
7441_277_exoU_72_B2_lib45063_2601_2_1,
7441_277_exoU_72_B3_lib45087_2601_5_1,
7441_277_exoYF_24_B2_lib45048_2601_1_1,
7441_277_exoYF_24_B3_lib45072_2601_4_1,
7441_277_exoYF_72_B2_lib45060_2601_2_1,
7441_277_H2O_24_B3_lib45069_2601_3_1,
7441_277_nodC_24_B2_lib45051_2601_1_1,
7441_277_nodC_24_B3_lib45075_2601_4_1,
7441_277_R7A_24_B3_lib45066_2601_3_1,
7441_277_R7A_72_B2_lib45057_2601_3_1,
7441_277_R7A_72_B3_lib45081_2601_5_1,
7441_311_exoU_24_B2_lib45055_2601_2_1,
7441_311_exoU_24_B3_lib45079_2601_5_1,
7441_311_exoU_72_B2_lib45064_2601_3_1,
7441_311_exoU_72_B3_lib45088_2601_5_1,
7441_311_exoYF_24_B2_lib45049_2601_1_1,
7441_311_exoYF_24_B3_lib45073_2601_4_1,
7441_311_exoYF_72_B2_lib45061_2601_2_1,
7441_311_H2O_24_B3_lib45070_2601_3_1,
7441_311_nodC_24_B2_lib45052_2601_1_1,
7441_311_nodC_24_B3_lib45076_2601_4_1,
7441_311_R7A_24_B3_lib45067_2601_2_1,
7441_311_R7A_72_B2_lib45058_2601_1_1,
7441_311_R7A_72_B3_lib45082_2601_5_1,
7441_G_exoU_24_B2_lib45053_2601_1_1,
7441_G_exoU_24_B3_lib45077_2601_4_1,
7441_G_exoU_72_B2_lib45062_2601_2_1,
7441_G_exoU_72_B3_lib45086_2601_5_1,
7441_G_exoYF_24_B2_lib45047_2601_1_1,
7441_G_exoYF_24_B3_lib45071_2601_4_1,
7441_G_exoYF_72_B2_lib45059_2601_2_1,
7441_G_exoYF_72_B3_lib45083_2601_5_1,
7441_G_H2O_24_B3_lib45068_2601_3_1,
7441_G_nodC_24_B2_lib45050_2601_1_1,
7441_G_nodC_24_B3_lib45074_2601_4_1,
7441_G_R7A_24_B3_lib45065_2601_3_1,
7441_G_R7A_72_B2_lib45056_2601_2_1,
7441_G_R7A_72_B3_lib45080_2601_5_1 
FROM gene_models.20130801_Ljr30_genemodel t1 JOIN 35_Simon_RNAseq.20140718_40sample_2unique_transcript_FPKM t2 
ON t1.Lj30_ID=t2.ID
);

#select Lj30_ID, Chromosome,Start,nr_anno,7441_G_H2O_24_B3_lib45068_2601_3_1,7441_G_R7A_24_B3_lib45065_2601_3_1 from 20140718_40sample_2unique_transcript_FPKM_anno where 7441_G_H2O_24_B3_lib45068_2601_3_1/7441_G_R7A_24_B3_lib45065_2601_3_1>10 OR 7441_G_H2O_24_B3_lib45068_2601_3_1/7441_G_R7A_24_B3_lib45065_2601_3_1<0.1 ORDER BY 7441_G_R7A_24_B3_lib45065_2601_3_1 DESC limit 10;

SELECT Lj30_ID, Chromosome,Start,LEFT(nr_anno,50), G_H2O_24_B3,G_exoU_24_B3 
FROM 20140718_40sample_2unique_transcript_FPKM_anno 
WHERE
G_H2O_24_B3+G_exoU_24_B3>10 
AND G_exoU_24_B3/G_H2O_24_B3>10 
AND cdsSeq_len>300
ORDER BY G_exoU_24_B3 DESC limit 100;

SELECT Lj30_ID, Chromosome,Start,LEFT(nr_anno,50), G_exoU_24_B3,G_R7A_24_B3,311_exoU_24_B3,311_R7A_24_B3
FROM 20140718_40sample_2unique_transcript_FPKM_anno 
WHERE
G_exoU_24_B3>10 
AND G_R7A_24_B3 < 1
AND 311_exoU_24_B3 < 1 
AND 311_R7A_24_B3 < 1 
#AND cdsSeq_len>300
ORDER BY G_exoU_24_B3 DESC limit 100;

SELECT Lj30_ID, Chromosome,Start,LEFT(nr_anno,50), G_exoU_24_B3,G_R7A_24_B3,311_exoU_24_B3,311_R7A_24_B3
FROM 20140718_40sample_2unique_transcript_FPKM_anno 
WHERE
G_exoU_24_B3 > 50
AND G_R7A_24_B3/G_exoU_24_B3 < 0.5
AND 311_exoU_24_B3/G_exoU_24_B3 < 0.5 
AND 311_R7A_24_B3/G_exoU_24_B3 < 0.5 
AND cdsSeq_len>200
ORDER BY G_exoU_24_B3 DESC limit 100;

SELECT Lj30_ID, Chromosome,Start, cdsSeq_len, LEFT(nr_anno,50),  G_H2O_24_B3, G_exoU_24_B3, G_exoU_24_B3/G_H2O_24_B3 as Fold_Change
FROM 20140718_40sample_2unique_transcript_FPKM_anno 
WHERE
nr_anno LIKE '%nodule inception protein%';


## HTSeq on RNA-seq data on Dementor
GFF3="/array/users/vgupta/lotus_3.0/20140314_Lj30.gff3"
mkdir -p 02_HTeq_Count
data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-10"
cd $data_dir
for file in NG-*.fastq
do
echo $file
### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f
local_file="accepted_hits.2unique.bam"
htseq-count -i Parent -t exon -f bam $work_dir/$local_file $GFF3 | grep -v '__' > $data_dir/"02_HTeq_Count/"$f"."$local_file
done


### data folder
/array/users/vgupta/35_Simon_RNAseq/2014-07-21


### unzip files
for file in *.bz2
do 
echo $file
bunzip2 --verbose --fast $file
done

### run TopHat/Cufflinks
cd /array/users/vgupta/35_Simon_RNAseq/2014-07-21
nohup sh ~/script/shell/35_Simon_RNAseq/20140721_TophatCufflinks.sh &


### 311_exoYF_24_B2 and 311_H2O_24_B3 samples are sequenced twice
### merge two libraries 
cd /array/users/vgupta/35_Simon_RNAseq/2014-07-21
cat ../2014-07-10/NG-7441_311_exoYF_24_B2_lib45049_2601_1_1.fastq NG-7441_311_exoYF_24_B2_lib45049_2638_6_1.fastq > NG-7441_311_exoYF_24_B2_lib45049_2601_2638.fastq

cat ../2014-07-10/NG-7441_311_H2O_24_B3_lib45070_2601_3_1.fastq NG-7441_311_H2O_24_B3_lib45070_2638_6_1.fastq > NG-7441_311_H2O_24_B3_lib45070_2601_2638_3_1.fastq

### Run the tophat on the merged libraries
### nodes to be used
cores=12
intron_size=30000
GFF3="/array/users/vgupta/lotus_3.0/20140314_Lj30.gff3"
### reference genome
ref="/array/users/vgupta/35_Simon_RNAseq/2014-07-10/lj_r30.fa"
#index=$(basename $ref)
index="/array/users/vgupta/35_Simon_RNAseq/2014-07-10/lj_r30"
#bowtie2-build -f $ref $index
### data_dir
data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-21"
cd $data_dir
for file in NG-7441_311_exoYF_24_B2_lib45049_2601_2638.*
do
echo $file
### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f
mkdir -p $work_dir
### Run tophat
tophat -p $cores -I $intron_size -G $GFF3 -o $work_dir $index $file
### bam_file
bam="accepted_hits.2unique"
### extract uniquely mapped reads
samtools view -h $work_dir/accepted_hits.bam | grep  "^@" > $work_dir/accepted_hits.2unique.sam
samtools view $work_dir/accepted_hits.bam | grep -w "NH:i:1" >> $work_dir/accepted_hits.2unique.sam
samtools view $work_dir/accepted_hits.bam | grep -w "NH:i:2" >> $work_dir/accepted_hits.2unique.sam
samtools view -Shb $work_dir/accepted_hits.2unique.sam > $work_dir/$bam".bam"
# Sort the BAM file - not needed for tophat output 
samtools sort $work_dir/$bam".bam" $work_dir/$bam".sorted"
rm -f *.sam
### run cufflink
cufflinks -G $GFF3 --pre-mrna-fraction 0.5 --max-intron-length $intron_size -p $cores -o $work_dir $work_dir/$bam".sorted.bam"
done

### Run the tophat on the merged libraries
### nodes to be used
cores=12
intron_size=30000
GFF3="/array/users/vgupta/lotus_3.0/20140314_Lj30.gff3"
### reference genome
ref="/array/users/vgupta/35_Simon_RNAseq/2014-07-10/lj_r30.fa"
#index=$(basename $ref)
index="/array/users/vgupta/35_Simon_RNAseq/2014-07-10/lj_r30"
#bowtie2-build -f $ref $index
### data_dir
data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-21"
cd $data_dir
for file in NG-7441_311_H2O_24_B3_lib45070_2601_2638_3_1.*
do
echo $file
### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f
mkdir -p $work_dir
### Run tophat
tophat -p $cores -I $intron_size -G $GFF3 -o $work_dir $index $file
### bam_file
bam="accepted_hits.2unique"
### extract uniquely mapped reads
samtools view -h $work_dir/accepted_hits.bam | grep  "^@" > $work_dir/accepted_hits.2unique.sam
samtools view $work_dir/accepted_hits.bam | grep -w "NH:i:1" >> $work_dir/accepted_hits.2unique.sam
samtools view $work_dir/accepted_hits.bam | grep -w "NH:i:2" >> $work_dir/accepted_hits.2unique.sam
samtools view -Shb $work_dir/accepted_hits.2unique.sam > $work_dir/$bam".bam"
# Sort the BAM file - not needed for tophat output 
samtools sort $work_dir/$bam".bam" $work_dir/$bam".sorted"
rm -f *.sam
### run cufflink
cufflinks -G $GFF3 --pre-mrna-fraction 0.5 --max-intron-length $intron_size -p $cores -o $work_dir $work_dir/$bam".sorted.bam"
done


### Extract FPKM values again after merging two samples
## extract all the transcript based FPKM values for 2unique mapped reads from tophat run
cd /array/users/vgupta/35_Simon_RNAseq
mkdir -p 01_All_samples_2unique_transcript_FPKM
data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-10"
cd $data_dir
for file in NG-*.fastq
do
echo $file
### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f
local_file="transcript.fpkm"
awk '$3=="transcript"' $work_dir/transcripts.gtf | cut -d '"' --output-delimiter=","  -f 4,6 | sort > "/array/users/vgupta/35_Simon_RNAseq/01_All_samples_2unique_transcript_FPKM/"$f"."$local_file
done

data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-21"
cd $data_dir
for file in NG-*.fastq
do
echo $file
### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f
local_file="transcript.fpkm"
awk '$3=="transcript"' $work_dir/transcripts.gtf | cut -d '"' --output-delimiter=","  -f 4,6 | sort > "/array/users/vgupta/35_Simon_RNAseq/01_All_samples_2unique_transcript_FPKM/"$f"."$local_file
done

## extract all the transcript based FPKM values for 2unique mapped reads from tophat run
mkdir -p 01_All_samples_2unique_transcript_FPKM
data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-10"
cd $data_dir
for file in NG-*.fastq
do
echo $file
### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f
local_file="transcript.fpkm"
awk '$3=="transcript"' $work_dir/transcripts.gtf | cut -d '"' --output-delimiter=","  -f 4,6 | sort > /array/users/vgupta/35_Simon_RNAseq/01_All_samples_2unique_transcript_FPKM/"$f"."$local_file"
done

data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-21"
cd $data_dir
for file in NG-*.fastq
do
echo $file
### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f
local_file="transcript.fpkm"
awk '$3=="transcript"' $work_dir/transcripts.gtf | cut -d '"' --output-delimiter=","  -f 4,6 | sort > /array/users/vgupta/35_Simon_RNAseq/01_All_samples_2unique_transcript_FPKM/"$f"."$local_file"
done


## merge all the fpkm values
cd /array/users/vgupta/35_Simon_RNAseq/01_All_samples_2unique_transcript_FPKM
paste -d ',' NG-* > 20140724_All_samples.transcript.fpkm
cut -d ',' -f 1,\
2,4,6,8,10,\
12,14,16,18,20,\
22,24,26,28,30,\
32,34,36,38,40,\
42,44,46,48,50,\
52,54,56,58,60,\
62,64,66,68,70,\
72,74,76,78,80,\
82,84,86,88,90,\
92,94,96,98,100,\
102,104,106,108,110,\
112,114,116,118,120,\
122,124,126,128,130,\
132,134,136,138,140 \
20140724_All_samples.transcript.fpkm | sed -e 's/,/\t/g' > 20140724_All_samples.transcript.fpkm.values

## create MySQL table on ZOMBIE
CREATE TABLE `20140724_Allsample_2unique_transcript_FPKM` 
( ID VARCHAR(100),
277_exoU_24_B1 FLOAT,
277_exoU_24_B2 FLOAT,
277_exoU_24_B3 FLOAT,
277_exoU_72_B1 FLOAT,
277_exoU_72_B2 FLOAT,
277_exoU_72_B3 FLOAT,
277_exoYF_24_B1 FLOAT,
277_exoYF_24_B2 FLOAT,
277_exoYF_24_B3 FLOAT,
277_exoYF_72_B1 FLOAT,
277_exoYF_72_B2 FLOAT,
277_exoYF_72_B3 FLOAT,
277_H2O_24_B2 FLOAT,
277_H2O_24_B3 FLOAT,
277_nodC_24_B1 FLOAT,
277_nodC_24_B2 FLOAT,
277_nodC_24_B3 FLOAT,
277_R7A_24_B1 FLOAT,
277_R7A_24_B2 FLOAT,
277_R7A_24_B3 FLOAT,
277_R7A_72_B1 FLOAT,
277_R7A_72_B2 FLOAT,
277_R7A_72_B3 FLOAT,
311_exoU_24_B1 FLOAT,
311_exoU_24_B2 FLOAT,
311_exoU_24_B3 FLOAT,
311_exoU_72_B1 FLOAT,
311_exoU_72_B2 FLOAT,
311_exoU_72_B3 FLOAT,
311_exoYF_24_B1 FLOAT,
311_exoYF_24_B2 FLOAT,
311_exoYF_24_B3 FLOAT,
311_exoYF_72_B1 FLOAT,
311_exoYF_72_B2 FLOAT,
311_exoYF_72_B3 FLOAT,
311_H2O_24_B1 FLOAT,
311_H2O_24_B3 FLOAT,
311_nodC_24_B1 FLOAT,
311_nodC_24_B2 FLOAT,
311_nodC_24_B3 FLOAT,
311_R7A_24_B1 FLOAT,
311_R7A_24_B2 FLOAT,
311_R7A_24_B3 FLOAT,
311_R7A_72_B1 FLOAT,
311_R7A_72_B2 FLOAT,
311_R7A_72_B3 FLOAT,
G_exoU_24_B1 FLOAT,
G_exoU_24_B2 FLOAT,
G_exoU_24_B3 FLOAT,
G_exoU_72_B1 FLOAT,
G_exoU_72_B2 FLOAT,
G_exoU_72_B3 FLOAT,
G_exoYF_24_B1 FLOAT,
G_exoYF_24_B2 FLOAT,
G_exoYF_24_B3 FLOAT,
G_exoYF_72_B1 FLOAT,
G_exoYF_72_B2 FLOAT,
G_exoYF_72_B3 FLOAT,
G_H2O_24_B1 FLOAT,
G_H2O_24_B2 FLOAT,
G_H2O_24_B3 FLOAT,
G_nodC_24_B1 FLOAT,
G_nodC_24_B2 FLOAT,
G_nodC_24_B3 FLOAT,
G_R7A_24_B1 FLOAT,
G_R7A_24_B2 FLOAT,
G_R7A_24_B3 FLOAT,
G_R7A_72_B1 FLOAT,
G_R7A_72_B2 FLOAT,
G_R7A_72_B3 FLOAT
);

LOAD DATA LOCAL INFILE '/u/vgupta/35_Simon_RNAseq/01_All_samples_2unique_transcript_FPKM/20140724_All_samples.transcript.fpkm.values' INTO TABLE  `20140724_Allsample_2unique_transcript_FPKM` IGNORE 1 LINES;

CREATE INDEX `20140724_Allsample_2unique_transcript_FPKM.index` ON `20140724_Allsample_2unique_transcript_FPKM` (ID); 


## add annotations
CREATE TABLE 20140724_Allsample_2unique_transcript_FPKM_anno AS 
(
SELECT Lj30_ID,Chromosome,Start,END,nr_anno,cdsSeq_len,
277_exoU_24_B1 ,
277_exoU_24_B2 ,
277_exoU_24_B3 ,
277_exoU_72_B1 ,
277_exoU_72_B2 ,
277_exoU_72_B3 ,
277_exoYF_24_B1 ,
277_exoYF_24_B2 ,
277_exoYF_24_B3 ,
277_exoYF_72_B1 ,
277_exoYF_72_B2 ,
277_exoYF_72_B3 ,
277_H2O_24_B2 ,
277_H2O_24_B3 ,
277_nodC_24_B1 ,
277_nodC_24_B2 ,
277_nodC_24_B3 ,
277_R7A_24_B1 ,
277_R7A_24_B2 ,
277_R7A_24_B3 ,
277_R7A_72_B1 ,
277_R7A_72_B2 ,
277_R7A_72_B3 ,
311_exoU_24_B1 ,
311_exoU_24_B2 ,
311_exoU_24_B3 ,
311_exoU_72_B1 ,
311_exoU_72_B2 ,
311_exoU_72_B3 ,
311_exoYF_24_B1 ,
311_exoYF_24_B2 ,
311_exoYF_24_B3 ,
311_exoYF_72_B1 ,
311_exoYF_72_B2 ,
311_exoYF_72_B3 ,
311_H2O_24_B1 ,
311_H2O_24_B3 ,
311_nodC_24_B1 ,
311_nodC_24_B2 ,
311_nodC_24_B3 ,
311_R7A_24_B1 ,
311_R7A_24_B2 ,
311_R7A_24_B3 ,
311_R7A_72_B1 ,
311_R7A_72_B2 ,
311_R7A_72_B3 ,
G_exoU_24_B1 ,
G_exoU_24_B2 ,
G_exoU_24_B3 ,
G_exoU_72_B1 ,
G_exoU_72_B2 ,
G_exoU_72_B3 ,
G_exoYF_24_B1 ,
G_exoYF_24_B2 ,
G_exoYF_24_B3 ,
G_exoYF_72_B1 ,
G_exoYF_72_B2 ,
G_exoYF_72_B3 ,
G_H2O_24_B1 ,
G_H2O_24_B2 ,
G_H2O_24_B3 ,
G_nodC_24_B1 ,
G_nodC_24_B2 ,
G_nodC_24_B3 ,
G_R7A_24_B1 ,
G_R7A_24_B2 ,
G_R7A_24_B3 ,
G_R7A_72_B1 ,
G_R7A_72_B2 ,
G_R7A_72_B3  
FROM gene_models.20130801_Ljr30_genemodel t1 JOIN 35_Simon_RNAseq.20140724_Allsample_2unique_transcript_FPKM t2 
ON t1.Lj30_ID=t2.ID
);

### check nin
SELECT Lj30_ID, Chromosome,Start, cdsSeq_len, LEFT(nr_anno,50),  G_H2O_24_B3, G_exoU_24_B3, G_exoU_24_B3/G_H2O_24_B3 as Fold_Change
FROM 20140724_Allsample_2unique_transcript_FPKM_anno 
WHERE
nr_anno LIKE '%nodule inception protein%';

### run HTSeq
GFF3="/array/users/vgupta/lotus_3.0/20140314_Lj30.gff3"
mkdir -p 02_HTeq_Count
data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-10"
cd $data_dir
for file in NG-*.fastq
do
echo $file
### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f
local_file="accepted_hits.2unique.bam"
htseq-count -i Parent -t exon -f bam $work_dir/$local_file $GFF3 | grep -v '__' > /array/users/vgupta/35_Simon_RNAseq/02_HTeq_Count/"$f"."$local_file"
done
data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-21"
cd $data_dir
for file in NG-*.fastq
do
echo $file
### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f
local_file="accepted_hits.2unique.bam"
htseq-count -i Parent -t exon -f bam $work_dir/$local_file $GFF3 | grep -v '__' > /array/users/vgupta/35_Simon_RNAseq/02_HTeq_Count/"$f"."$local_file"
done

### merge the HTSeq count
cd /array/users/vgupta/35_Simon_RNAseq/02_HTeq_Count
paste NG-7441_*.accepted_hits.2unique.bam > 20140728_AllSamples_HTseqCounts.txt
cut -f 1,\
2,4,6,8,10,\
12,14,16,18,20,\
22,24,26,28,30,\
32,34,36,38,40,\
42,44,46,48,50,\
52,54,56,58,60,\
62,64,66,68,70,\
72,74,76,78,80,\
82,84,86,88,90,\
92,94,96,98,100,\
102,104,106,108,110,\
112,114,116,118,120,\
122,124,126,128,130,\
132,134,136,138,140 \

20140728_AllSamples_HTseqCounts.txt > 20140728_AllSamples_HTseqCounts.txt.values

### add headers to file
for file in NG-7441_*.accepted_hits.2unique.bam; do printf $file"\t"; done

Lj30_ID	277_exoU_24_B1	277_exoU_24_B2	277_exoU_24_B3	277_exoU_72_B1	277_exoU_72_B2	277_exoU_72_B3	277_exoYF_24_B1	277_exoYF_24_B2	277_exoYF_24_B3	277_exoYF_72_B1	277_exoYF_72_B2	277_exoYF_72_B3	277_H2O_24_B2	277_H2O_24_B3	277_nodC_24_B1	277_nodC_24_B2	277_nodC_24_B3	277_R7A_24_B1	277_R7A_24_B2	277_R7A_24_B3	277_R7A_72_B1	277_R7A_72_B2	277_R7A_72_B3	311_exoU_24_B1	311_exoU_24_B2	311_exoU_24_B3	311_exoU_72_B1	311_exoU_72_B2	311_exoU_72_B3	311_exoYF_24_B1	311_exoYF_24_B2	311_exoYF_24_B3	311_exoYF_72_B1	311_exoYF_72_B2	311_exoYF_72_B3	311_H2O_24_B1	311_H2O_24_B3	311_nodC_24_B1	311_nodC_24_B2	311_nodC_24_B3	311_R7A_24_B1	311_R7A_24_B2	311_R7A_24_B3	311_R7A_72_B1	311_R7A_72_B2	311_R7A_72_B3	G_exoU_24_B1	G_exoU_24_B2	G_exoU_24_B3	G_exoU_72_B1	G_exoU_72_B2	G_exoU_72_B3	G_exoYF_24_B1	G_exoYF_24_B2	G_exoYF_24_B3	G_exoYF_72_B1	G_exoYF_72_B2	G_exoYF_72_B3	G_H2O_24_B1	G_H2O_24_B2	G_H2O_24_B3	G_nodC_24_B1	G_nodC_24_B2	G_nodC_24_B3	G_R7A_24_B1	G_R7A_24_B2	G_R7A_24_B3	G_R7A_72_B1	G_R7A_72_B2	G_R7A_72_B3

### normalize the counts
python ~/script/python/134_normalize_table.py 20140728_AllSamples_HTseqCounts.txt.values > 20140728_AllSamples_HTseqCounts.txt.values.norm

### load table into MySQL
CREATE TABLE `20140728_Allsample_2unique_transcript_HTseqCounts` 
( ID VARCHAR(100),
277_exoU_24_B1 FLOAT,
277_exoU_24_B2 FLOAT,
277_exoU_24_B3 FLOAT,
277_exoU_72_B1 FLOAT,
277_exoU_72_B2 FLOAT,
277_exoU_72_B3 FLOAT,
277_exoYF_24_B1 FLOAT,
277_exoYF_24_B2 FLOAT,
277_exoYF_24_B3 FLOAT,
277_exoYF_72_B1 FLOAT,
277_exoYF_72_B2 FLOAT,
277_exoYF_72_B3 FLOAT,
277_H2O_24_B2 FLOAT,
277_H2O_24_B3 FLOAT,
277_nodC_24_B1 FLOAT,
277_nodC_24_B2 FLOAT,
277_nodC_24_B3 FLOAT,
277_R7A_24_B1 FLOAT,
277_R7A_24_B2 FLOAT,
277_R7A_24_B3 FLOAT,
277_R7A_72_B1 FLOAT,
277_R7A_72_B2 FLOAT,
277_R7A_72_B3 FLOAT,
311_exoU_24_B1 FLOAT,
311_exoU_24_B2 FLOAT,
311_exoU_24_B3 FLOAT,
311_exoU_72_B1 FLOAT,
311_exoU_72_B2 FLOAT,
311_exoU_72_B3 FLOAT,
311_exoYF_24_B1 FLOAT,
311_exoYF_24_B2 FLOAT,
311_exoYF_24_B3 FLOAT,
311_exoYF_72_B1 FLOAT,
311_exoYF_72_B2 FLOAT,
311_exoYF_72_B3 FLOAT,
311_H2O_24_B1 FLOAT,
311_H2O_24_B3 FLOAT,
311_nodC_24_B1 FLOAT,
311_nodC_24_B2 FLOAT,
311_nodC_24_B3 FLOAT,
311_R7A_24_B1 FLOAT,
311_R7A_24_B2 FLOAT,
311_R7A_24_B3 FLOAT,
311_R7A_72_B1 FLOAT,
311_R7A_72_B2 FLOAT,
311_R7A_72_B3 FLOAT,
G_exoU_24_B1 FLOAT,
G_exoU_24_B2 FLOAT,
G_exoU_24_B3 FLOAT,
G_exoU_72_B1 FLOAT,
G_exoU_72_B2 FLOAT,
G_exoU_72_B3 FLOAT,
G_exoYF_24_B1 FLOAT,
G_exoYF_24_B2 FLOAT,
G_exoYF_24_B3 FLOAT,
G_exoYF_72_B1 FLOAT,
G_exoYF_72_B2 FLOAT,
G_exoYF_72_B3 FLOAT,
G_H2O_24_B1 FLOAT,
G_H2O_24_B2 FLOAT,
G_H2O_24_B3 FLOAT,
G_nodC_24_B1 FLOAT,
G_nodC_24_B2 FLOAT,
G_nodC_24_B3 FLOAT,
G_R7A_24_B1 FLOAT,
G_R7A_24_B2 FLOAT,
G_R7A_24_B3 FLOAT,
G_R7A_72_B1 FLOAT,
G_R7A_72_B2 FLOAT,
G_R7A_72_B3 FLOAT,
sum FLOAT,
277_exoU_24_B1_norm FLOAT,
277_exoU_24_B2_norm FLOAT,
277_exoU_24_B3_norm FLOAT,
277_exoU_72_B1_norm FLOAT,
277_exoU_72_B2_norm FLOAT,
277_exoU_72_B3_norm FLOAT,
277_exoYF_24_B1_norm FLOAT,
277_exoYF_24_B2_norm FLOAT,
277_exoYF_24_B3_norm FLOAT,
277_exoYF_72_B1_norm FLOAT,
277_exoYF_72_B2_norm FLOAT,
277_exoYF_72_B3_norm FLOAT,
277_H2O_24_B2_norm FLOAT,
277_H2O_24_B3_norm FLOAT,
277_nodC_24_B1_norm FLOAT,
277_nodC_24_B2_norm FLOAT,
277_nodC_24_B3_norm FLOAT,
277_R7A_24_B1_norm FLOAT,
277_R7A_24_B2_norm FLOAT,
277_R7A_24_B3_norm FLOAT,
277_R7A_72_B1_norm FLOAT,
277_R7A_72_B2_norm FLOAT,
277_R7A_72_B3_norm FLOAT,
311_exoU_24_B1_norm FLOAT,
311_exoU_24_B2_norm FLOAT,
311_exoU_24_B3_norm FLOAT,
311_exoU_72_B1_norm FLOAT,
311_exoU_72_B2_norm FLOAT,
311_exoU_72_B3_norm FLOAT,
311_exoYF_24_B1_norm FLOAT,
311_exoYF_24_B2_norm FLOAT,
311_exoYF_24_B3_norm FLOAT,
311_exoYF_72_B1_norm FLOAT,
311_exoYF_72_B2_norm FLOAT,
311_exoYF_72_B3_norm FLOAT,
311_H2O_24_B1_norm FLOAT,
311_H2O_24_B3_norm FLOAT,
311_nodC_24_B1_norm FLOAT,
311_nodC_24_B2_norm FLOAT,
311_nodC_24_B3_norm FLOAT,
311_R7A_24_B1_norm FLOAT,
311_R7A_24_B2_norm FLOAT,
311_R7A_24_B3_norm FLOAT,
311_R7A_72_B1_norm FLOAT,
311_R7A_72_B2_norm FLOAT,
311_R7A_72_B3_norm FLOAT,
G_exoU_24_B1_norm FLOAT,
G_exoU_24_B2_norm FLOAT,
G_exoU_24_B3_norm FLOAT,
G_exoU_72_B1_norm FLOAT,
G_exoU_72_B2_norm FLOAT,
G_exoU_72_B3_norm FLOAT,
G_exoYF_24_B1_norm FLOAT,
G_exoYF_24_B2_norm FLOAT,
G_exoYF_24_B3_norm FLOAT,
G_exoYF_72_B1_norm FLOAT,
G_exoYF_72_B2_norm FLOAT,
G_exoYF_72_B3_norm FLOAT,
G_H2O_24_B1_norm FLOAT,
G_H2O_24_B2_norm FLOAT,
G_H2O_24_B3_norm FLOAT,
G_nodC_24_B1_norm FLOAT,
G_nodC_24_B2_norm FLOAT,
G_nodC_24_B3_norm FLOAT,
G_R7A_24_B1_norm FLOAT,
G_R7A_24_B2_norm FLOAT,
G_R7A_24_B3_norm FLOAT,
G_R7A_72_B1_norm FLOAT,
G_R7A_72_B2_norm FLOAT,
G_R7A_72_B3_norm FLOAT,
sum_norm FLOAT,
score FLOAT );

LOAD DATA LOCAL INFILE '/u/vgupta/35_Simon_RNAseq/02_HTeq_Count/20140728_AllSamples_HTseqCounts.txt.values.norm' INTO TABLE  `20140728_Allsample_2unique_transcript_HTseqCounts` IGNORE 1 LINES;

CREATE INDEX `20140728_Allsample_2unique_transcript_HTseqCounts.index` ON `20140728_Allsample_2unique_transcript_HTseqCounts` (ID); 


## add annotations
CREATE TABLE 20140728_Allsample_2unique_transcript_HTseqCounts_anno AS 
(
SELECT Lj30_ID,Chromosome,Start,END,nr_anno,cdsSeq_len,
277_exoU_24_B1  ,
277_exoU_24_B2  ,
277_exoU_24_B3  ,
277_exoU_72_B1  ,
277_exoU_72_B2  ,
277_exoU_72_B3  ,
277_exoYF_24_B1  ,
277_exoYF_24_B2  ,
277_exoYF_24_B3  ,
277_exoYF_72_B1  ,
277_exoYF_72_B2  ,
277_exoYF_72_B3  ,
277_H2O_24_B2  ,
277_H2O_24_B3  ,
277_nodC_24_B1  ,
277_nodC_24_B2  ,
277_nodC_24_B3  ,
277_R7A_24_B1  ,
277_R7A_24_B2  ,
277_R7A_24_B3  ,
277_R7A_72_B1  ,
277_R7A_72_B2  ,
277_R7A_72_B3  ,
311_exoU_24_B1  ,
311_exoU_24_B2  ,
311_exoU_24_B3  ,
311_exoU_72_B1  ,
311_exoU_72_B2  ,
311_exoU_72_B3  ,
311_exoYF_24_B1  ,
311_exoYF_24_B2  ,
311_exoYF_24_B3  ,
311_exoYF_72_B1  ,
311_exoYF_72_B2  ,
311_exoYF_72_B3  ,
311_H2O_24_B1  ,
311_H2O_24_B3  ,
311_nodC_24_B1  ,
311_nodC_24_B2  ,
311_nodC_24_B3  ,
311_R7A_24_B1  ,
311_R7A_24_B2  ,
311_R7A_24_B3  ,
311_R7A_72_B1  ,
311_R7A_72_B2  ,
311_R7A_72_B3  ,
G_exoU_24_B1  ,
G_exoU_24_B2  ,
G_exoU_24_B3  ,
G_exoU_72_B1  ,
G_exoU_72_B2  ,
G_exoU_72_B3  ,
G_exoYF_24_B1  ,
G_exoYF_24_B2  ,
G_exoYF_24_B3  ,
G_exoYF_72_B1  ,
G_exoYF_72_B2  ,
G_exoYF_72_B3  ,
G_H2O_24_B1  ,
G_H2O_24_B2  ,
G_H2O_24_B3  ,
G_nodC_24_B1  ,
G_nodC_24_B2  ,
G_nodC_24_B3  ,
G_R7A_24_B1  ,
G_R7A_24_B2  ,
G_R7A_24_B3  ,
G_R7A_72_B1  ,
G_R7A_72_B2  ,
G_R7A_72_B3  ,
sum  ,
277_exoU_24_B1_norm  ,
277_exoU_24_B2_norm  ,
277_exoU_24_B3_norm  ,
277_exoU_72_B1_norm  ,
277_exoU_72_B2_norm  ,
277_exoU_72_B3_norm  ,
277_exoYF_24_B1_norm  ,
277_exoYF_24_B2_norm  ,
277_exoYF_24_B3_norm  ,
277_exoYF_72_B1_norm  ,
277_exoYF_72_B2_norm  ,
277_exoYF_72_B3_norm  ,
277_H2O_24_B2_norm  ,
277_H2O_24_B3_norm  ,
277_nodC_24_B1_norm  ,
277_nodC_24_B2_norm  ,
277_nodC_24_B3_norm  ,
277_R7A_24_B1_norm  ,
277_R7A_24_B2_norm  ,
277_R7A_24_B3_norm  ,
277_R7A_72_B1_norm  ,
277_R7A_72_B2_norm  ,
277_R7A_72_B3_norm  ,
311_exoU_24_B1_norm  ,
311_exoU_24_B2_norm  ,
311_exoU_24_B3_norm  ,
311_exoU_72_B1_norm  ,
311_exoU_72_B2_norm  ,
311_exoU_72_B3_norm  ,
311_exoYF_24_B1_norm  ,
311_exoYF_24_B2_norm  ,
311_exoYF_24_B3_norm  ,
311_exoYF_72_B1_norm  ,
311_exoYF_72_B2_norm  ,
311_exoYF_72_B3_norm  ,
311_H2O_24_B1_norm  ,
311_H2O_24_B3_norm  ,
311_nodC_24_B1_norm  ,
311_nodC_24_B2_norm  ,
311_nodC_24_B3_norm  ,
311_R7A_24_B1_norm  ,
311_R7A_24_B2_norm  ,
311_R7A_24_B3_norm  ,
311_R7A_72_B1_norm  ,
311_R7A_72_B2_norm  ,
311_R7A_72_B3_norm  ,
G_exoU_24_B1_norm  ,
G_exoU_24_B2_norm  ,
G_exoU_24_B3_norm  ,
G_exoU_72_B1_norm  ,
G_exoU_72_B2_norm  ,
G_exoU_72_B3_norm  ,
G_exoYF_24_B1_norm  ,
G_exoYF_24_B2_norm  ,
G_exoYF_24_B3_norm  ,
G_exoYF_72_B1_norm  ,
G_exoYF_72_B2_norm  ,
G_exoYF_72_B3_norm  ,
G_H2O_24_B1_norm  ,
G_H2O_24_B2_norm  ,
G_H2O_24_B3_norm  ,
G_nodC_24_B1_norm  ,
G_nodC_24_B2_norm  ,
G_nodC_24_B3_norm  ,
G_R7A_24_B1_norm  ,
G_R7A_24_B2_norm  ,
G_R7A_24_B3_norm  ,
G_R7A_72_B1_norm  ,
G_R7A_72_B2_norm  ,
G_R7A_72_B3_norm  ,
sum_norm  ,
score   
FROM gene_models.20130801_Ljr30_genemodel t1 JOIN 35_Simon_RNAseq.20140728_Allsample_2unique_transcript_HTseqCounts t2 
ON t1.Lj30_ID=t2.ID
);

### check nin
SELECT Lj30_ID, Chromosome,Start, cdsSeq_len, LEFT(nr_anno,50),  G_H2O_24_B3, G_exoU_24_B3, G_exoU_24_B3/G_H2O_24_B3 as Fold_Change
FROM 20140724_Allsample_2unique_transcript_FPKM_anno 
WHERE
nr_anno LIKE '%nodule inception protein%';

### check nin
SELECT Lj30_ID, Chromosome,Start, cdsSeq_len, LEFT(nr_anno,50),  G_H2O_24_B3, G_exoU_24_B3, G_exoU_24_B3/G_H2O_24_B3 as Fold_Change
FROM 20140728_Allsample_2unique_transcript_HTseqCounts_anno 
WHERE
nr_anno LIKE '%nodule inception protein%';

####################################
######### featurecount #############
####################################
/array/users/vgupta/35_Simon_RNAseq/04_FeatureCount
### run featurecount by gene
cd /array/users/vgupta/35_Simon_RNAseq/04_FeatureCount/01_GeneWise
GTF="/array/users/vgupta/lotus_3.0/20140314_Lj30.gtf"
data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-10"
cd $data_dir
for file in NG-*.fastq
do
echo $file
### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f
local_file="accepted_hits.2unique.bam"
featureCounts -T 1 -O -M -a $GTF -t exon -g gene_id  -o /array/users/vgupta/35_Simon_RNAseq/04_FeatureCount/01_GeneWise/"$f"."$local_file" $work_dir/$local_file 
grep -v '^#' /array/users/vgupta/35_Simon_RNAseq/04_FeatureCount/01_GeneWise/"$f"."$local_file" | cut -f 1,7 > /array/users/vgupta/35_Simon_RNAseq/04_FeatureCount/01_GeneWise/"$f"."$local_file".values
rm /array/users/vgupta/35_Simon_RNAseq/04_FeatureCount/01_GeneWise/"$f"."$local_file"
done

rm -rf *.summary

data_dir="/array/users/vgupta/35_Simon_RNAseq/2014-07-21"
cd $data_dir
for file in NG-*.fastq
do
echo $file
### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f
local_file="accepted_hits.2unique.bam"
featureCounts -T 1 -O -M -a $GTF -t exon -g gene_id  -o /array/users/vgupta/35_Simon_RNAseq/04_FeatureCount/01_GeneWise/"$f"."$local_file" $work_dir/$local_file 
grep -v '^#' /array/users/vgupta/35_Simon_RNAseq/04_FeatureCount/01_GeneWise/"$f"."$local_file" | cut -f 1,7 > /array/users/vgupta/35_Simon_RNAseq/04_FeatureCount/01_GeneWise/"$f"."$local_file".values
rm /array/users/vgupta/35_Simon_RNAseq/04_FeatureCount/01_GeneWise/"$f"."$local_file"
done

cd /array/users/vgupta/35_Simon_RNAseq/04_FeatureCount/01_GeneWise/
rm -rf *.summary

### merge the count files
paste *.values > 20140805_AllSamples_FeatureCount.txt
cut -f 1,\
2,4,6,8,10,\
12,14,16,18,20,\
22,24,26,28,30,\
32,34,36,38,40,\
42,44,46,48,50,\
52,54,56,58,60,\
62,64,66,68,70,\
72,74,76,78,80,\
82,84,86,88,90,\
92,94,96,98,100,\
102,104,106,108,110,\
112,114,116,118,120,\
122,124,126,128,130,\
132,134,136,138,140 \
 20140805_AllSamples_FeatureCount.txt > 20140805_AllSamples_FeatureCount.txt.values
 
 ## manually edit the headers

featureCounts -T 1 -O -M -a sample.gtf -t exon -g transcript_id  -o counts.txt sample.sam

##############################
### Running Cuffdiff #########
##############################

cd /array/users/vgupta/35_Simon_RNAseq/03_CuffDiff
### fix the gtf file for the CuffDiff
GENOME="/array/users/vgupta/lotus_3.0/lj_r30.fa"
GTF="/array/users/vgupta/lotus_3.0/20140314_Lj30.gtf"
cuffcompare -s $GENOME -CG -r $GTF $GTF

data_dir1="/array/users/vgupta/35_Simon_RNAseq/2014-07-10"
data_dir2="/array/users/vgupta/35_Simon_RNAseq/2014-07-21"
cuffdiff \
--labels \
277_exoU_24,277_exoU_72,277_exoYF_24,277_exoYF_72,\
277_H2O_24,277_nodC_24,277_R7A_24,277_R7A_72,\
311_exoU_24,311_exoU_72,311_exoYF_24,311_exoYF_72,\
311_H2O_24,311_nodC_24,311_R7A_24,311_R7A_72,\
G_exoU_24,G_exoU_72,G_exoYF_24,311_exoYF_72,\
G_H2O_24,G_nodC_24,G_R7A_24,G_R7A_72 \
-v \
 -p 6 cuffcmp.combined.gtf \
\
"$data_dir2/"dir_NG-7441_277_exoU_24_B1_lib45031_2638_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_277_exoU_24_B2_lib45054_2601_3_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_277_exoU_24_B3_lib45078_2601_4_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_277_exoU_72_B1_lib45040_2638_3_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_277_exoU_72_B2_lib45063_2601_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_277_exoU_72_B3_lib45087_2601_5_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_277_exoYF_24_B1_lib45025_2638_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_277_exoYF_24_B2_lib45048_2601_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_277_exoYF_24_B3_lib45072_2601_4_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_277_exoYF_72_B1_lib45037_2638_3_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_277_exoYF_72_B2_lib45060_2601_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir2/"dir_NG-7441_277_exoYF_72_B3_lib45084_2638_4_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_277_H2O_24_B2_lib45046_2638_4_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_277_H2O_24_B3_lib45069_2601_3_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_277_nodC_24_B1_lib45028_2638_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_277_nodC_24_B2_lib45051_2601_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_277_nodC_24_B3_lib45075_2601_4_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_277_R7A_24_B1_lib45019_2638_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir2/"dir_NG-7441_277_R7A_24_B2_lib45043_2638_4_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_277_R7A_24_B3_lib45066_2601_3_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_277_R7A_72_B1_lib45034_2638_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_277_R7A_72_B2_lib45057_2601_3_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_277_R7A_72_B3_lib45081_2601_5_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_311_exoU_24_B1_lib45032_2638_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_311_exoU_24_B2_lib45055_2601_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_311_exoU_24_B3_lib45079_2601_5_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_311_exoU_72_B1_lib45041_2638_3_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_311_exoU_72_B2_lib45064_2601_3_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_311_exoU_72_B3_lib45088_2601_5_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_311_exoYF_24_B1_lib45026_2638_4_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir2/"dir_NG-7441_311_exoYF_24_B2_lib45049_2601_2638.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_311_exoYF_24_B3_lib45073_2601_4_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_311_exoYF_72_B1_lib45038_2638_3_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_311_exoYF_72_B2_lib45061_2601_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir2/"dir_NG-7441_311_exoYF_72_B3_lib45085_2638_4_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_311_H2O_24_B1_lib45023_2638_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir2/"dir_NG-7441_311_H2O_24_B3_lib45070_2601_2638_3_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_311_nodC_24_B1_lib45029_2638_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_311_nodC_24_B2_lib45052_2601_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_311_nodC_24_B3_lib45076_2601_4_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_311_R7A_24_B1_lib45020_2638_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir2/"dir_NG-7441_311_R7A_24_B2_lib45044_2638_4_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_311_R7A_24_B3_lib45067_2601_2_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_311_R7A_72_B1_lib45035_2638_3_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_311_R7A_72_B2_lib45058_2601_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_311_R7A_72_B3_lib45082_2601_5_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_G_exoU_24_B1_lib45030_2638_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_exoU_24_B2_lib45053_2601_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_exoU_24_B3_lib45077_2601_4_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_G_exoU_72_B1_lib45039_2638_3_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_exoU_72_B2_lib45062_2601_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_exoU_72_B3_lib45086_2601_5_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_G_exoYF_24_B1_lib45024_2638_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_exoYF_24_B2_lib45047_2601_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_exoYF_24_B3_lib45071_2601_4_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_G_exoYF_72_B1_lib45036_2638_3_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_exoYF_72_B2_lib45059_2601_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_exoYF_72_B3_lib45083_2601_5_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_G_H2O_24_B1_lib45021_2638_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir2/"dir_NG-7441_G_H2O_24_B2_lib45045_2638_4_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_H2O_24_B3_lib45068_2601_3_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_G_nodC_24_B1_lib45027_2638_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_nodC_24_B2_lib45050_2601_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_nodC_24_B3_lib45074_2601_4_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_G_R7A_24_B1_lib45018_2638_1_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir2/"dir_NG-7441_G_R7A_24_B2_lib45042_2638_3_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_R7A_24_B3_lib45065_2601_3_1.fastq/"accepted_hits.2unique.sorted.bam" \
\
"$data_dir2/"dir_NG-7441_G_R7A_72_B1_lib45033_2638_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_R7A_72_B2_lib45056_2601_2_1.fastq/"accepted_hits.2unique.sorted.bam",\
"$data_dir1/"dir_NG-7441_G_R7A_72_B3_lib45080_2601_5_1.fastq/"accepted_hits.2unique.sorted.bam" 




