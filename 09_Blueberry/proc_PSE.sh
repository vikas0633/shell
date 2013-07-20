#!/bin/bash
qsub -o proc_33-3_pad_a.out -e proc_33-3_pad_a.err proc_33-3_pad_a.sh
qsub -o proc_33-3_pad_b.out -e proc_33-3_pad_b.err proc_33-3_pad_b.sh
qsub -o proc_2-41_cup.out -e proc_2-41_cup.err proc_2-41_cup.sh
qsub -o proc_2-41_green.out -e proc_2-41_green.err proc_2-41_green.sh
qsub -o proc_2-41_pad.out -e proc_2-41_pad.err proc_2-41_pad.sh
qsub -o proc_2-41_pink.out -e proc_2-41_pink.err proc_2-41_pink.sh
qsub -o proc_2-41_ripe.out -e proc_2-41_ripe.err proc_2-41_ripe.sh
qsub -o proc_2-42_cup.out -e proc_2-42_cup.err proc_2-42_cup.sh
qsub -o proc_2-42_green.out -e proc_2-42_green.err proc_2-42_green.sh
qsub -o proc_2-42_pink.out -e proc_2-42_pink.err proc_2-42_pink.sh
qsub -o proc_2-42_ripe.out -e proc_2-42_ripe.err proc_2-42_ripe.sh
qsub -o proc_3-33_cup.out -e proc_3-33_cup.err proc_3-33_cup.sh
qsub -o proc_3-33_green.out -e proc_3-33_green.err proc_3-33_green.sh
qsub -o proc_3-33_pink.out -e proc_3-33_pink.err proc_3-33_pink.sh
qsub -o proc_3-33_ripe.out -e proc_3-33_ripe.err proc_3-33_ripe.sh
