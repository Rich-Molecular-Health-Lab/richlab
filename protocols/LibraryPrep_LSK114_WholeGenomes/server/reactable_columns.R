# reactable_columns.R

columns_samples <- list(
  SampleID            = colDef(name = "Sample")            ,
  n_dna_extractions   = colDef(name = "DNA"                , align = "left" , filterable = TRUE, aggregate = "unique"   , maxWidth = 75, aggregated = checklist_js, cell = checklist_r, sortable   = TRUE),
  n_rna_extractions   = colDef(name = "RNA"                , align = "left" , filterable = TRUE, aggregate = "unique"   , maxWidth = 75, aggregated = checklist_js, cell = checklist_r, sortable   = TRUE),
  n_seq_16s           = colDef(name = "16S"                , align = "left" , filterable = TRUE, aggregate = "unique"   , maxWidth = 75, aggregated = checklist_js, cell = checklist_r, sortable   = TRUE),
  CollectionDate      = colDef(name = "Date Collected"     , align = "left" , sortable   = TRUE, format = colFormat(date = TRUE), aggregate = "frequency"),
  Subject             = colDef(name = "Name"               , align = "left" , filterable = TRUE, aggregate = "frequency", maxWidth = 80 , sortable   = TRUE),
  Subj_Certainty      = colDef(name = "Confirmed"          , align = "right", filterable = TRUE, aggregate = "unique"   , maxWidth = 80, aggregated = certainty_js, cell = certainty_r),
  ExtractID_DNA       = colDef(name = "DNA Extracts"       , align = "left" , sortable   = TRUE, filterable = TRUE, aggregate = "count", maxWidth = 125),
  ExtractDate_DNA     = colDef(name = "Date Extracted"     , align = "left" , sortable   = TRUE, aggregate = "max",format = colFormat(date = TRUE)),
  ExtractConc_DNA     = colDef(name = "Concentration"      , align = "left", filterable = TRUE, aggregate = "max", maxWidth = 125, sortable   = TRUE, format = colFormat(suffix = ngul)),
  ExtractedBy_DNA     = colDef(name = "Extracted By"       , align = "left", aggregate = "unique"),
  ExtractKit_DNA      = colDef(name = "Extraction Kit"     , align = "left" , filterable = TRUE, maxWidth = 150, sortable = TRUE),
  ExtractBox_DNA      = colDef(name = "Storage Box"        , align = "left" , maxWidth = 150) ,
  ExtractNotes_DNA    = colDef(name = "Notes"              , align = "left" , maxWidth = 200) ,
  .selection          = colDef(name =  "Check Extract Rows to Include", sticky = "left")
)

columns_subtable <- list(
  SequenceID          = colDef(name = "16S Library"        , align = "left" , maxWidth = 125),
  Seq_16sDate         = colDef(name = "Date Sequenced"     , align = "left" , format = colFormat(date = TRUE)),           
  LibraryBarcode      = colDef(name = "Barcode"            , align = "left"),                                                      
  LibraryFinalConc    = colDef(name = "Final Concentration", align = "left", maxWidth = 125, format = colFormat(suffix = ngul)) ,            
  LibraryCode         = colDef(name = "Pooled Library ID"  , align = "left"),
  LibraryPoolVol_ul   = colDef(name = "Pooled Library Vol" , align = "left", format = colFormat(suffix = ul))
)

groups_samples <- list(colGroup(name    = "Extracted/Sequenced", columns = c("n_dna_extractions", "n_rna_extractions", "n_seq_16s")), 
                      colGroup(name     = "Subject"            , columns = c("Subject", "Subj_Certainty")))

