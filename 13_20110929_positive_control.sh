#!/bin/bash
#only for false positive purpose
### enter the directory

. "configuration_file.sh"


### define flanking regions
nb_1=`expr $insert_1 '*' 2`
nb_2=`expr $insert_2 '*' 2`
nb_3=`expr $insert_3 '*' 2`
nb_4=`expr $insert_4 '*' 2`

cd $rep_dir
:<<filtering
### 1. Index the rep elements
nice -n 19 bwa index $rep_file


### align read
nice -n 19 bwa aln $rep_file $pair_read_1 >$pair_read_1.sai
nice -n 19 bwa aln $rep_file $pair_read_2 >$pair_read_2.sai
nice -n 19 bwa aln $rep_file $pair_read_3 >$pair_read_3.sai
nice -n 19 bwa aln $rep_file $pair_read_4 >$pair_read_4.sai
nice -n 19 bwa aln $rep_file $pair_read_5 >$pair_read_5.sai
nice -n 19 bwa aln $rep_file $pair_read_6 >$pair_read_6.sai
nice -n 19 bwa aln $rep_file $pair_read_7 >$pair_read_7.sai
nice -n 19 bwa aln $rep_file $pair_read_8 >$pair_read_8.sai


### pair end mapping
nice -n 19 bwa sampe -a $insert_1 $rep_file $pair_read_1.sai $pair_read_2.sai $pair_read_1 $pair_read_2 | nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' >$pair_read_1.sam
nice -n 19 bwa sampe -a $insert_2 $rep_file $pair_read_3.sai $pair_read_4.sai $pair_read_3 $pair_read_4 | nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' >$pair_read_3.sam
nice -n 19 bwa sampe -a $insert_3 $rep_file $pair_read_5.sai $pair_read_6.sai $pair_read_5 $pair_read_6 | nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' >$pair_read_5.sam
nice -n 19 bwa sampe -a $insert_4 $rep_file $pair_read_7.sai $pair_read_8.sai $pair_read_7 $pair_read_8 | nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' >$pair_read_7.sam



### taking out sequences where only one read of pair is mapped
### remember T for mate pair and F for end pair

nice -n 19 python 13a.py $pair_read_1.sam $pair_read_1 $pair_read_1.fil.sam $nb_1 F $pair_read_1.unmapped.unique> $pair_read_1.filtered
nice -n 19 python 13a.py $pair_read_1.sam $pair_read_2 $pair_read_2.fil.sam $nb_1 F $pair_read_2.unmapped.unique> $pair_read_2.filtered
nice -n 19 python 13a.py $pair_read_3.sam $pair_read_3 $pair_read_3.fil.sam $nb_2 F $pair_read_3.unmapped.unique> $pair_read_3.filtered
nice -n 19 python 13a.py $pair_read_3.sam $pair_read_4 $pair_read_4.fil.sam $nb_2 F $pair_read_4.unmapped.unique> $pair_read_4.filtered
nice -n 19 python 13a.py $pair_read_5.sam $pair_read_5 $pair_read_5.fil.sam $nb_3 T $pair_read_5.unmapped.unique> $pair_read_5.filtered
nice -n 19 python 13a.py $pair_read_5.sam $pair_read_6 $pair_read_6.fil.sam $nb_3 T $pair_read_6.unmapped.unique> $pair_read_6.filtered
nice -n 19 python 13a.py $pair_read_7.sam $pair_read_7 $pair_read_7.fil.sam $nb_4 T $pair_read_7.unmapped.unique> $pair_read_7.filtered
nice -n 19 python 13a.py $pair_read_7.sam $pair_read_8 $pair_read_8.fil.sam $nb_4 T $pair_read_8.unmapped.unique> $pair_read_8.filtered

filtering
### use filtered read sequences for further use
pair_read_1=$pair_read_1
pair_read_2=$pair_read_2
pair_read_3=$pair_read_3
pair_read_4=$pair_read_4
pair_read_5=$pair_read_5
pair_read_6=$pair_read_6
pair_read_7=$pair_read_7
pair_read_8=$pair_read_8



#### Only for validation purpose
#### to check for insert which are already inserted

cd $work_dir
### making reference file compatible
ref_file="$ref"_replaced
nice -n 19 python 13b.py $ref >"$ref"_replaced


