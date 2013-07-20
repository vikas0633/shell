#!/bin/bash
qsub -o 33-3_pad_a.out -e 33-3_pad_a.err  33-3_pad_a.sh
qsub -o 33-3_pad_b.out -e 33-3_pad_b.err  33-3_pad_b.sh
