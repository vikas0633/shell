### Data directory

### RNA-seq data
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/20140211_CloverRNAseq_Tr

### Run CDhit
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/02_CDhit
qsub 20140812_CDhit.sh

### Map RNA-seq against combined genome of occi and palle
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome
awk '{if ($0 ~/>/) {gsub(/scaffold/,"Occidentale_scaffold");print $0;} else print $0;}' /home/vgupta/LotusGenome/01_vgupta/11_clover/01_data/AllPaths/occidentale/final.assembly.fa > occi.final.assembly.fa
awk '{if ($0 ~/>/) {gsub(/scaffold/,"Pallescens_scaffold");print $0;} else print $0;}' /home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/01_RogerMoraga/final_pallescens.fa > palle.final.assembly.fa

cat occi.final.assembly.fa palle.final.assembly.fa > occi_palle.final.assembly.fa
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle
qsub 20140815_mapRepensOnCombinedOcciAndPalle.sh

### take out the uniquely mapped reads
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat
sbatch 20140825_ExtractUniqueReads.sh

######################################################
### count the genes expressed unique to occidentale###
######################################################
## convert GFF3 to GTF
python ~/script/python/21e_gff2gtf.py ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.gff3 > ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.gtf

## replace scaffolds name
awk '{if ($0 ~/>/) print $0; else {gsub(/scaffold/,"Occidentale_scaffold");print $0;}}' ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.gtf > ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.comb.gtf

## count reads on occidentale only with one mapping
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat
BAM="accepted_hits.bam.uniq.bam.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 2 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.bam.sorted.bam.counts.values occi.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi.uniq.gene.readcounts 
awk $2>10 occi.uniq.gene.readcounts | wc -l
## with pair-ends
featureCounts -p -T 1 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.bam.sorted.bam.counts.values occi.uniq.gene.readpaircounts 
awk '{sum+=$2} END {print sum}' occi.uniq.gene.readpaircounts 

## count reads on occidentale only with all mappings
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 2 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values occi.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi.all.gene.readcounts 
awk '$2>0' occi.all.gene.readcounts | wc -l
awk '$2>10' occi.all.gene.readcounts | wc -l

## count reads on pallescens
python ~/script/python/21e_gff2gtf.py ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.gff3 > ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.gtf
## replace scaffolds name
awk '{if ($0 ~/>/) print $0; else {gsub(/scaffold/,"Pallescens_scaffold");print $0;}}' ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.gtf > ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.comb.gtf
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat
BAM="accepted_hits.bam.uniq.bam.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 2 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.bam.sorted.bam.counts.values palle.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.uniq.gene.readcounts 
awk '$2>10' palle.uniq.gene.readcounts | wc -l
awk '$2>0' palle.uniq.gene.readcounts | wc -l

## count reads on occidentale only with all mappings
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 2 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values palle.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.all.gene.readcounts 
awk '$2>0' palle.all.gene.readcounts | wc -l
awk '$2>10' palle.all.gene.readcounts | wc -l


### count reads on merged transciptome
cat /home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.comb.gtf \
/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.comb.gtf \
> occi_pallescens.comb.gtf 
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat
BAM="accepted_hits.bam.uniq.bam.sorted.bam"
GTF="occi_pallescens.comb.gtf "
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 2 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.bam.sorted.bam.counts.values occi_palle.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi_palle.uniq.gene.readcounts 
awk '$2>10' occi_palle.uniq.gene.readcounts | wc -l
awk '$2>0' occi_palle.uniq.gene.readcounts | wc -l

cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat
BAM="accepted_hits.bam"
GTF="occi_pallescens.comb.gtf "
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 2 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values palle.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.all.gene.readcounts 
awk '$2>0' palle.all.gene.readcounts | wc -l
awk '$2>10' palle.all.gene.readcounts | wc -l