### Make blast database for genome
nice -n 19 formatdb -i $ref_file -o T -p F

input=$positive_control
### read line by line and take out N-region with the flanking bases around it

### get the start and end of the N region


### echo


### make new genome files
>$pair_read_1.gene_gap_out.fa
>$pair_read_3.gene_gap_out.fa
>$pair_read_5.gene_gap_out.fa
>$pair_read_7.gene_gap_out.fa
>$pair_read_1.Nfil_gene_gap_out.fa
>$pair_read_3.Nfil_gene_gap_out.fa
>$pair_read_5.Nfil_gene_gap_out.fa
>$pair_read_7.Nfil_gene_gap_out.fa

### initializing the output file
>"$dat".output.txt_all
>"$dat"_reverse_ele.output.txt_all
>unmapped_reads
>$pair_read_1.unmapped.fq.unique.rep_ele_all

number_of_gaps=`cat $input|wc -l`
count=1

>input_file
gap_count=0 ### for taking 10 gaps at a time
while read lines
do 

gap_count=`expr $gap_count '+' 1`
echo $gap_count
echo $input
echo $lines >>input_file
>rep_region ### for stroing uniq starting positions used in 10k
>rep_pos
if [ "$gap_count" -eq "$number_of_gaps" ]
then
gap_count=0

while read line
do

st=`echo $line|awk '{split($0,a," ");  print a[9]}'`
en=`echo $line|awk '{split($0,a," ");  print a[10]}'`
chro=`echo $line|awk '{split($0,a," ");  print a[2]}'`
### make sure start < End otherwise screws up blast
if [ "$st" -lt "$en" ]
then
	st=$st
	en=$en
else
	st_im=$st
	st=$en
	en=$st_im
fi





echo $st,$en
echo "$count""\t""$chro""\t""$st""\t""$en" >>rep_pos
echo nice -n 19 fastacmd -d "$ref_file" -p F -s "$chro" -L "`expr $st '-' $nb_1`"','"`expr $en '+' $nb_1`">check.txt
chmod 777 check.txt
z=cat check.txt > $pair_read_1.gene_gap_out.fa_im
python 13d.py $pair_read_1.gene_gap_out.fa_im $nb_1 >$pair_read_1.gene_gap_out.fa 
echo END>> $pair_read_1.gene_gap_out.fa 
echo nice -n 19 fastacmd -d "$ref_file" -p F -s "$chro" -L "`expr $st '-' $nb_2`"','"`expr $en '+' $nb_2`">check.txt
chmod 777 check.txt
z=cat check.txt > $pair_read_3.gene_gap_out.fa_im
python 13d.py $pair_read_3.gene_gap_out.fa_im $nb_2 >$pair_read_3.gene_gap_out.fa 
echo END>> $pair_read_3.gene_gap_out.fa 
echo nice -n 19 fastacmd -d "$ref_file" -p F -s "$chro" -L "`expr $st '-' $nb_3`"','"`expr $en '+' $nb_3`">check.txt
chmod 777 check.txt
z=cat check.txt > $pair_read_5.gene_gap_out.fa_im
python 13d.py $pair_read_5.gene_gap_out.fa_im $nb_3 >$pair_read_5.gene_gap_out.fa 
echo END>> $pair_read_5.gene_gap_out.fa 
echo nice -n 19 fastacmd -d "$ref_file" -p F -s "$chro" -L "`expr $st '-' $nb_4`"','"`expr $en '+' $nb_4`">check.txt
chmod 777 check.txt
z=cat check.txt > $pair_read_7.gene_gap_out.fa_im
python 13d.py $pair_read_7.gene_gap_out.fa_im $nb_4 >$pair_read_7.gene_gap_out.fa 
echo END>> $pair_read_7.gene_gap_out.fa 



st=`expr 10000000000 '*' $st`
st=`expr $st '+' $count`
count=`expr $count '+' 1`
echo $st >>rep_region
### making sure that no other N region in to +/- 10 Kb
nice -n 19 python 13e.py $pair_read_1.gene_gap_out.fa $nb_1 $st>> $pair_read_1.Nfil_gene_gap_out.fa
nice -n 19 python 13e.py $pair_read_3.gene_gap_out.fa $nb_2 $st>> $pair_read_3.Nfil_gene_gap_out.fa
nice -n 19 python 13e.py $pair_read_5.gene_gap_out.fa $nb_3 $st>> $pair_read_5.Nfil_gene_gap_out.fa
nice -n 19 python 13e.py $pair_read_7.gene_gap_out.fa $nb_4 $st>> $pair_read_7.Nfil_gene_gap_out.fa

