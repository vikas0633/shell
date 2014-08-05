### Data directory
# on genome cluster: /home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/RogerMoraga

for file in *.fastq.gz
do
echo $file
gunzip -d $file
done


### check fastq files
source /com/extra/FastQC/0.10.1/load.sh
fastqc *.fastq

================================================================================================
### check the fasta files
source /com/extra/genometools/1.4.1/load.sh
for file in *.fasta
do
echo $file
gt seqstat -contigs -v $file
done

### genome assembly
final_pallescens.fasta
# number of contigs:     6925
# total contigs length:  391487818
# mean contig size:      56532.54
# median contig size:    14868
# longest contig:        5193466
# shortest contig:       909
# contigs > 500 nt:      6925 (100.00 %)
# contigs > 1K nt:       6903 (99.68 %)
# contigs > 10K nt:      3862 (55.77 %)
# contigs > 100K nt:     1135 (16.39 %)
# contigs > 1M nt:       10 (0.14 %)
# N50:                   178889
# L50:                   563
# N80:                   66502
# L80:                   1647


### transcripts assembly
F1_consensus.fasta
# number of contigs:     341550
# total contigs length:  521420401
# mean contig size:      1526.63
# median contig size:    1269
# longest contig:        14586
# shortest contig:       100
# contigs > 500 nt:      271019 (79.35 %)
# contigs > 1K nt:       202965 (59.42 %)
# contigs > 10K nt:      137 (0.04 %)
# contigs > 100K nt:     0 (0.00 %)
# contigs > 1M nt:       0 (0.00 %)
# N50:                   2182
# L50:                   80884
# N80:                   1240
# L80:                   174154

L4_consensus.fasta
# number of contigs:     209856
# total contigs length:  317953542
# mean contig size:      1515.10
# median contig size:    1294
# longest contig:        11543
# shortest contig:       100
# contigs > 500 nt:      170136 (81.07 %)
# contigs > 1K nt:       127875 (60.93 %)
# contigs > 10K nt:      5 (0.00 %)
# contigs > 100K nt:     0 (0.00 %)
# contigs > 1M nt:       0 (0.00 %)
# N50:                   2129
# L50:                   52105
# N80:                   1227
# L80:                   110091

root_consensus.fasta
# number of contigs:     225106
# total contigs length:  317910125
# mean contig size:      1412.27
# median contig size:    1176
# longest contig:        24774
# shortest contig:       100
# contigs > 500 nt:      175682 (78.04 %)
# contigs > 1K nt:       126916 (56.38 %)
# contigs > 10K nt:      40 (0.02 %)
# contigs > 100K nt:     0 (0.00 %)
# contigs > 1M nt:       0 (0.00 %)
# N50:                   2029
# L50:                   54245
# N80:                   1140
# L80:                   115459

stolon_consensus.fasta
# number of contigs:     260133
# total contigs length:  381757819
# mean contig size:      1467.55
# median contig size:    1240
# longest contig:        10428
# shortest contig:       102
# contigs > 500 nt:      230526 (88.62 %)
# contigs > 1K nt:       158496 (60.93 %)
# contigs > 10K nt:      4 (0.00 %)
# contigs > 100K nt:     0 (0.00 %)
# contigs > 1M nt:       0 (0.00 %)
# N50:                   1888
# L50:                   69399
# N80:                   1085
# L80:                   148193

================================================================================================

Running CD hit on the transcripts
================================================================================================
# throw out all the transcripts smaller than 300 bp
dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/02_CDhit"
cd $dir
python ~/script/python/21p_filter_fasta.py -i $dir/F1_consensus.fasta -l 300 > 01_F1_consensus.fasta
python ~/script/python/21p_filter_fasta.py -i $dir/L4_consensus.fasta -l 300 > 02_L4_consensus.fasta
python ~/script/python/21p_filter_fasta.py -i $dir/root_consensus.fasta -l 300 > 03_root_consensus.fasta
python ~/script/python/21p_filter_fasta.py -i $dir/stolon_consensus.fasta -l 300 > 04_stolon_consensus.fasta

# create consensus fasta file for each sample
dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/02_CDhit"
cd $dir
cores=14
memory=40000
for f in 0*.fasta ;  
do 
file=$dir"/"$f
qx -q normal -n 1 -c 16 -v "/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/02_cdhit/cd-hit-v4.5.4-2011-03-07/cd-hit-est -i $file -o $file.cdout -T $cores -c 0.9 -G 1 -M $memory -l 300 > $file.log 2>&1" | qsub -N $f."cdhit"; 
done

### summarize the cdhit output
source /com/extra/genometools/1.4.1/load.sh
file="02_L4_consensus.fasta.cdout"
gt seqstat -contigs -v $file
# number of contigs:     63951
# total contigs length:  111461944
# mean contig size:      1742.93
# median contig size:    1534
# longest contig:        11543
# shortest contig:       301
# contigs > 500 nt:      57261 (89.54 %)
# contigs > 1K nt:       44575 (69.70 %)
# contigs > 10K nt:      5 (0.01 %)
# contigs > 100K nt:     0 (0.00 %)
# contigs > 1M nt:       0 (0.00 %)
# N50:                   2274
# L50:                   17256
# N80:                   1362
# L80:                   35950

file="03_root_consensus.fasta.cdout"
gt seqstat -contigs -v $file
# number of contigs:     70304
# total contigs length:  113741844
# mean contig size:      1617.86
# median contig size:    1398
# longest contig:        24774
# shortest contig:       301
# contigs > 500 nt:      61107 (86.92 %)
# contigs > 1K nt:       45238 (64.35 %)
# contigs > 10K nt:      16 (0.02 %)
# contigs > 100K nt:     0 (0.00 %)
# contigs > 1M nt:       0 (0.00 %)
# N50:                   2157
# L50:                   18376
# N80:                   1253
# L80:                   38654

file="04_stolon_consensus.fasta.cdout"
gt seqstat -contigs -v $file
# number of contigs:     101377
# total contigs length:  152467341
# mean contig size:      1503.96
# median contig size:    1274
# longest contig:        10428
# shortest contig:       301
# contigs > 500 nt:      88828 (87.62 %)
# contigs > 1K nt:       62736 (61.88 %)
# contigs > 10K nt:      2 (0.00 %)
# contigs > 100K nt:     0 (0.00 %)
# contigs > 1M nt:       0 (0.00 %)
# N50:                   1966
# L50:                   26770
# N80:                   1125
# L80:                   57016

####################################
### RUNNING GABox - clover-v0.12 ###
####################################
mkdir 12_pallescens
bash 28_select_files.sh


