#' ---
#' title: "Arabidopsis aphid project - creating the sample table"
#' author: "Nicolas Delhomme"
#' date: "`r Sys.Date()`"
#' output:
#'  html_document:
#'    toc: true
#'    number_sections: true
#' ---
#' # Setup
#' Set the working dir
setwd("~/Git/UPSCb/projects/arabidopsis-aphids/doc")
#' ```{r set up, echo=FALSE}
#' knitr::opts_knit$set(root.dir="~/Git/UPSCb/projects/arabidopsis-aphids/doc")
#' ```
#' # Process 
#' Read the sample information
smpl <- read.delim("Sample_names.txt")

#' Read the file list
fl <- scan("filelist.txt",what="character")
fl <- sort(fl)

#' Identify biological and technical replicates
sn <- paste(smpl$Genotype,smpl$Treatment,sep="_")
br <- lapply(lapply(split(smpl$SampleID,sn),factor),as.integer)
tr <- lapply(lapply(br,duplicated),"+",1)
ord <- as.vector(apply(sapply(names(br),grepl,sn),2,which))

#' Describe the Treatment
smpl$TDesc <- smpl$Treatment
levels(smpl$TDesc) <- c("4 hours post infestation","8 hours post infestation","control")

smpl$GDesc <- smpl$Genotype
levels(smpl$GDesc) <- c("Col-0 wild-type","pae9-2 mutant")

#' Create the sample data.frame
df <- data.frame(
  ExperimentTitle="Arabidopsis requires PECTINACETYLESTERASE 9 for constitutive but not induced defenses against Myzus persicae aphids",
  SampleName=rep(paste(sn,unlist(br)[order(ord)],unlist(tr)[order(ord)],sep="_"),each=2),
  SampleDescription=rep(paste(smpl$GDesc,smpl$TDesc,"plants - biological replicate number",
                          unlist(br)[order(ord)],"technical replicate number",
                          unlist(tr)[order(ord)]),each=2),
  SequencingDate="2017-12-08T10:00:00",
  FileName=basename(fl),
  FileLocation=dirname(fl)
)
  
#' # Export
write.csv(df,"ENA/submission.csv",row.names = FALSE,quote = FALSE)

#' # Session Info
#' ```{r session info, echo=FALSE}
#' sessionInfo()
#' ```