columns_setup_summary <- list(
    TubeNo            = colDef(name = "Tube Number"),
    ExtractID         = colDef(name = "Extract ID") ,
    ExtractConc       = colDef(name = "Extract Concentration", format = colFormat(suffix = ngul , digits = 1)) ,
    Strands           = colDef(show = FALSE)   ,   
    Length            = colDef(show = FALSE)   ,   
    InputMassStart    = colDef(name = "Mass to Add"          , format = colFormat(suffix = " ng", digits = 1)) ,
    ExtractInputVol   = colDef(name = "Extract to Add"       , format = colFormat(suffix = ul   , digits = 1)) ,
    ExtractDiluteWater= colDef(name = "Water to Add"         , format = colFormat(suffix = ul   , digits = 1)) ,  
    LibPrepBy         = colDef(name = "Library Prep By") ,
    LibPrepDate       = colDef(name = "Library Prep Date"    , format = colFormat(date = TRUE)),
    FlowCellType      = colDef(name = "Flow Cell Type"),           
    FlowCellSerial    = colDef(name = "Flow Cell Serial No."),           
    SeqDevice         = colDef(name = "MinION Name"), 
    Conc_QC1          = colDef(show = FALSE)   ,   
    Conc_QC2          = colDef(show = FALSE)   ,   
    InputMassFinal    = colDef(show = FALSE)   ,
    AdjustLibrary     = colDef(show = FALSE)   ,   
    LibraryLoadingVol = colDef(show = FALSE)   ,   
    LibraryWaterVol   = colDef(show = FALSE)   ,   
    SampleID          = colDef(show = FALSE)   
  )
    
  columns_extract_prep <- list(
    TubeNo            = colDef(name = "Tube Number")  ,
    ExtractID         = colDef(name = "Extract ID")   ,
    ExtractConc       = colDef(name = "Extract Concentration", format = colFormat(suffix = ngul , digits = 1)) ,
    Strands           = colDef(show = FALSE)   ,   
    Length            = colDef(show = FALSE)   ,   
    InputMassStart    = colDef(show = FALSE)   ,
    ExtractInputVol   = colDef(name = "Extract to Add"       , format = colFormat(suffix = ul   , digits = 1)) ,
    ExtractDiluteWater= colDef(name = "Water to Add"         , format = colFormat(suffix = ul   , digits = 1)) ,  
    LibPrepBy         = colDef(show = FALSE)   ,         
    LibPrepDate       = colDef(show = FALSE)   ,      
    FlowCellType      = colDef(show = FALSE)   ,   
    FlowCellSerial    = colDef(show = FALSE)   ,   
    SeqDevice         = colDef(show = FALSE)   ,   
    Conc_QC1          = colDef(show = FALSE)   ,   
    Conc_QC2          = colDef(show = FALSE)   ,   
    InputMassFinal    = colDef(show = FALSE) ,
    AdjustLibrary     = colDef(show = FALSE)   ,   
    LibraryLoadingVol = colDef(show = FALSE)   ,   
    LibraryWaterVol   = colDef(show = FALSE)   ,   
    SampleID          = colDef(show = FALSE)   ,
    .selection        = colDef(name = "Check when dilution prepared", sticky = "left")
  )
  

columns_rxns <-  list(
  Reagent           = colDef(name = "Reagent"),
  Volume_rxn        = colDef(name = "Volume per Rxn", format = colFormat(suffix = ul,   digits = 1))  ,
  Volume_total      = colDef(name = "Total Volume"  , format = colFormat(suffix = ul,   digits = 1))  ,  
  .selection        = colDef(name = "Check when added", sticky = "left")
)

columns_qc_results <- list(
  TubeNo            = colDef(name = "Tube Number")  ,
  ExtractID         = colDef(name = "Extract ID")   ,
  ExtractConc       = colDef(name = "Extract Concentration", format = colFormat(suffix = ngul , digits = 1)) ,
  Strands           = colDef(show = FALSE)   ,   
  Length            = colDef(show = FALSE)   ,   
  LibPrepBy         = colDef(show = FALSE)   ,         
  LibPrepDate       = colDef(show = FALSE)   ,      
  FlowCellType      = colDef(show = FALSE)   ,           
  FlowCellSerial    = colDef(show = FALSE)   ,           
  SeqDevice         = colDef(show = FALSE)   , 
  InputMassStart    = colDef(show = FALSE)   ,
  ExtractInputVol   = colDef(show = FALSE)   ,
  ExtractDiluteWater= colDef(show = FALSE)   ,  
  Conc_QC1          = colDef(name = "QC 1 Concentration"     , format = colFormat(suffix = ngul, digits = 1))   ,   
  Conc_QC2          = colDef(name = "Final Concentration"    , format = colFormat(suffix = ngul, digits = 1))   ,  
  InputMassFinal    = colDef(name = "Mass to Add"            , format = colFormat(suffix = " ng", digits = 1))  ,
  AdjustLibrary     = colDef(name = "Adjust Library Concentration?"),
  LibraryLoadingVol = colDef(name = "Library Vol to Add"     , format = colFormat(suffix = ul,   digits = 1)),
  LibraryWaterVol   = colDef(name = "Water to Add"           , format = colFormat(suffix = ul,   digits = 1)),  
  SampleID          = colDef(show = FALSE)   
)


