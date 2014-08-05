### create json paragraph

### nodes to be used
cores=2
ROOT_PASSWORD='n0c6r3c3'

### data_dir
data_dir="/u/vgupta/35_Simon_RNAseq/2014-07-10"
cd $data_dir

touch trackList_json.txt
touch trackMeta.txt

for file in NG-*.fastq
do
echo $file

### work dir
full_path=$file
f=$(basename $full_path)
dir=$(dirname $full_path)
work_dir=$data_dir/"dir_"$f

echo $ROOT_PASSWORD | sudo -S cp $work_dir/$file".refined.bw" /var/www/lotus0.1/data/

echo '	{' >> trackList_json.txt
echo '      "label" : "' $f  '",' >> trackList_json.txt
echo '      "key" : "' $f  '",' >> trackList_json.txt
echo '       "storeClass" : "BigWig",' >> trackList_json.txt
echo '       "urlTemplate" : "'$f".refined.bw"'",' >> trackList_json.txt
echo '       "type" : "Wiggle", '  >> trackList_json.txt
echo '	     "scale": "log", ' >> trackList_json.txt
echo '       "variance_band" : true,' >> trackList_json.txt
echo '},' >> trackList_json.txt

echo '"Illumina", "RNA-seq coverage", " ", "Vikas Gupta","Simon Kelly"," ","' $f '", "RNA-seq","Experimental"," ","Lotus Japonicus","' $f '"' >> trackMeta.txt

done
 
