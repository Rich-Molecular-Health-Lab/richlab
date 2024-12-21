#report_logic.R

report_observer <- function(input, output, data, rxns, n_rxns, step_data, report_params, sample.list, all_samples) {
  observeEvent(input$generate_report, {
    
    req(n_rxns(), rxns$endprep, rxns$adapter, rxns$fc_load, rxns$fc_prime)
    endprep.tbl <- rxns$endprep %>% mutate(step = "DNA Repair and Endprep")
    adapter.tbl <- rxns$adapter %>% mutate(step = "Adapter Ligation")
    fcload.tbl  <- rxns$fc_load %>% mutate(step = "Flow Cell Loading")
    fcprime.tbl <- rxns$fc_prime %>% mutate(step = "Flow Cell Priming")
    combined_tbl <- bind_rows(endprep.tbl, adapter.tbl, fcload.tbl, fcprime.tbl) %>%  mutate(N = n_rxns())
    report_params$rxns <- combined_tbl

   req(sample.list, data$libraries)
   report_params$libraries <- data$libraries %>%
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
   
   req(input$library_code)
   report_params$LibraryCode <- input$library_code
   
   req(step_data)
   report_params$steps <- isolate(step_data)
   
   output$step_progress <- renderUI({
     req(report_params$steps, report_params$setup_note)
     steps <- reactiveValuesToList(report_params$steps)
     tagList(
       if (!is.null(report_params$setup_note)) tags$blockquote(report_params$setup_note),
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
   
   output$download_report <- downloadHandler(
     filename = function() {
       paste0("experiment_report_", Sys.Date(), ".html")
     },
     content = function(file) {
       tempReport <- file.path(tempdir()    , "report.Rmd")
       template   <- paste0(params$base_path, "resources/report.Rmd")
       
       file.copy(template, tempReport, overwrite = TRUE)
       
       req(report_params)
       params <- isolate(reactiveValuesToList(report_params))
       
       rmarkdown::render(
         input       = tempReport, 
         output_file = file,
         params      = params,
         envir       = new.env(parent = globalenv())
       )
     })
   
   output$download_csv <- downloadHandler(
     filename = function() {
       paste0("samples_loris_updated_", Sys.Date(), ".csv")
     },
     content  = function(file) { 
       req(all_samples, report_params$libraries)
       updated_samples <- bind_rows(all_samples, isolate(report_params$libraries))
       
       write.csv(updated_samples, file, row.names = FALSE)
     }
   )
   
  })
}
