#!/bin/bash

# pack only outputs necessary for downstream analysis
tar -jcf mothur.output.lite.tar.bz2 \
	--exclude "*.tar.bz2" \
	--exclude "*.dist" \
	mothur.*.logfile \
	mothur.input.list \
	mothur.output/final.* \
	mothur.output/*.mothur.log \
	mothur.output/*.current_files.summary \
 	abundance \
  	reads \
   	reads_qc \
    	script 
