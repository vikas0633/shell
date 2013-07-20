#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l vmem=18000mb
#PBS -l walltime=40:00:00
#PBS -q compute
#export BLASTDB=$HOME/data

LOGFILE=`date "+20%y%m%d_%H%M"`".logfile"

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE


DATADIR="/lustre/groups/lorainelab/data/blueberry/dhmri_ONeal_454_run_2009_06_18/fastq"
SCRIPTDIR="/lustre/home/vgupta2/script/python"
cd $DATADIR

python $SCRIPTDIR/20_trim_reads.py 10 0

echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $logfile
echo '----------------------------------------------' >> $logfile
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l vmem=18000mb
#PBS -l walltime=40:00:00
#PBS -q compute
#export BLASTDB=$HOME/data

LOGFILE=`date "+20%y%m%d_%H%M"`".logfile"

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE


DATADIR="/lustre/groups/lorainelab/data/blueberry/illumina_DHMR/fastq"
SCRIPTDIR="/lustre/home/vgupta2/script/python"
cd $DATADIR

python $SCRIPTDIR/20_trim_reads.py 10 5

echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l vmem=18000mb
#PBS -l walltime=40:00:00
#PBS -q compute
#export BLASTDB=$HOME/data

WORKDIR="/lustre/home/vgupta2/01_blueberry/02_trimming"

LOGFILE=`date "+20%y%m%d_%H%M"`".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE


DATADIR="/lustre/groups/lorainelab/data/blueberry/ncsu_ONeal_454_Aug_2010/files_from_ncsu_gsl/fastq"
SCRIPTDIR="/lustre/home/vgupta2/script/python"
cd $DATADIR

python $SCRIPTDIR/20_trim_reads.py 10 0

echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l vmem=18000mb
#PBS -l walltime=40:00:00
#PBS -q compute
#export BLASTDB=$HOME/data

WORKDIR="/lustre/home/vgupta2/01_blueberry/02_trimming"

LOGFILE=`date "+20%y%m%d_%H%M"`".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE


DATADIR="/lustre/groups/lorainelab/data/blueberry/pe_blueberry/ch1/PE_100521_UNC3-RDR300156_0006/fastq"
SCRIPTDIR="/lustre/home/vgupta2/script/python"
cd $DATADIR

python $SCRIPTDIR/20_trim_reads.py 10 5

echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l vmem=18000mb
#PBS -l walltime=40:00:00
#PBS -q compute
#export BLASTDB=$HOME/data

WORKDIR="/lustre/home/vgupta2/01_blueberry/02_trimming"

LOGFILE=`date "+20%y%m%d_%H%M"`".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE


DATADIR="/lustre/groups/lorainelab/data/blueberry/pe_blueberry/ch1/PE_100527_UNC8-RDR3001640_0006/fastq"
SCRIPTDIR="/lustre/home/vgupta2/script/python"
cd $DATADIR

python $SCRIPTDIR/20_trim_reads.py 10 5

echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l vmem=18000mb
#PBS -l walltime=40:00:00
#PBS -q compute
#export BLASTDB=$HOME/data

WORKDIR="/lustre/home/vgupta2/01_blueberry/02_trimming"

LOGFILE=`date "+20%y%m%d_%H%M"`".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE


DATADIR="/lustre/groups/lorainelab/data/blueberry/pe_blueberry/ch1/PE_100604_UNC2-RDR300275_0010-61LV4AAXX/fastq"
SCRIPTDIR="/lustre/home/vgupta2/script/python"
cd $DATADIR

python $SCRIPTDIR/20_trim_reads.py 10 5

echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l vmem=18000mb
#PBS -l walltime=40:00:00
#PBS -q compute
#export BLASTDB=$HOME/data

WORKDIR="/lustre/home/vgupta2/01_blueberry/02_trimming"

LOGFILE=`date "+20%y%m%d_%H%M"`".logfile"
LOGFILE=$WORKDIR"/"$LOGFILE

echo '----------------------------------------------' > $LOGFILE
echo "Job has been started: " `date "+20%y%m%d_%H%M"` >> $LOGFILE


DATADIR="/lustre/groups/lorainelab/data/blueberry/pe_blueberry/ch2/PE_100903_UNC5-RDR300700_00024_FC_622CHAAXX/fastq"
SCRIPTDIR="/lustre/home/vgupta2/script/python"
cd $DATADIR

python $SCRIPTDIR/20_trim_reads.py 10 5

echo "All Jobs has been finished: " `date "+20%y%m%d_%H%M"` >> $LOGFILE
echo '----------------------------------------------' >> $LOGFILE
