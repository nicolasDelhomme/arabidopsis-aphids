# FASTQC
bash ~/Git/UPSCb/pipeline/runFastQCCounts.sh | sort | awk '{if(NR%2 == 1){print $4}}'

# SORTMERNA
~/Git/UPSCb/pipeline/runSortmernaStats.sh .
more sortmernaStats.txt | sort

# TRIMMOMATIC
~/Git/UPSCb/pipeline/runTrimmomaticStats.sh .
more trimmomaticStats.txt | sort

# STAR
~/Git/UPSCb/pipeline/runSTARStats.sh .
 more STARStats.txt | sort

# HTSEQ
~/Git/UPSCb/pipeline/runHTSeqStats.sh . | sort | awk '{print $3"\t"$5}'

# KALLISTO
~/Git/UPSCb/pipeline/runKallistoStats.sh .
 more kallistoStats.txt | awk '{print $2}'
 