#!/bin/bash
# this script links the reference database used by mothur.script when run jobs
# on dicsovery@NEU
################################################################################

mkdir -p ref_db
ln -sfT /home/li.gua/scratch/DATABASE/MIDAS_DB/MiDAS_S123_2.1.3.fasta \
	./ref_db/MiDAS_S123_2.1.3.fasta
ln -sfT /home/li.gua/scratch/DATABASE/MIDAS_DB/MiDAS_S123_2.1.3.mothur.tax \
	./ref_db/MiDAS_S123_2.1.3.mothur.tax
ln -sfT /home/li.gua/scratch/DATABASE/MOTHUR_DB/silva_v123/silva.nr_v123.v4.align \
	./ref_db/silva.nr_v123.v4.align
