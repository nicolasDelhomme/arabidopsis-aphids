# Load the library
suppressPackageStartupMessages(library(easyRNASeq))

# create a synthetic set of transcripts
synTrx <- createSyntheticTranscripts("/mnt/picea/storage/reference/Arabidopsis-thaliana/ARAPORT11/gff3/Araport11_GFF3_genes_transposons.201606-no-derivate.gff",
                                    verbose=TRUE)

# export the gff3 file
writeGff3(synTrx,file = "/mnt/picea/storage/reference/Arabidopsis-thaliana/ARAPORT11/gff3/Araport11_GFF3_genes_transposons.201606_synthetic-transcripts.gff3")
