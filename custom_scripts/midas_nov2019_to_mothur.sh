#!/bin/bash
################################################################################
# custom_scripts/midas_nov2019_to_mothur.sh
#
# USAGE
# -----
# custom_scripts/midas_nov2019_to_mothur.sh <MiDAS_taxonomy.fa>
# input file URL: [https://www.midasfieldguide.org/guide/downloads]
#
# SYNOPSIS
# --------
# this script splits the midas newest distribution format into
# two separate files:
# (1) a fasta file with simplified header as taxonomy reference
# (2) a tax file as the taxonomic labels
# these two files can be used standalone, or companied with the SILVA database
#
# NOTE: must verify the correct curation SILVA database in each MiDAS release
# for example, MiDAS 3.6 is curated from SILVA v132 release and can only be used
# together with this version.
################################################################################

################################################################################
# input midas file
in_file=$1
if [[ -z $in_file ]];
then
	echo -e "error: missing input file\nusage: $0 <MiDAS_taxonomy.fa>" >&2
	exit 1
fi

################################################################################
# fasta file
fas_file=$in_file.mothur.fasta
sed -r 's/^(>[^;]+).*$/\1/' $in_file > $fas_file

################################################################################
# taxonomy file
# [grep] select header lines ->
# [sed]  remove leading '>' ->
# [sed]  remove tax level, replace separator into ';' ->
# [sed]  into 2-column mothur taxonomy format
tax_file=$in_file.mothur.tax
grep '^>' $in_file |\
	sed 's/^>//' |\
	sed -r 's/,?[dkpcofgs]:/;/g' |\
	sed 's/;tax=;/\t/' > $tax_file
