# data_loader.R

base_path  <- paste0(params$base_path)
local_path <- paste0(params$local)

source(paste0(params$base_path, "resources/rxn_volumes.R"))

read.recent.version.csv <- function(directory, pattern, base_path) {
  file_path <- paste0(base_path, directory, "/")
  files <- list.files(
    path = file_path,
    pattern = paste0(pattern, "\\d{4}-\\d{1,2}-\\d{1,2}\\.csv"),
    full.names = TRUE
  )
  
  if (length(files) == 0) stop(paste("No matching CSV files found in", file_path))
  
  dates <- gsub(".*_(\\d{4}-\\d{1,2}-\\d{1,2})\\.csv", "\\1", files)
  most_recent_file <- files[which.max(as.Date(dates))]
  
  read.csv(most_recent_file, header = TRUE)
}

read.recent.version.tsv <- function(directory, pattern, base_path) {
  # Build file path
  file_path <- paste0(base_path, directory, "/")
  files <- list.files(
    path = file_path,
    pattern = paste0(pattern, "\\d{4}-\\d{1,2}-\\d{1,2}\\.tsv"),
    full.names = TRUE
  )
  
  if (length(files) == 0) stop(paste("No matching TSV files found in", file_path))
  
  dates <- gsub(".*_(\\d{4}-\\d{1,2}-\\d{1,2})\\.tsv", "\\1", files)
  most_recent_file <- files[which.max(as.Date(dates))]
  
  read.table(most_recent_file, sep = "\t", header = TRUE)
}

all_samples <- read.recent.version.tsv("data", "samples_loris_clean_", local_path) %>%
  mutate(CollectionDate  = ymd(CollectionDate),
         ExtractDate_RNA = ymd(ExtractDate_RNA),
         ExtractDate_DNA = ymd(ExtractDate_DNA),
         Seq_16sDate     = ymd(Seq_16sDate))  

sample.list <- all_samples %>%
  select(SampleID,
         CollectionDate,
         Subj_Certainty,
         Subject,
         SampleCollectedBy,
         SampleNotes,
         n_dna_extractions,
         n_rna_extractions,
         n_seq_16s,
         ExtractID_DNA,
         ExtractDate_DNA,
         ExtractConc_DNA,
         ExtractedBy_DNA,
         ExtractKit_DNA,
         ExtractBox_DNA,
         ExtractNotes_DNA) %>%
  distinct()


samples.loris <- all_samples %>%
  select(SampleID,
         CollectionDate,
         Subj_Certainty,
         Subject,
         n_dna_extractions,
         n_rna_extractions,
         n_seq_16s,
         ExtractID_DNA,
         ExtractDate_DNA,
         ExtractConc_DNA,
         ExtractedBy_DNA,
         ExtractKit_DNA,
         ExtractBox_DNA,
         ExtractNotes_DNA,
         SequenceID,
         Seq_16sDate,
         LibraryBarcode,
         LibraryFinalConc,
         LibraryCode,
         LibraryPoolVol_ul) %>%
  distinct()



