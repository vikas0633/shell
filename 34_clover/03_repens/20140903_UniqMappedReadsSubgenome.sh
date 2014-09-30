######################################################
### count the genes expressed unique to subgenomes ###
######################################################
## Take out protein coding genes and convert GFF3 to GTF
awk '$2=="protein_coding"' ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.gff3 > ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.gff3 
python ~/script/python/21e_gff2gtf.py ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.gff3 > ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.gtf
## replace scaffolds name
awk '{if ($0 ~/>/) print $0; else {gsub(/scaffold/,"Occidentale_scaffold");print $0;}}' ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.gtf > ~/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gtf

awk '$2=="protein_coding"' ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.gff3 > ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.gff3
python ~/script/python/21e_gff2gtf.py ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.gff3 > ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.gtf
## replace scaffolds name
awk '{if ($0 ~/>/) print $0; else {gsub(/scaffold/,"Pallescens_scaffold");print $0;}}' ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.gtf > ~/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gtf

## count reads on occidentale only with one mapping
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat
BAM="accepted_hits.bam.uniq.bam.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.bam.sorted.bam.counts.values occi.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi.uniq.gene.readcounts 
awk '$2>0' occi.uniq.gene.readcounts | wc -l
awk '$2>10' occi.uniq.gene.readcounts | wc -l


## count reads on occidentale only with all mappings
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values occi.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi.all.gene.readcounts 
awk '$2>0' occi.all.gene.readcounts | wc -l
awk '$2>10' occi.all.gene.readcounts | wc -l


## count reads on pallescens
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat
BAM="accepted_hits.bam.uniq.bam.sorted.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.bam.sorted.bam.counts.values palle.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.uniq.gene.readcounts 
awk '$2>0' palle.uniq.gene.readcounts | wc -l
awk '$2>10' palle.uniq.gene.readcounts | wc -l


## count reads on occidentale only with all mappings
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat
BAM="accepted_hits.bam"
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gtf"
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 6 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.counts.values palle.all.gene.readcounts 
awk '{sum+=$2} END {print sum}' palle.all.gene.readcounts 
awk '$2>0' palle.all.gene.readcounts | wc -l
awk '$2>10' palle.all.gene.readcounts | wc -l


### count reads on merged transciptome
cat /home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gtf \
/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gtf \
> occi_pallescens.pc.comb.gtf 
cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat
BAM="accepted_hits.bam.uniq.bam.sorted.bam"
GTF="occi_pallescens.pc.comb.gtf "
#featureCounts -T 1 -O -M -a $GTF -t exon -g transcript_id -o $BAM.counts $BAM
featureCounts -T 2 -O -M -a $GTF -t exon -g gene_id -o $BAM.counts $BAM
grep -v '^#' $BAM.counts | cut -f 1,7 > $BAM.counts.values
mv accepted_hits.bam.uniq.bam.sorted.bam.counts.values occi_palle.uniq.gene.readcounts 
awk '{sum+=$2} END {print sum}' occi_palle.uniq.gene.readcounts 
awk '$2>10' occi_palle.uniq.gene.readcounts | wc -l
awk '$2>0' occi_palle.uniq.gene.readcounts | wc -l

cd /home/vgupta/LotusGenome/01_vgupta/11_clover/20140812_clover_repens/04_mapping_on_occi_palle/01_merged_genome/01_merged_genome_all_tissues_tophat
BAM="accepted_hits.bam"
GTF="occi_pallescens.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/201406_occidantale/occi.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gtf"
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
GTF="/home/vgupta/LotusGenome/01_vgupta/11_clover/20140709_clover_pallescens/pallescens.pc.comb.gtf"
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