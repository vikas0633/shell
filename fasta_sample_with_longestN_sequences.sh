#!/bin/bash



### Make Fasta sample with two sequences
FILE=""
SeqCount=""
ScriptDir="~/script/python"


### make empty file
touch sample.fa

### get the longest N sequences
seqs=`python $ScriptDir/21h_calculate_seq_len.py -i $FILE | cut -d ' ' -f 1 | head -n $SeqCount | cut -f 1 `
export IFS=" "

for s in $seq; 
do
  echo s
done
python "$ScriptDir"/21h_calculate_seq_len.py -i $FILE | head -n $SeqCount | cut -f 1 | python "$ScriptDir"/21d_take_out_gene.py -n $0 -f $FILE >> sample.fa
