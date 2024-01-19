#!/bin/bash

# pack all mothur outputs
tar -jcf mothur.output.tar.bz2 \
	--exclude "*.tar.bz2" \
	mothur.*.logfile \
	mothur.input.list \
	mothur.output/
