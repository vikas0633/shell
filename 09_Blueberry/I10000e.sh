#!/bin/bash
qsub -o OB_Unr.out -e OB_Unr.err  OB_Unr.sh
qsub -o OB_Mat.out -e OB_Mat.err  OB_Mat.sh
