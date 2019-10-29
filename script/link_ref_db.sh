#!/bin/bash
################################################################################
# this script links the reference database used by mothur.script when run jobs
# on dicsovery@NEU
################################################################################
db_dir="/home/li.gua/scratch/DATABASE"
ln_dir="./ref_db"
mkdir -p $ln_dir
################################################################################
# silva v123
ln -sfT $db_dir/MOTHUR_DB/silva_v123/silva.seed_v123.align.v4	$ln_dir/silva.seed_v123.align.v4
ln -sfT $db_dir/MOTHUR_DB/silva_v123/silva.nr_v123.align.v4		$ln_dir/silva.nr_v123.align.v4
ln -sfT $db_dir/MOTHUR_DB/silva_v123/silva.nr_v123.tax			$ln_dir/silva.nr_v123.tax
# silva_v128
ln -sfT $db_dir/MOTHUR_DB/silva_v128/silva.seed_v128.align.v4	$ln_dir/silva.seed_v128.align.v4
ln -sfT $db_dir/MOTHUR_DB/silva_v128/silva.nr_v128.align.v4		$ln_dir/silva.nr_v128.align.v4
ln -sfT $db_dir/MOTHUR_DB/silva_v128/silva.nr_v128.tax			$ln_dir/silva.nr_v128.tax
# silva_v132
ln -sfT $db_dir/MOTHUR_DB/silva_v132/silva.seed_v132.align.v4	$ln_dir/silva.seed_v132.align.v4
ln -sfT $db_dir/MOTHUR_DB/silva_v132/silva.nr_v132.align.v4		$ln_dir/silva.nr_v132.align.v4
ln -sfT $db_dir/MOTHUR_DB/silva_v132/silva.nr_v132.tax			$ln_dir/silva.nr_v132.tax
# midas, built on silva v123, should be better aligned with silva v123
ln -sfT $db_dir/MIDAS_DB/MiDAS_S123_2.1.3.fasta					$ln_dir/midas_s123.fasta
ln -sfT $db_dir/MIDAS_DB/MiDAS_S123_2.1.3.mothur.tax			$ln_dir/midas_s123.mothur.tax
################################################################################

################################################################################
# only need to change these
################################################################################
# alignment template, used in template (a.k.a. reference) in align.seqs()
# use seed in alignment is fine
ln -sfT silva.seed_v128.align.v4								$ln_dir/align.fasta
# taxonomy classif. reference and labels
# NOT use seed seqs here
ln -sfT silva.nr_v128.align.v4									$ln_dir/classif.ref
ln -sfT silva.nr_v128.tax										$ln_dir/classif.tax
# or, use midas as reference
#ln -sfT midas_s123.fasta										$ln_dir/classif.ref
#ln -sfT midas_s123.tax											$ln_dir/classif.tax
