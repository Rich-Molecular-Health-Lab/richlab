# data_loader.R

base_path  <- paste0(params$base_path)
local_path <- paste0(params$local)

samples.loris <- read.recent.version.tsv("data", "samples_loris_clean_", local_path) %>%
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


rxn_endprep <- tibble(Reagent = c("DNA Template", 
                                  "DNA CS (optional)",
                                  "NEBNext FFPE DNA Repair Buffer v2",
                                  "NEBNext FFPE DNA Repair Mix ",
                                  "Ultra II End-prep Enzyme Mix"), 
                      Volume_rxn = c(47, 1, 7, 2, 3))
rxn_adapter <- tibble(Reagent = c("DNA Template",
                                  "Ligation Adapter (LA)",
                                  "Ligation Buffer (LNB)",
                                  "Salt-T4® DNA Ligase"), 
                      Volume_rxn = c(60, 5, 25, 10))
rxn_fcprime <- tibble(Reagent = c("Flow Cell Flush (FCF)",
                                  "Bovine Serum Albumin (BSA) at 50 mg/ml",
                                  "Flow Cell Tether (FCT)"), 
                      Volume_rxn = c(1170, 5, 30))
rxn_fcload  <- tibble(Reagent = c("DNA Template",
                                  "Sequencing Buffer (SB)",
                                  "Library Beads (LIB) mixed immediately before use"), 
                      Volume_rxn = c(12, 37.5, 25.5))


input_dna.tbl <- tibble(
  min_kb = c(0, 1, 10),
  max_kb = c(1, 10, 100),
  input  = c("200 fmol",
             "100-200 fmol",
             "1 ug"))

flowcell_check.tbl <- tibble(
  flow_cell = c("Flongle",
                "MinION",
                "PromethION"),
  min_pores = c(50, 800, 5000))

SQK.LSK114.contents.tbl <- tibble(
  abbrev  = c("DCS", "LA", "LNB", "LFB", "SFB", "AXP", "SB", "EB", "LIB", "LIS", "FCF", "FCT"),
  reagent = c("DNA Control Strand", "Ligation Adapter", "Ligation Buffer", "Long Fragment Buffer", "Short Fragment Buffer", "AMPure XP Beads", "Sequencing Buffer", "Elution Buffer", "Library Beads", "Library Solution", "Flow Cell Flush", "Flow Cell Tether"),
  color   = c("yellow", "green", "lightgray", "orange", "gray", "brown", "red", "black", "magenta", "pink", "blue", "purple"))


supplies <- bind_rows(
  tibble(
    Step = rep("All", 7),
    Category = rep("Equipment", 7),
    Item = c("MinION Device",
             "Qubit fluorometer",
             "Thermal cycler",
             "Hula mixer",
             "Magnetic rack",
             "Microfuge",
             "Ice bucket or freezy block"),
    Manufacturer = c("ONT", "Invitrogen", rep("NA", 5)),
    Catalog = rep("NA", 7)
  ),
  tibble(
    Step = rep("All", 2),
    Category = rep("Kit", 2),
    Item = c("Ligation Sequencing Kit V14", "NEBNext Companion Module v2 for ONT Ligation Sequencing"),
    Manufacturer = c("ONT", "NEB"),
    Catalog = c("SQK-LSK114", "E7672S")
  ),
  tibble(Step     = c("End_Prep"),
         Category = c("Other"),
         Item = c("1 µg (or 100-200 fmol) high molecular weight genomic DNA"),
         Manufacturer = c("NA"),
         Catalog = c("NA")),
  
  tibble(Step     = rep("End_Prep", 10),
         Category = rep("Materials", 10),
         Item = c("DNA Control Sample",
                  "AMPure XP Beads",
                  "NEBNext® FFPE DNA Repair Buffer v2",
                  "NEBNext® Ultra II End Prep Enzyme Mix",
                  "Qubit dsDNA HS Assay Kit",
                  "Nuclease-free water",
                  "Freshly prepared 80% ethanol in nuclease-free water",
                  "Qubit™ Assay Tubes",
                  "0.2 ml thin-walled PCR tubes",
                  "1.5 ml Eppendorf DNA LoBind tubes"),
         Manufacturer = c("ONT", "ONT", "NEB", "NEB", "Invitrogen", "Any", "Any", "Invitrogen", "Any", "Any"),
         Catalog = c("NA", "NA", "E7672S/M6630", "E7672S/E7363", "Q32851", "NA", "NA", "Q32856", "NA", "NA")),
  tibble(
    Step     = rep("Adapter_Ligation", 4),
    Category = rep("Materials", 4),
    Item  = c("Ligation Adapter (LA)",
              "Ligation Buffer (LNB)",
              "Long Fragment Buffer (LFB)",
              "Short Fragment Buffer (SFB)"), 
    Manufacturer = rep("ONT", 4),
    Catalog = rep("NA", 4)),
  tibble(
    Step     = rep("Adapter_Ligation", 2),
    Category = rep("Consumables", 2),
    Item  = c("Salt-T4® DNA Ligase",
              "1.5 ml Eppendorf DNA LoBind tubes"),
    Manufacturer = c("NEB",
                     "Any"),
    Catalog = c("M0467",
                "NA")),
  tibble(
    Step    = rep("Library_Cleanup", 2),
    Category = rep("Materials", 2),
    Item = c("AMPure XP Beads (AXP)",
             "Elution Buffer (EB)"), 
    Manufacturer = rep("ONT", 2),
    Catalog = rep("NA", 2)),
  tibble(
    Step    = rep("Library_Cleanup", 3),
    Category = rep("Consumables", 3),
    Item = c("1.5 ml Eppendorf DNA LoBind tubes",
             "Qubit dsDNA HS Assay Kit",
             "Qubit™ Assay Tubes"),
    Manufacturer = c("Any",
                     "Invitrogen",
                     "Invitrogen"),
    Catalog = c("NA",
                "Q32851",
                "Q32856")),
  tibble(
    Step    = rep("Load_Flowcell", 5),
    Category = rep("Materials", 5),
    Item = c("Flow Cell Flush (FCF)",
             "Flow Cell Tether (FCT)",
             "Library Solution (LIS)",
             "Library Beads (LIB)",
             "Sequencing Buffer (SB)"),
    Manufacturer = rep("ONT", 5),
    Catalog = rep("NA", 5)),
  tibble(
    
    Step    = rep("Load_Flowcell", 3),
    Category = rep("Consumables", 3),
    Item     = c("MinION Flow Cell",
                 "Bovine Serum Albumin (BSA) (50 mg/ml)",
                 "1.5 ml Eppendorf DNA LoBind tubes"),
    Manufacturer = c("ONT", rep("Any", 2)),
    Catalog = rep("NA", 3)
  )
) %>%
  mutate(Category = factor(Category, levels = c("Equipment", "Kit", "Materials", "Consumables", "Other"), ordered = T),
         Step     = factor(Step, levels = c("All", "End_Prep", "Adapter_Ligation", "Library_Cleanup", "Load_Flowcell"), ordered = T)) %>%
  arrange(Step, Category, Manufacturer)
