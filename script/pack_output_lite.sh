#!/bin/bash

# pack only outputs necessary for downstream analysis
tar -jcf mothur.output.lite.tar.bz2 \
	mothur.*.logfile \
	sbatch.mothur.* \
	mothur.output/*.pick.pick.fasta \
	mothur.output/*.opti_mcc.* \
	mothur.output.shared \
	mothur.output.tax