###################################################################################
############################ Floral tissue ########################################
###################################################################################
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/02_TRfloral/tophat
source /com/extra/samtools/0.1.19/load.sh
### take out the uniquely mapped reads
work_dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/02_TRfloral/tophat"
cd $work_dir
### bam_file
bam="accepted_hits.bam"
### extract uniquely mapped reads
samtools view -h $work_dir/$bam | grep  "^@" > $work_dir/accepted_hits.unique.sam
samtools view $work_dir/accepted_hits.bam | grep -w "NH:i:1" >> $work_dir/accepted_hits.unique.sam
samtools view -Shb $work_dir/accepted_hits.unique.sam | samtools sort - $work_dir/$bam".uniq.sorted."
rm accepted_hits.unique.sam

## count reads on occidentale only with one mapping
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/02_TRfloral/tophat
BAM="accepted_hits.bam.uniq.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.sorted.bam.counts.values occi.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi.uniq.gene.readcounts 
awk '$2>0' occi.uniq.gene.readcounts | wc -l
awk '$2>10' occi.uniq.gene.readcounts | wc -l

## count reads on occidentale only with all mappings
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/02_TRfloral/tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values occi.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi.all.gene.readcounts 
awk '$2>0' occi.all.gene.readcounts | wc -l
awk '$2>10' occi.all.gene.readcounts | wc -l

## count reads on pallescens
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/02_TRfloral/tophat
BAM="accepted_hits.bam.uniq.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.sorted.bam.counts.values palle.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.uniq.gene.readcounts 
awk '$2>0' palle.uniq.gene.readcounts | wc -l
awk '$2>10' palle.uniq.gene.readcounts | wc -l


## count reads on occidentale only with all mappings
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/02_TRfloral/tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values palle.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.all.gene.readcounts 
awk '$2>0' palle.all.gene.readcounts | wc -l
awk '$2>10' palle.all.gene.readcounts | wc -l


### count reads on merged transciptome
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/02_TRfloral/tophat
BAM="accepted_hits.bam.uniq.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat/occi_pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.sorted.bam.counts.values occi_palle.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi_palle.uniq.gene.readcounts 
awk '$2>10' occi_palle.uniq.gene.readcounts | wc -l
awk '$2>0' occi_palle.uniq.gene.readcounts | wc -l

cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/02_TRfloral/tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat/occi_pallescens.comb.gtf "
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values palle.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.all.gene.readcounts 
awk '$2>0' palle.all.gene.readcounts | wc -l
awk '$2>10' palle.all.gene.readcounts | wc -l

#########################################################
#################### Root tissue ########################
#########################################################
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/03_TRroot/tophat
source /com/extra/samtools/0.1.19/load.sh
### take out the uniquely mapped reads
work_dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/03_TRroot/tophat"
cd $work_dir
### bam_file
bam="accepted_hits.bam"
### extract uniquely mapped reads
samtools view -h $work_dir/$bam | grep  "^@" > $work_dir/accepted_hits.unique.sam
samtools view $work_dir/accepted_hits.bam | grep -w "NH:i:1" >> $work_dir/accepted_hits.unique.sam
samtools view -Shb $work_dir/accepted_hits.unique.sam | samtools sort - $work_dir/$bam".uniq.sorted"
rm accepted_hits.unique.sam


## count reads on occidentale only with one mapping
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/03_TRroot/tophat
BAM="accepted_hits.bam.uniq.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.sorted.bam.counts.values occi.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi.uniq.gene.readcounts 
awk '$2>0' occi.uniq.gene.readcounts | wc -l
awk '$2>10' occi.uniq.gene.readcounts | wc -l

## count reads on occidentale only with all mappings
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/03_TRroot/tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values occi.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi.all.gene.readcounts 
awk '$2>0' occi.all.gene.readcounts | wc -l
awk '$2>10' occi.all.gene.readcounts | wc -l

## count reads on pallescens
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/03_TRroot/tophat
BAM="accepted_hits.bam.uniq.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.sorted.bam.counts.values palle.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.uniq.gene.readcounts 
awk '$2>0' palle.uniq.gene.readcounts | wc -l
awk '$2>10' palle.uniq.gene.readcounts | wc -l


## count reads on occidentale only with all mappings
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/03_TRroot/tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values palle.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.all.gene.readcounts 
awk '$2>0' palle.all.gene.readcounts | wc -l
awk '$2>10' palle.all.gene.readcounts | wc -l


