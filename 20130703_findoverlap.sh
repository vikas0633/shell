module load bedtools/2.17.0
cd /lustre/groups/lorainelab/data/blueberry/17_jenny454
gff3="20130702_blueberry.gff3.genes.gff"
FLOAT=(0.001 0.01 0.05 0.10 0.20 0.30 0.50 0.75 1.00)
DATADIR="/lustre/groups/lorainelab/data/blueberry/17_jenny454/100_data/01_fastq"
len=${#FLOAT[*]}

echo -n "file overlap",
for (( i=0; i<len; i++ ))
do
	echo -n ${FLOAT[$i]},
done
echo

for file in $DATADIR/*.gff
do
	file_name=`echo $file | awk -F / '{printf("%s", $10)}'| awk -F "." '{printf("%s\t", $1)}'`
	echo -n $file_name,
	for (( i=0; i<len; i++ ))
	do
		lines=` wc -l $file | cut -d ' ' -f 1`
		overlap=`bedtools intersect -u -f ${FLOAT[$i]} -a $file -b $gff3 |wc -l`
		fraction=`nawk 'BEGIN {print '$overlap' / '$lines'}'`
		echo -n $fraction,
	done
	echo 
done
