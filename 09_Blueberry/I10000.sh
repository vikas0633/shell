#!/bin/bash
qsub -o 2-41_cup.out -e 2-41_cup.err  2-41_cup.sh
qsub -o 2-41_ripe.out -e 2-41_ripe.err  2-41_ripe.sh
qsub -o 3-33_cup.out -e 3-33_cup.err  3-33_cup.sh
qsub -o 3-33_pink.out -e 3-33_pink.err  3-33_pink.sh
qsub -o 3-33_ripe.out -e 3-33_ripe.err  3-33_ripe.sh
qsub -o 3-33_green.out -e 3-33_green.err  3-33_green.sh
qsub -o 2-42_pink.out -e 2-42_pink.err  2-42_pink.sh
qsub -o 2-42_green.out -e 2-42_green.err  2-42_green.sh
qsub -o 2-41_green.out -e 2-41_green.err  2-41_green.sh
qsub -o 2-42_cup.out -e 2-42_cup.err  2-42_cup.sh
qsub -o 2-42_ripe.out -e 2-42_ripe.err  2-42_ripe.sh
qsub -o 2-41_pad.out -e 2-41_pad.err  2-41_pad.sh
qsub -o 2-41_pink.out -e 2-41_pink.err  2-41_pink.sh