### count reads on merged transciptome
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/03_TRroot/tophat
BAM="accepted_hits.bam.uniq.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat/occi_pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.sorted.bam.counts.values occi_palle.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi_palle.uniq.gene.readcounts 
awk '$2>10' occi_palle.uniq.gene.readcounts | wc -l
awk '$2>0' occi_palle.uniq.gene.readcounts | wc -l

cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/03_TRroot/tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat/occi_pallescens.comb.gtf "
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values palle.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.all.gene.readcounts 
awk '$2>0' palle.all.gene.readcounts | wc -l
awk '$2>10' palle.all.gene.readcounts | wc -l

#########################################################
#################### TRLeaf tissue ######################
#########################################################

cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/04_TRleaf/tophat
source /com/extra/samtools/0.1.19/load.sh
### take out the uniquely mapped reads
work_dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/04_TRleaf/tophat"
cd $work_dir
### bam_file
bam="accepted_hits.bam"
### extract uniquely mapped reads
samtools view -h $work_dir/$bam | grep  "^@" > $work_dir/accepted_hits.unique.sam
samtools view $work_dir/accepted_hits.bam | grep -w "NH:i:1" >> $work_dir/accepted_hits.unique.sam
samtools view -Shb $work_dir/accepted_hits.unique.sam | samtools sort - $work_dir/$bam".uniq.sorted"
rm accepted_hits.unique.sam

## count reads on occidentale only with one mapping
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/04_TRleaf/tophat
BAM="accepted_hits.bam.uniq.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.sorted.bam.counts.values occi.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi.uniq.gene.readcounts 
awk '$2>0' occi.uniq.gene.readcounts | wc -l
awk '$2>10' occi.uniq.gene.readcounts | wc -l

## count reads on occidentale only with all mappings
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/04_TRleaf/tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values occi.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi.all.gene.readcounts 
awk '$2>0' occi.all.gene.readcounts | wc -l
awk '$2>10' occi.all.gene.readcounts | wc -l

## count reads on pallescens
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/04_TRleaf/tophat
BAM="accepted_hits.bam.uniq.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.sorted.bam.counts.values palle.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.uniq.gene.readcounts 
awk '$2>0' palle.uniq.gene.readcounts | wc -l
awk '$2>10' palle.uniq.gene.readcounts | wc -l


## count reads on occidentale only with all mappings
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/04_TRleaf/tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values palle.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.all.gene.readcounts 
awk '$2>0' palle.all.gene.readcounts | wc -l
awk '$2>10' palle.all.gene.readcounts | wc -l


### count reads on merged transciptome
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/04_TRleaf/tophat
BAM="accepted_hits.bam.uniq.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat/occi_pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.sorted.bam.counts.values occi_palle.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi_palle.uniq.gene.readcounts 
awk '$2>10' occi_palle.uniq.gene.readcounts | wc -l
awk '$2>0' occi_palle.uniq.gene.readcounts | wc -l

cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/04_TRleaf/tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat/occi_pallescens.comb.gtf "
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values palle.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.all.gene.readcounts 
awk '$2>0' palle.all.gene.readcounts | wc -l
awk '$2>10' palle.all.gene.readcounts | wc -l

#########################################################
#################### TRStolen tissue ####################
#########################################################

cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/05_TRstolon/tophat
source /com/extra/samtools/0.1.19/load.sh
### take out the uniquely mapped reads
work_dir="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/05_TRstolon/tophat"
cd $work_dir
### bam_file
bam="accepted_hits.bam"
### extract uniquely mapped reads
samtools view -h $work_dir/$bam | grep  "^@" > $work_dir/accepted_hits.unique.sam
samtools view $work_dir/accepted_hits.bam | grep -w "NH:i:1" >> $work_dir/accepted_hits.unique.sam
samtools view -Shb $work_dir/accepted_hits.unique.sam | samtools sort - $work_dir/$bam".uniq.sorted"
rm accepted_hits.unique.sam


## count reads on occidentale only with one mapping
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/05_TRstolon/tophat
BAM="accepted_hits.bam.uniq.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.sorted.bam.counts.values occi.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi.uniq.gene.readcounts 
awk '$2>0' occi.uniq.gene.readcounts | wc -l
awk '$2>10' occi.uniq.gene.readcounts | wc -l