columns_final_libraries <- list(
  TubeNo            = colDef(name = "Tube Number")  ,
  ExtractID         = colDef(name = "Extract ID")   ,
  ExtractConc       = colDef(show = FALSE) ,
  Strands           = colDef(show = FALSE)   ,   
  Length            = colDef(show = FALSE)   ,   
  LibPrepBy         = colDef(show = FALSE)   ,         
  LibPrepDate       = colDef(show = FALSE)   ,      
  FlowCellType      = colDef(name = "Flow Cell Type"),           
  FlowCellSerial    = colDef(name = "Flow Cell Serial No."),           
  SeqDevice         = colDef(name = "MinION Name"), 
  InputMassStart    = colDef(show = FALSE)   ,
  ExtractInputVol   = colDef(show = FALSE)   ,
  ExtractDiluteWater= colDef(show = FALSE)   ,  
  Conc_QC1          = colDef(show = FALSE)   ,   
  Conc_QC2          = colDef(name = "Final Concentration"    , format = colFormat(suffix = ngul, digits = 1))   ,  
  InputMassFinal    = colDef(name = "Mass to Add"            , format = colFormat(suffix = " ng", digits = 1)) ,
  AdjustLibrary     = colDef(name = "Adjust Library Concentration?"),
  LibraryLoadingVol = colDef(name = "Library Vol to Add"     , format = colFormat(suffix = ul,   digits = 1)),
  LibraryWaterVol   = colDef(name = "Water to Add"           , format = colFormat(suffix = ul,   digits = 1)),  
  SampleID          = colDef(show = FALSE) 
)

columns_dilute_libraries <- list(
  TubeNo            = colDef(name = "Tube Number")  ,
  ExtractID         = colDef(name = "Extract ID")   ,
  ExtractConc       = colDef(show = FALSE) ,
  Strands           = colDef(show = FALSE)   ,   
  Length            = colDef(show = FALSE)   ,   
  LibPrepBy         = colDef(show = FALSE)   ,         
  LibPrepDate       = colDef(show = FALSE)   ,      
  FlowCellType      = colDef(show = FALSE),           
  FlowCellSerial    = colDef(show = FALSE),           
  SeqDevice         = colDef(show = FALSE), 
  InputMassStart    = colDef(show = FALSE)   ,
  ExtractInputVol   = colDef(show = FALSE)   ,
  ExtractDiluteWater= colDef(show = FALSE)   ,  
  Conc_QC1          = colDef(show = FALSE)   ,   
  Conc_QC2          = colDef(name = "Final Concentration"    , format = colFormat(suffix = ngul, digits = 1))   ,  
  InputMassFinal    = colDef(name = "Mass to Add"            , format = colFormat(suffix = " ng", digits = 1)) ,
  AdjustLibrary     = colDef(name = "Adjust Library Concentration?"),
  LibraryLoadingVol = colDef(name = "Library Vol to Add"     , format = colFormat(suffix = ul,   digits = 1)),
  LibraryWaterVol   = colDef(name = "Water to Add"           , format = colFormat(suffix = ul,   digits = 1)),  
  SampleID          = colDef(show = FALSE)   ,
  .selection        = colDef(name = "Check when dilution prepared", sticky = "left")
)
