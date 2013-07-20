#!/bin/sh

FILES=`ls *.aa.fa`
for F in $FILES
do
    S=${F%.aa.fa}
    echo "doing: $cmd"
    cmd="makeblastdb -dbtype prot -in $F -out $S -title $S"
    $cmd
    cmd="chmod g+rw $S.*"
    echo "doing: $cmd"
    $cmd
    echo "done: $cmd"
done
