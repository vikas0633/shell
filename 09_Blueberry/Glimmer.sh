#--------------------------------------------------------------------------------------------------------------------------------------------------------
#Glimmer - 20130709 - Arabidopsis trained parameters
#-------------------------------------------------------------------------------------------------------------------------------------
GENOME="/u/vgupta/09_blueberry/01_genome/454Scaffolds.fna"

### split fasta file
perl ~/script/perl/01_fasta_split.pl --input_file=/u/vgupta/09_blueberry/01_genome/454Scaffolds.fna --output_dir=/u/vgupta/09_blueberry/01_genome/scaffolds --seqs_per_file=1

for file in /u/vgupta/09_blueberry/01_genome/scaffolds/*
do
	glimmerhmm_linux $file /u/vgupta/01_genome_annotation/tools/GlimmerHMM/trained_dir/arabidopsis -g > "$file"_20130611_glimmerHMM_arabidopsis.gff3
done

cat *_20130611_glimmerHMM_arabidopsis.gff3 | grep -v '^#' > /u/vgupta/09_blueberry/02_Glimmer/20130611_glimmerHMM_arabidopsis.gff3

#--------------------------------------------------------------------------------------------------------------------------------------------------------

