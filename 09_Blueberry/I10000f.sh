#!/bin/bash
qsub -o On_Unr2.out -e On_Unr2.err  On_Unr2.sh
qsub -o On_Mat2.out -e On_Mat2.err  On_Mat2.sh
