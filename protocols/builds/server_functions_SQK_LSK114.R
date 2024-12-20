tab.link <- function(tab1, tab2) {
  observeEvent(input[[paste0(tab1, "_done")]], {nav_select("main.nav", paste0(tab2))})
}

custom.card <- function(type, name) {
  renderUI({page_fluid(card(paste0(type, "Output")(name)))})
}

illustration.card <- function(img) {
  renderUI({page_fluid(accordion(open = FALSE, accordion_panel(title = "Illustration", card(imageOutput(img)))))})
}

illustration2.card <- function(img1, img2) {
  renderUI({page_fluid(accordion(open = FALSE, accordion_panel(title = "Illustration", 
                                                               card(layout_columns(col_widths = 1/2, 
                                                                                   imageOutput(img1), 
                                                                                   imageOutput(img2))))))})
}

ngul        <- " \u006E\u0067\u002F\u00B5\u004C"
ul          <- " \u00B5\u004C"

checklist_js <- JS("
  function(cellInfo) {
    return cellInfo.value === 'no' ? '\u2717' : '\u2713';
  }
")

certainty_js <- JS("function(cellInfo) {
    return cellInfo.value === 'no' ? '\u2753' : '\u2713'
  }")

checklist_r <- function(value) {if (value == 0) "\u2717" else "\u2713"}
certainty_r <- function(value) {if (value == "no") "\u2753" else "\u2713"}

format_select      <- reactableTheme(rowSelectedStyle = list(backgroundColor = "#eee", boxShadow = "inset 2px 0 0 0 #ffa62d"))
format_checklist   <- reactableTheme(rowSelectedStyle = list(backgroundColor = "darkgray"      , color = "#eee"),
                                     rowStyle         = list(backgroundColor = "darkgoldenrod1", borderColor = "black"))

seq_subtable <- function(index) {
  seq_data <- samples.loris %>%
    filter(ExtractID_DNA == samples.loris$ExtractID_DNA[index]) %>%
    select(SequenceID,
           Seq_16sDate,
           LibraryBarcode,
           LibraryFinalConc,
           LibraryCode,
           LibraryPoolVol_ul) %>%
    filter(!is.na(SequenceID))
  
  div(style = "padding: 1rem",
      if (nrow(seq_data) > 0) {
        reactable(seq_data, 
                  outlined = TRUE, 
                  columns = list(
                    SequenceID        = colDef(name = "16S Library"        , maxWidth = 125, align = "left"),
                    Seq_16sDate       = colDef(name = "Date Sequenced"     , maxWidth = 100, align = "left", format = colFormat(date = TRUE)),
                    LibraryBarcode    = colDef(name = "Barcode"            , maxWidth = 100, align = "left"),
                    LibraryFinalConc  = colDef(name = "Final Concentration", maxWidth = 125, align = "left", format = colFormat(suffix = ngul)),
                    LibraryCode       = colDef(name = "Pooled Library ID"  , maxWidth = 100, align = "left"),
                    LibraryPoolVol_ul = colDef(name = "Pooled Library Vol" , maxWidth = 100, align = "left", format = colFormat(suffix = ul))))
      } else {
        div("Not sequenced yet.")
      })
}

columns_samples <- list(
  SampleID          = colDef(name = "Sample"        , maxWidth = 100),
  n_dna_extractions = colDef(name = "DNA"           , maxWidth = 75 , align = "left" , aggregate = "unique", aggregated = checklist_js, cell = checklist_r),
  n_rna_extractions = colDef(name = "RNA"           , maxWidth = 75 , align = "left" , aggregate = "unique", aggregated = checklist_js, cell = checklist_r),
  n_seq_16s         = colDef(name = "16S"           , maxWidth = 75 , align = "left" , aggregate = "unique", aggregated = checklist_js, cell = checklist_r), 
  CollectionDate    = colDef(name = "Date Collected", maxWidth = 100, align = "left" , aggregate = "frequency", format = colFormat(date = TRUE)),
  Subject           = colDef(name = "Name"          , maxWidth = 80 , align = "left" , aggregate = "frequency"),
  Subj_Certainty    = colDef(name = "Confirmed"     , maxWidth = 80 , align = "right", aggregate = "unique", aggregated = certainty_js, cell = certainty_r),
  ExtractID_DNA     = colDef(name = "DNA Extracts"  , maxWidth = 125, align = "left" , aggregate = "count"),
  ExtractDate_DNA   = colDef(name = "Date Extracted", maxWidth = 100, align = "left" , format = colFormat(date = TRUE)),
  ExtractConc_DNA   = colDef(name = "Concentration" , maxWidth = 125, align = "left" , format = colFormat(suffix = ngul)),
  ExtractedBy_DNA   = colDef(name = "Extracted By"  , maxWidth = 100, align = "left" ),
  ExtractKit_DNA    = colDef(name = "Extraction Kit", maxWidth = 150, align = "left" ),
  ExtractBox_DNA    = colDef(name = "Storage Box"   , maxWidth = 150, align = "left" ),
  ExtractNotes_DNA  = colDef(name = "Notes"         , maxWidth = 200, align = "left" ),
  SequenceID        = colDef(show = FALSE),
  Seq_16sDate       = colDef(show = FALSE),
  LibraryBarcode    = colDef(show = FALSE),
  LibraryFinalConc  = colDef(show = FALSE),
  LibraryCode       = colDef(show = FALSE),
  LibraryPoolVol_ul = colDef(show = FALSE),
  .selection        = colDef(name =  "Check Extract Rows to Include", sticky = "left"))

column_groups <- list(colGroup(name    = "Extracted/Sequenced", columns = c("n_dna_extractions", "n_rna_extractions", "n_seq_16s")), 
                      colGroup(name    = "Subject"            , columns = c("Subject", "Subj_Certainty")))

new.value <- function(data, column, input_id) {
  observeEvent(input[[input_id]], {
    req(data$data)
    value <- input[[input_id]]
    if (is.null(value) || value == "") {
      showNotification(paste(column, "input is invalid"), type = "error")
      return()
    }
    data$data <- data$data %>%
      mutate(!!rlang::sym(column) := value)
  })
}

