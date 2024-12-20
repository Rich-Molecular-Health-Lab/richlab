# observers.R

observe_steps <- function(input, output, session, steps, step_data) {
  imap(steps, ~ {
    step_name    <- .y
    step_content <- .x
    main_step    <- step_content[[1]]
    
    observeEvent(input[[paste0("check_", step_name)]], {
      timestamp <- paste(format(Sys.time(), "%Y-%m-%d %H:%M:%S"))
      
      toggleCssClass(id        = paste0("step_", step_name), 
                     class     = "bg-secondary", 
                     condition = input[[paste0("check_", step_name)]])
      
      output[[paste0("stamp_", step_name)]] <- renderText({
        if (input[[paste0("check_", step_name)]]) {
          paste(timestamp)
        } else {
          NULL
        }
      })
      
      step_data[[step_name]]$timestamp <- paste0("Completed at ", timestamp)
    })
    
    observeEvent(input[[paste0("submit_", step_name)]], {
      timestamp <- paste(format(Sys.time(), "%Y-%m-%d %H:%M:%S"))
      
      output[[paste0("note_", step_name)]] <- renderText({
        if (!is.null(input[[paste0("text_", step_name)]])) {
          paste(timestamp, input[[paste0("text_", step_name)]])
        } else {
          ""
        }
      })
      
      # Update note in reactiveValues
      step_data[[step_name]]$note <- paste0(
        "Note recorded at", timestamp, ": ", input[[paste0("text_", step_name)]] 
      )
    })
  })
}

count_controls <- function(input, n_controls) {
  observeEvent(input$add_controls, {
    n_controls(as.integer(input$add_controls %||% 0))
  })
}

select_samples <- function(samples.loris, data, n_controls) {
  
  observeEvent(getReactableState("samples", "selected"), {
    selected <- getReactableState("samples", "selected") %||% integer(0)
    
    if (length(selected) == 0) {
      message("No rows selected.")
      return(NULL)
    }

    selected_rows <- samples.loris[selected, ] %>%
      tibble() %>%
      mutate(TubeNo = row_number()) %>%
      select(TubeNo,
             ExtractID   = ExtractID_DNA,
             ExtractConc = ExtractConc_DNA,
             SampleID)
    
    control_rows <- tibble(
      TubeNo             = NA_integer_,
      ExtractID          = "Control",
      ExtractConc        = 0,
      Strands            = NA_real_,
      Length             = NA_real_,
      LibPrepBy          = NA_character_,
      LibPrepDate        = as.Date(NA),
      FlowCellType       = NA_character_,
      FlowCellSerial     = NA_character_,
      SeqDevice          = NA_character_,
      InputMassStart     = NA_real_,
      InputMassFinal     = NA_real_,
      ExtractInputVol    = NA_real_,
      ExtractDiluteWater = NA_real_,
      Conc_QC1           = NA_real_,
      Conc_QC2           = NA_real_,
      AdjustLibrary      = NA_character_,
      LibraryLoadingVol  = NA_real_,
      LibraryWaterVol    = NA_real_,
      SampleID           = "LibControl"
    ) %>%
      slice(rep(1, n_controls())) %>%
      mutate(TubeNo = nrow(selected_rows) + row_number())
    
    data$libraries <- data$libraries %>% 
      filter(!(ExtractID %in% selected_rows$ExtractID)) %>%
      filter(ExtractID != "Control") %>%
      rows_append(selected_rows) %>%
      bind_rows(control_rows)
  })
}

observe_strands <- function(input, strands, InputMassStart, calculate_mass_start, fragment_type, Length) {
  observeEvent(input$strands, {
    strands(as.numeric(input$strands))
    InputMassStart(calculate_mass_start(fragment_type(), Length(), strands()))
  })
}

observe_type <- function(input, data, fragment_type, Length, strands, calculate_length, InputMassStart, calculate_mass_start) {
  observeEvent(input$fragments, {
    fragment_type(as.numeric(input$fragments))
    Length(calculate_length(fragment_type()))
    InputMassStart(calculate_mass_start(fragment_type(), Length(), strands()))
  })
}

observe_exp_submit <- function(input, data, file_prefix) {
  observeEvent(input$exp_submit, {
    data$libraries <- data$libraries %>%
      mutate(LibPrepBy      = input$author,
             LibPrepDate    = input$exp_date,
             FlowCellType   = input$flowcell_type,
             FlowCellSerial = input$flowcell_num,
             SeqDevice      = input$minion)
    
    last_name     <- str_extract(input$author, "\\w+(?=\\s)")
    
    file_prefix(paste0(last_name, "_", input$exp_date))
  })
}

