#!/bin/bash

# pack all mothur outputs
tar -jcf mothur.output.tar.bz2 \
	mothur.*.logfile \
	sbatch.mothur.* \
	mothur.output/ \
	mothur.output.shared \
	mothur.output.tax
