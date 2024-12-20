samples.loris <- read.recent.version.tsv("data", "samples_loris_clean_") %>%
  mutate(CollectionDate  = ymd(CollectionDate),
         ExtractDate_RNA = ymd(ExtractDate_RNA),
         ExtractDate_DNA = ymd(ExtractDate_DNA),
         Seq_16sDate     = ymd(Seq_16sDate)) %>%
  mutate(CollectionMonth = str_glue("{month(CollectionDate)}", "-", "{year(CollectionDate)}")) %>%
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

endprep.tbl <- tibble(
  Reagent = c("Prepared DNA (from previous step)", 
              "DNA CS (optional)",
              "NEBNext FFPE DNA Repair Buffer v2",
              "NEBNext FFPE DNA Repair Mix ",
              "Ultra II End-prep Enzyme Mix"),
  Volume_rxn = c(47, 1, 7, 2, 3))