observe_length <- function(input, data, Length, fragment_type, strands, InputMassStart, calculate_mass_start) {
  observeEvent(input$fragment_length, {
    new_length <- as.numeric(input$fragment_length)
    if (!identical(new_length, Length())) {
      Length(new_length)
      InputMassStart(calculate_mass_start(fragment_type(), Length(), strands()))
    }
  })
}

observe_input <- function(input, data, InputMassStart) {
  observeEvent(input$mass_confirmed, {
    new_mass <- as.numeric(input$mass_confirmed)
    if (!identical(new_mass, InputMassStart())) {
      InputMassStart(new_mass)
    }
  })
}

observe_recalculate <- function(input, 
                                data, 
                                n_rxns, 
                                rxns, 
                                rxn_vols, 
                                TemplateVolPrep, 
                                TemplateVolLoading, 
                                InputMassStart, 
                                InputMassFinal, 
                                calculate_mass_final,
                                fragment_type,
                                Length,
                                strands
                                ) {
  observeEvent(input$recalculate, {
    
    n_rxns(nrow(data$libraries))
    
    req(n_rxns())
    rxns$endprep  <- rxn_vols(rxns$endprep , n_rxns())
    rxns$adapter  <- rxn_vols(rxns$adapter , n_rxns())
    rxns$fc_prime <- rxn_vols(rxns$fc_prime, n_rxns())
    rxns$fc_load  <- rxn_vols(rxns$fc_load , n_rxns())
    
    TemplateVolPrep(rxns$endprep    %>% filter(Reagent == "DNA Template") %>% pull(Volume_rxn) %||% 1)
    TemplateVolLoading(rxns$fc_load %>% filter(Reagent == "DNA Template") %>% pull(Volume_rxn) %||% 1)
    
    InputMassStart(as.numeric(input$mass_confirmed))
    InputMassFinal(calculate_mass_final(fragment_type(), Length(), strands()))
    
    data$libraries <- data$libraries %>%
      mutate(LibPrepBy      = input$author,
             LibPrepDate    = input$exp_date,
             FlowCellType   = input$flowcell_type,
             FlowCellSerial = input$flowcell_num,
             SeqDevice      = input$minion) %>%
      mutate(
        Strands        = strands(),
        Length         = Length(),
        InputMassStart = InputMassStart(),
        InputMassFinal = InputMassFinal())  %>%
      mutate(ExtractInputVol    = if_else((InputMassStart/ExtractConc) >= TemplateVolPrep(), TemplateVolPrep(), InputMassStart/ExtractConc)) %>%
      mutate(ExtractDiluteWater = TemplateVolPrep() - ExtractInputVol)
  })
}


QC1_observer <- function(input, data) {
  observeEvent(input$confirm_qc1, {
    req(data$libraries$TubeNo)  
    data$libraries <- data$libraries %>%
      mutate(Conc_QC1 = map_dbl(TubeNo, ~ input[[paste0("QC1_", .x)]] %||% NA_real_))
  })
}

QC2_observer <- function(input, data, TemplateVolLoading) {
  observeEvent(input$confirm_qc2, {
    req(data$libraries$TubeNo)  
    data$libraries <- data$libraries %>%
      mutate(Conc_QC2 = map_dbl(TubeNo, ~ input[[paste0("QC2_", .x)]] %||% NA_real_)) %>%
      mutate(
        AdjustLibrary = case_when(
          (InputMassFinal / Conc_QC2) > TemplateVolLoading() ~ "Enrich",
          (InputMassFinal / Conc_QC2) == TemplateVolLoading() ~ "None",
          (InputMassFinal / Conc_QC2) < TemplateVolLoading() ~ "Dilute",
          TRUE ~ NA_character_
        ),
        LibraryLoadingVol = if_else(
          (InputMassFinal / Conc_QC2) >= TemplateVolLoading(),
          TemplateVolLoading(),
          (InputMassFinal / Conc_QC2)
        ),
        LibraryWaterVol = TemplateVolLoading() - LibraryLoadingVol
      )
  })
}

report_observer <- function(input, output, step_data, file_prefix) {
  observeEvent(input$generate_report, {
    req(input$author, input$exp_date, step_data, file_prefix())
    
    steps <- isolate(reactiveValuesToList(step_data))
    
    output$step_progress <- renderUI({
      req(steps)
      tagList(
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
        paste0(file_prefix(), "_report.html")
      },
      content = function(file) {
        tempReport <- file.path(tempdir(), "report.Rmd")
        template <- paste0(params$base_path, "resources/report.Rmd")
        file.copy(template, tempReport, overwrite = TRUE)
        
        params <- list(
          author = input$author,   
          date   = input$exp_date,
          steps  = steps
        )
        
        # Render R Markdown report
        rmarkdown::render(
          tempReport, 
          output_file = file,
          params      = params,
          envir       = new.env(parent = globalenv())
        )
      }
    )
  })
}