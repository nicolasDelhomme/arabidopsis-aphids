#' ---
#' title: "Arabidopsis aphid project - checking expression of key genes in WT"
#' author: "Nicolas Delhomme"
#' date: "`r Sys.Date()`"
#' output:
#'  html_document:
#'    toc: true
#'    number_sections: true
#' ---
#' # Setup
#' Set the working dir
setwd("/mnt/picea/projects/arabidopsis/mschmid/porcupine-RNA-Seq/analysis/kallisto")
#' ```{r set up, echo=FALSE}
#' knitr::opts_knit$set(root.dir="/mnt/picea/projects/arabidopsis/mschmid/porcupine-RNA-Seq/analysis/kallisto")
#' ```
#' 
#' Gene list
goi <- c("AT1G21250","AT1G15580","AT3G23240")

#' Data
dat <- read.csv("combined-library-size-normalized_variance-stabilized_gene-expression_data.csv",
                row.names=1,as.is=TRUE)

#' Sample info
samples <- read.csv("~/Git/UPSCb/projects/arabidopsis-porcupine-RNA-Seq/doc/RNA-seq_pcp_vs_Col-0_info.csv")

#' WT samples
smpl.sel <- paste0("X",samples$SampleID[grep("Col-0",samples$Description)])

#' # Rationale
#' Before performing a HTS experiment, we aim to look up the expression levels
#' of a few genes of interest to decide on an adequate sequencing depth.
#' ```{r empty, echo=FALSE, eval=FALSE}
#' ```
#' # Screen
#' ## Boxplot
#' Two of the gene of interest appear rather lowly expressed, their expression is
#' however, fairly invariable.
boxplot(t(dat[goi,smpl.sel]),
        ylab="approx. log2 expression")

#' ## Density
#' Here we can clearly see that two genes are on the lower end of the peak of 
#' expression of most genes. One being very close to these genes that are only
#' stochastically expressed (i.e. "biological noise")
plot(density(as.matrix(dat[,smpl.sel])),main="Density profile of the expression from 12 WT samples",
     xlab="approx. log2 expression")

abline(v=rowMeans(dat[goi,smpl.sel]),lty=2)

#' # Conclusion
#' These findings suggest that since these genes are of interest, it would be 
#' counter-productive to restrict the sequencing depth, unless if the expected changes
#' in expression would be consequent. Given that under the studies design, we 
#' won't be able to trust log2 fold change below 0.5, and given the variablity 
#' of the two lowly expressed genes, the relative expression increase (we would not
#' be able to estimate a decrease) would have to be by at least a fold (+100%).
#' If the expected effect is a decrease in expression, then sequencing deeper is
#' unavoidable.
#' ```{r empty, echo=FALSE, eval=FALSE}
#' ```
#' # Session Info
#' ```{r session info, echo=FALSE}
#' sessionInfo()
#' ```
#'
