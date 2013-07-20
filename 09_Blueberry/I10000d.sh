#!/bin/bash
qsub -o Le_Mat.out -e Le_Mat.err  Le_Mat.sh
qsub -o On_Mat.out -e On_Mat.err  On_Mat.sh
