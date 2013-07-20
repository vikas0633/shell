#!/bin/bash
#PBS -N big_blastx
#PBS -l nodes=1:ppn=6
#PBS -l vmem=16000mb
#PBS -l walltime=10:00:00
cd $PBS_O_WORKDIR

export BLASTDB=/lustre/groups/lorainelab/data/blueberry/09_blastx/2013-06-21
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Glycine_max.tsv -db Glycine_max -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Arabidopsis_thaliana.tsv -db Arabidopsis_thaliana -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Medicago_truncatula.tsv -db Medicago_truncatula -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Oryza_sativa.tsv -db Oryza_sativa -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.refseq.tsv -db refseq -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Ricinus_communis.tsv -db Ricinus_communis -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Selaginella_moellendorffii.tsv -db Selaginella_moellendorffii -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Solanum_lycopersicum.tsv -db Solanum_lycopersicum -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Vitis_vinifera.tsv -db Vitis_vinifera -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Brachypodium_distachyon.tsv -db Brachypodium_distachyon -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Cucumis_sativus.tsv -db Cucumis_sativus -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Zea_mays.tsv -db Zea_mays -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Fragaria_vesca.tsv -db Fragaria_vesca -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Populus_trichocarpa.tsv -db Populus_trichocarpa -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Sorghum_bicolor.tsv -db Sorghum_bicolor -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
blastx -query ${PBS_ARRAYID}.fa -out ${PBS_ARRAYID}.Theobroma_cacao.tsv -db Theobroma_cacao -evalue 0.01 -max_target_seqs 1 -num_threads 6 -outfmt "7 qseqid qlen qframe qstart qend slen sstart send qcovs qcovhsp pident evalue bitscore ssid stitle"
