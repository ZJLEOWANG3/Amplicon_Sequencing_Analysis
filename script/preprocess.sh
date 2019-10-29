#!/bin/bash

rd_dir="./reads"
qc_dir="./reads_qc"

mkdir -p qc
for i in $(cat samples.list); do
	sickle pe -t sanger \
		-f $rd_dir/$i"_R1.fastq" \
		-r $rd_dir/$i"_R2.fastq" \
		-o $qc_dir/$i"_R1.fastq" \
		-p $qc_dir/$i"_R2.fastq" \
		-s $qc_dir/$i"_single.fastq"
done
