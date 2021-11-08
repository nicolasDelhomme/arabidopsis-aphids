#!/bin/bash -l

set -e
# use set -ex for debugging instead

proj=snic2018-8-9
mail=karen.kloth@umu.se
in=/proj/uppstore2017061/snic2018-8-9
out=/proj/uppstore2017061/snic2018-8-9/multiqc

if [ ! -d $out ]; then
	mkdir -p $out
fi

module load bioinfo-tools MultiQC

sbatch -d afterok:1879277 --mail-user=$mail -o $in/multiqc.out -e $in/multiqc.err \
-A $proj $UPSCb/pipeline/runMultiQC.sh $in $out
