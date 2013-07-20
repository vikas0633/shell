#!/bin/bash
qsub -o Pa_Unr.out -e Pa_Unr.err  Pa_Unr.sh
qsub -o On_Unr.out -e On_Unr.err  On_Unr.sh
