initialize_step_data <- function(steps) {
  step_data <- reactiveValues()
  imap(steps, ~ {
    
    step_name    <- .y
    step_content <- .x
    main_step    <- step_content[[1]]
    
    step_data[[step_name]] <- reactiveValues(
      detail    = main_step,
      note      = NULL,
      timestamp = NULL
    )
  })
  
  return(step_data)
}

observe_rxns <- function(report_params, rxns, n_rxns) {
  n_rxns <- isolate(n_rxns())
  
  endprep.tbl <- isolate(rxns$endprep ) %>% mutate(step = "DNA Repair and Endprep") 
  adapter.tbl <- isolate(rxns$adapter ) %>% mutate(step = "Adapter Ligation") 
  fcload.tbl  <- isolate(rxns$fc_load ) %>% mutate(step = "Flow Cell Loading") 
  fcprime.tbl <- isolate(rxns$fc_prime) %>% mutate(step = "Flow Cell Priming") 
  
  report_params$rxns <- bind_rows(endprep.tbl,
                                  adapter.tbl,
                                  fcload.tbl,
                                  fcprime.tbl) %>%
    mutate(N = n_rxns)
}

update_params <- function(input, report_params, data, step_data, sample.list) {
  observeEvent(input$generate_report, {
   req(input$library_code)
    
   report_params$libraries <- isolate(data$libraries) %>%
     mutate(SequenceID     = str_glue("{SampleID}", "-S", "{TubeNo}"),
            LibraryBarcode = NA,
            Pipeline       = "BacterialWGS",
            LibraryCode    = paste(input$library_code)
     ) %>%
     select(LibraryTube   = TubeNo,
            ExtractID_DNA = ExtractID,
            SequenceID,
            Seq_16sDate   = LibPrepDate,
            Pipeline,
            LibraryBarcode,
            LibraryFinalConc  = Conc_QC2,
            LibraryPoolVol_ul = LibraryLoadingVol,
            LibraryCode) %>%
     left_join(sample.list, by = join_by(ExtractID_DNA))
   
   report_params$steps       <- isolate(step_data)
   
   report_params$LibraryCode <- input$library_code
  })
}

report_observer <- function(input, output, report_params, sample.list, updated_samples) {
  observeEvent(input$generate_report, {
    
    updated_samples() <- isolate(reactiveValuesToList(report_params$libraries)) %>%
      tibble() %>%
      bind_rows(sample.list)
    
    steps           <- isolate(reactiveValuesToList(report_params$steps))

    output$step_progress <- renderUI({
      req(report_params$setup_note)
      tagList(
        tags$blockquote(report_params$setup_note),
        tags$ol(
          lapply(steps, function(step) {
            tagList(
              tags$li(step$detail),
              tags$p(step$timestamp),
              if (!is.null(step$note)) tags$blockquote(step$note),
              tags$hr()
            )
          })
        )
      )
    })
  })
}