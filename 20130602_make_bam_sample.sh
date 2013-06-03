### make a sample script for tagdust filtering till the producing bam file
set -e

### reference file
GENOME="/u/pm/data/2012_08_30_ljr30/lj_r30.fa"

### WORKDIR
WORKDIR="/u/pm/data/2012_04_04_jin_mg_accessions/2013_week21/BAMs"
cd $WORKDIR

### mkdir sample
if [ -d sample ];
then
   echo "sample exists"
else
   mkdir sample
fi

for file in *bam;
do 
samtools index $file
samtools view -b "$file" chr1:1-2000000 > sample/"$file""_sample.bam"
done