done <input_file ###running for fraction of gaps

>input_file

### doing mapping on genome using bwa
### index the genome

bowtie-build $pair_read_1.Nfil_gene_gap_out.fa $pair_read_1.Nfil_gene_gap_out.fa 
bowtie-build $pair_read_3.Nfil_gene_gap_out.fa $pair_read_3.Nfil_gene_gap_out.fa 
bowtie-build $pair_read_5.Nfil_gene_gap_out.fa $pair_read_5.Nfil_gene_gap_out.fa 
bowtie-build $pair_read_7.Nfil_gene_gap_out.fa $pair_read_7.Nfil_gene_gap_out.fa 
### align the reads

nice -n 19 bowtie -q --solexa1.3-quals --seedmms 0 --maqerr 30 --seedlen 28 -k 1 --time --offbase 0 --sam $pair_read_1.Nfil_gene_gap_out.fa "$rep_dir"$pair_read_1 | nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' >$pair_read_1.sam.im
nice -n 19 bowtie -q --solexa1.3-quals --seedmms 0 --maqerr 30 --seedlen 28 -k 1 --time --offbase 0 --sam $pair_read_1.Nfil_gene_gap_out.fa "$rep_dir"$pair_read_2 | nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' >$pair_read_2.sam.im
nice -n 19 bowtie -q --solexa1.3-quals --seedmms 0 --maqerr 30 --seedlen 28 -k 1 --time --offbase 0 --sam $pair_read_3.Nfil_gene_gap_out.fa "$rep_dir"$pair_read_3 | nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' >$pair_read_3.sam.im
nice -n 19 bowtie -q --solexa1.3-quals --seedmms 0 --maqerr 30 --seedlen 28 -k 1 --time --offbase 0 --sam $pair_read_3.Nfil_gene_gap_out.fa "$rep_dir"$pair_read_4 | nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' >$pair_read_4.sam.im
nice -n 19 bowtie -q --solexa1.3-quals --seedmms 0 --maqerr 30 --seedlen 28 -k 1 --time --offbase 0 --sam $pair_read_5.Nfil_gene_gap_out.fa "$rep_dir"$pair_read_5 | nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' >$pair_read_5.sam.im
nice -n 19 bowtie -q --solexa1.3-quals --seedmms 0 --maqerr 30 --seedlen 28 -k 1 --time --offbase 0 --sam $pair_read_5.Nfil_gene_gap_out.fa "$rep_dir"$pair_read_6 | nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' >$pair_read_6.sam.im
nice -n 19 bowtie -q --solexa1.3-quals --seedmms 0 --maqerr 30 --seedlen 28 -k 1 --time --offbase 0 --sam $pair_read_7.Nfil_gene_gap_out.fa "$rep_dir"$pair_read_7 | nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' >$pair_read_7.sam.im
nice -n 19 bowtie -q --solexa1.3-quals --seedmms 0 --maqerr 30 --seedlen 28 -k 1 --time --offbase 0 --sam $pair_read_7.Nfil_gene_gap_out.fa "$rep_dir"$pair_read_8 | nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' >$pair_read_8.sam.im


### single end mapping
nice -n 19 python 13f.py $pair_read_1.sam.im $pair_read_2.sam.im $nb_1 F >out.txt
nice -n 19 python 13g.py out.txt >$pair_read_1.sam
nice -n 19 python 13f.py $pair_read_3.sam.im $pair_read_4.sam.im $nb_2 F >out.txt
nice -n 19 python 13g.py out.txt >$pair_read_3.sam
nice -n 19 python 13f.py $pair_read_5.sam.im $pair_read_6.sam.im $nb_3 T >out.txt
nice -n 19 python 13g.py out.txt >$pair_read_5.sam
nice -n 19 python 13f.py $pair_read_7.sam.im $pair_read_8.sam.im $nb_4 T >out.txt
nice -n 19 python 13g.py out.txt >$pair_read_7.sam



### taking out sequences where only one read of pair is mapped
x=1
while [ $x -lt 4 ]
do 

