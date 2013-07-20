#!/bin/bash
qsub -o proc_On_Unr.out -e proc_On_Unr.err proc_On_Unr.sh
qsub -o proc_Pa_Unr.out -e proc_Pa_Unr.err proc_Pa_Unr.sh
qsub -o proc_Le_Mat.out -e proc_Le_Mat.err proc_Le_Mat.sh
qsub -o proc_On_Mat.out -e proc_On_Mat.err proc_On_Mat.sh
qsub -o proc_OB_Mat.out -e proc_OB_Mat.err proc_OB_Mat.sh
qsub -o proc_OB_Unr.out -e proc_OB_Unr.err proc_OB_Unr.sh
qsub -o proc_On_Mat2.out -e proc_On_Mat2.err proc_On_Mat2.sh
qsub -o proc_On_Unr2.out -e proc_On_Unr2.err proc_On_Unr2.sh