## count reads on occidentale only with all mappings
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/05_TRstolon/tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values occi.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi.all.gene.readcounts 
awk '$2>0' occi.all.gene.readcounts | wc -l
awk '$2>10' occi.all.gene.readcounts | wc -l

## count reads on pallescens
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/05_TRstolon/tophat
BAM="accepted_hits.bam.uniq.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.sorted.bam.counts.values palle.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.uniq.gene.readcounts 
awk '$2>0' palle.uniq.gene.readcounts | wc -l
awk '$2>10' palle.uniq.gene.readcounts | wc -l


## count reads on occidentale only with all mappings
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/05_TRstolon/tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values palle.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.all.gene.readcounts 
awk '$2>0' palle.all.gene.readcounts | wc -l
awk '$2>10' palle.all.gene.readcounts | wc -l


### count reads on merged transciptome
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/05_TRstolon/tophat
BAM="accepted_hits.bam.uniq.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat/occi_pallescens.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.sorted.bam.counts.values occi_palle.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi_palle.uniq.gene.readcounts 
awk '$2>10' occi_palle.uniq.gene.readcounts | wc -l
awk '$2>0' occi_palle.uniq.gene.readcounts | wc -l

cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/05_TRstolon/tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat/occi_pallescens.comb.gtf "
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values palle.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.all.gene.readcounts 
awk '$2>0' palle.all.gene.readcounts | wc -l
awk '$2>10' palle.all.gene.readcounts | wc -l



########################################################################
#### Make a 1-to-1 correspondance table for occi and palle proteins ####
########################################################################

### Extract only protein coding sequences
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/05_blast_corre_table/02_protein_coding
awk '{if ($0 ~/>/) print $0; else {gsub(/clover_/,"occidentale_");print $0;}}' ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/clover.gff3 > ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.gff3
awk '$2=="protein_coding"' ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.gff3 > ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.gff3
awk '{if ($0 ~/>/) print $0; else {gsub(/scaffold/,"Occidentale_scaffold");print $0;}}' ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.gff3 > ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gff3
awk '$2=="protein_coding"' ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.gff3 > ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.gff3
awk '{if ($0 ~/>/) print $0; else {gsub(/scaffold/,"Pallescens_scaffold");print $0;}}' ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.gff3 > ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gff3


awk '$3=="gene"' ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gff3 | cut -d ';' -f 1 | cut -d '=' -f 2 > occi.pc.genes

awk '{ gsub(/clover_/,"occidentale_");print $0;}' ../01_AllGenes/occi.protein.fa >  ../01_AllGenes/occi.protein.rep.fa
python ~/script/python/137_takeout_longest_isoform.py -i ../01_AllGenes/occi.protein.rep.fa > occi.longest_isoform.fa
python ~/script/python/21d_take_out_gene_list_headers.py occi.longest_isoform.fa occi.pc.genes > occi.pc.genes.fa

awk '$3=="gene"' ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gff3 | cut -d ';' -f 1 | cut -d '=' -f 2 > palle.pc.genes
python ~/script/python/137_takeout_longest_isoform.py -i ../01_AllGenes/pallescens.protein.fa > pallescens.longest_isoform.fa
python ~/script/python/21d_take_out_gene_list_headers.py pallescens.longest_isoform.fa palle.pc.genes > palle.pc.genes.fa

cd /home/vgupta/LotusGenome/01_vgupta/11_clover/05_blast_corre_table/02_protein_coding

