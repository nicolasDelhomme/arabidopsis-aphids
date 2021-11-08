#!/bin/bash -l

set -ex

proj=snic2018-8-9
mail=karen.kloth@umu.se
in=/proj/uppstore2017061/snic2018-8-9/raw
out=/proj/uppstore2017061/snic2018-8-9
genome=/proj/uppstore2017061/Arabidopsis-thaliana/ARAPORT11/indices/STAR/2.5.2b
gtf=/proj/uppstore2017061/Arabidopsis-thaliana/ARAPORT11/gff3/Araport11_GFF3_genes_transposons.201606.gtf
gff3=/proj/uppstore2017061/Arabidopsis-thaliana/ARAPORT11/gff3/Araport11_GFF3_genes_transposons.201606_synthetic-transcripts.gff3
kallisto_fasta=/proj/uppstore2017061/Arabidopsis-thaliana/ARAPORT11/fasta/Araport11_all.201606.cdna.fasta.gz
kallisto_index=/proj/uppstore2017061/Arabidopsis-thaliana/ARAPORT11/indices/kallisto/Araport11_all.201606.cdna.inx
start=2
end=9

module load bioinfo-tools FastQC trimmomatic SortMeRNA star samtools htseq MultiQC kallisto

if [ -z $UPSCb ]; then
    echo "Set up the UPSCb env. var. to your Git UPSCb checkout dir."
fi

for f in `find $in -name "*_[1,2].fastq.gz"`; do echo "${f//_[1,2].fastq.gz/}" ; done | sort | uniq | while read line;
do
  bash $UPSCb/pipeline/runRNASeqPreprocessing.sh -s $start -e $end -g $genome -m 128 \
  -G $gtf -H $gff3 -t -f $kallisto_fasta -K $kallisto_index $proj $mail ${line}_1.fastq.gz ${line}_2.fastq.gz $out
done
