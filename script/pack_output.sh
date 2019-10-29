#!/bin/bash

tar -jcf mothur.output.tar.bz2 \
	mothur.output/*.pick.pick.fasta \
	mothur.output/*.opti_mcc.*