nice -n 19 python 13h.py $pair_read_1.sam "$rep_dir"$pair_read_1 $pair_read_1.fil.sam $nb_1 F $pair_read_1.unmapped.unique "$x"> $pair_read_1.unmapped
nice -n 19 python 13h.py $pair_read_1.sam "$rep_dir"$pair_read_2 $pair_read_2.fil.sam $nb_1 F $pair_read_2.unmapped.unique "$x"> $pair_read_2.unmapped
nice -n 19 python 13h.py $pair_read_3.sam "$rep_dir"$pair_read_3 $pair_read_3.fil.sam $nb_2 F $pair_read_3.unmapped.unique "$x"> $pair_read_3.unmapped
nice -n 19 python 13h.py $pair_read_3.sam "$rep_dir"$pair_read_4 $pair_read_4.fil.sam $nb_2 F $pair_read_4.unmapped.unique "$x"> $pair_read_4.unmapped
nice -n 19 python 13h.py $pair_read_5.sam "$rep_dir"$pair_read_5 $pair_read_5.fil.sam $nb_3 T $pair_read_5.unmapped.unique "$x"> $pair_read_5.unmapped
nice -n 19 python 13h.py $pair_read_5.sam "$rep_dir"$pair_read_6 $pair_read_6.fil.sam $nb_3 T $pair_read_6.unmapped.unique "$x"> $pair_read_6.unmapped
nice -n 19 python 13h.py $pair_read_7.sam "$rep_dir"$pair_read_7 $pair_read_7.fil.sam $nb_4 T $pair_read_7.unmapped.unique "$x"> $pair_read_7.unmapped
nice -n 19 python 13h.py $pair_read_7.sam "$rep_dir"$pair_read_8 $pair_read_8.fil.sam $nb_4 T $pair_read_8.unmapped.unique "$x"> $pair_read_8.unmapped
### merged all single reads hanging together
cat $pair_read_1.unmapped.unique $pair_read_2.unmapped.unique $pair_read_3.unmapped.unique $pair_read_4.unmapped.unique $pair_read_5.unmapped.unique $pair_read_6.unmapped.unique $pair_read_7.unmapped.unique $pair_read_8.unmapped.unique>$pair_read_1.unmapped.fq.unique_all

echo "number of unmapped read before inserting rep element"
wc -l $pair_read_1.unmapped.fq.unique_all >>unmapped_reads

### Using combined unmapped file to find best repetitive element

### mapping unmapped reads on rep elements
### 1. Index the rep elements
nice -n 19 bowtie-build $rep_file $rep_file

### align read
### single end mapping
nice -n 19 bowtie -q --solexa1.3-quals --seedmms 0 --maqerr 30 --seedlen 28 -k 1 --time --offbase 0 --sam $rep_file $pair_read_1.unmapped.fq.unique_all | nice -n 19 perl -lane 'print $_ if ($F[3] > 0)' >$pair_read_1.unmapped.fq.unique_all_rep_aln.sam
cat $pair_read_1.unmapped.fq.unique_all_rep_aln.sam| nice -n 19 perl -lane 'print $_ if ($F[1] == 0)'|sort|cut -f 1,3,4  >check.txt
echo END >>check.txt
strand=0
nice -n 19 python 13i.py check.txt out.txt $rep_file $x $strand
nice -n 19 python 13j.py out.txt rep_region >direct_rep.$x
echo END >>direct_rep.$x
### for reverse strand
cat $pair_read_1.unmapped.fq.unique_all_rep_aln.sam| nice -n 19 perl -lane 'print $_ if ($F[1] == 16)'|sort|cut -f 1,3,4  >check.txt
echo END >>check.txt
strand=16
nice -n 19 python 13i.py check.txt out.txt $rep_file $x $strand
nice -n 19 python 13j.py out.txt rep_region >reverse_rep.$x
echo END >>reverse_rep.$x

###find best orientation 
python 13l.py direct_rep.$x reverse_rep.$x > "$dat"_summary.txt.$x
python 13m.py $input "$dat"_summary.txt.$x > corect_count.txt.$x

x=`expr $x '+' 1`
done ### for x

fi

done <$input ### for input file


### summarizing output
nice -n 19 python 13k.py rep_pos "$dat"_summary.txt.1 "$dat"_summary.txt.2 "$dat"_summary.txt.3 >summary_"$dat""$input"