source /com/extra/BLAST/2.2.26/load.sh
source /com/extra/BLASTALL/2.2.26/load.sh
QUERY="occi.pc.genes.fa"
DATABASE="/home/vgupta/LotusGenome/01_vgupta/11_clover/05_blast_corre_table/02_protein_coding/palle.pc.genes.fa"
FILE_DIR="/home/vgupta/LotusGenome/01_vgupta/11_clover/05_blast_corre_table/02_protein_coding"
BLAST_OUT="/home/vgupta/LotusGenome/01_vgupta/11_clover/05_blast_corre_table/02_protein_coding/01_blastout"
mkdir -p $BLAST_OUT
nice -n 19 formatdb -i $DATABASE -p T -o T
nice -n 19 perl ~/script/perl/fasta_splitter.pl -n-parts-sequence 100 $QUERY
qx -v --nodes=10 --dir=. -i "*.part-*.fa" -o "*.txt" -i 20140901_blast.sh dispatch -r 20140901_blast.sh > jobscript.sh
for f in *.part-*.fa; do echo "nice -n 19 blastp  -max_target_seqs=20 -num_threads=8 -db $DATABASE -query $f -outfmt 6 -out $f.txt"; done > 20140901_blast.sh 
sbatch jobscript.sh
mv occi.protein.part-*.fa.txt 01_blastout/
## replace scaffolds name
python ~/script/python/136_blast2reciprocal.py -i 20140901_occi_palle_blastp.txt > 20140901_occi_palle_blastp.reciprocal.txt

### make the reciprocal table with expression tables
## unique reads

all_occi="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat/occi.uniq.gene.readcounts"
all_palle="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat/palle.uniq.gene.readcounts"

floral_occi="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/02_TRfloral/tophat/occi.uniq.gene.readcounts"
floral_palle="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/02_TRfloral/tophat/palle.uniq.gene.readcounts"

root_occi="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/03_TRroot/tophat/occi.uniq.gene.readcounts"
root_palle="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/03_TRroot/tophat/palle.uniq.gene.readcounts"

stolon_occi="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/05_TRstolon/tophat/occi.uniq.gene.readcounts"
stolon_palle="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/05_TRstolon/tophat/palle.uniq.gene.readcounts"

paste $all_occi $floral_occi $root_occi $stolon_occi > 20140905_UniqCounts_occi.txt
paste $all_palle $floral_palle $root_palle $stolon_palle > 20140905_UniqCounts_palle.txt

### append expression to reciprocals


## total reads
all_occi="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat/occi.all.gene.readcounts"
all_palle="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat/palle.all.gene.readcounts"

floral_occi="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/02_TRfloral/tophat/occi.all.gene.readcounts"
floral_palle="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/02_TRfloral/tophat/palle.all.gene.readcounts"

root_occi="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/03_TRroot/tophat/occi.all.gene.readcounts"
root_palle="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/03_TRroot/tophat/palle.all.gene.readcounts"

leaf_occi="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/04_TRleaf/tophat/occi.all.gene.readcounts"
leaf_palle="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/04_TRleaf/tophat/palle.all.gene.readcounts"

stolon_occi="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/05_TRstolon/tophat/occi.all.gene.readcounts"
stolon_palle="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/05_TRstolon/tophat/palle.all.gene.readcounts"

paste $all_occi $floral_occi $root_occi $root_leaf $stolon_occi > 20140905_AllCounts_occi.txt
paste $all_palle $floral_palle $root_palle $root_leaf $stolon_palle > 20140905_AllCounts_palle.txt


########################################################################
############## map denovo assembled repens transcripts #################
########################################################################

cd /array/users/vgupta/11_clover/20140812_clover_repens/02_CDhit
genome="occi_palle.final.assembly.fa"
genome_name="occi_palle.final.assembly"

## fix the headers
file="Merge_CDhit_assemblies.cdout"
awk '{if ($0 ~/>/) {gsub(/Cluster /,"Cluster_"); print $0} else print $0;}' $file > $file.fa

file="Merge_CDhit_assemblies.cdout.fa"
intron_size=30000
cores=4
nice -n 19 gmap_build -D ~/gmap_databases -d $genome_name $genome
nohup nice -n 19 gmap -D ~/gmap_databases -d $genome_name --intronlength=$intron_size -t $cores --format=2 $file > $file".gmap.gff3" 2>nohup.out &


### sort GFF3 file
nice -n 19 python ~/scripts/103_sort_gff_blocks.py -i $file".gmap.gff3" > $file".gmap.gff3.sorted"
### find fragmented genemodels
nice -n 19 python ~/scripts/21bg_find_fragmented_genemodels.py -i $file".gmap.gff3.sorted" -t $cores
### remove fragemented genes
nice -n 19 python ~/scripts/106_filter_out_genelist.py -i $file".gmap.gff3" -f GFF3 -g $file".gmap.gff3.sorted.frags" > $file".gff3"

