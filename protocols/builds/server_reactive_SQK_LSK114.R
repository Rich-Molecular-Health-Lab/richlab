
observeEvent(input$setup_done    , {nav_select("main.nav", "endprep" )})
observeEvent(input$endprep_done  , {nav_select("main.nav", "adapter" )})
observeEvent(input$adapter_done  , {nav_select("main.nav", "cleanup" )})
observeEvent(input$cleanup_done  , {nav_select("main.nav", "flowcell")})
observeEvent(input$flowcell_done , {nav_select("main.nav", "closer"  )})

strands  <- reactive({
  req(input$strands)
  as.numeric(input$strands)
})

n_rxns <- reactive({
  req(selected())
  length(selected())
})

est_length            <- reactive({
  req(input$fragments)
  case_when(input$fragments == "1" ~ 10000,
            input$fragments == "2" ~ 900,
            input$fragments == "3" ~ 2000,
            input$fragments == "4" ~ 7000,
            input$fragments == "5" ~ 10000)})

InputMassStartSuggest <- reactive({
  req(strands(), input$fragments, input$fragment_length)
  case_when(
    input$fragments == "1" ~ 1000,
    input$fragments == "2" ~ (200 * ((input$fragment_length * (307.97*strands())) + (18.02*strands())) * 10^-6),
    input$fragments == "3" ~ (150 * ((input$fragment_length * (307.97*strands())) + (18.02*strands())) * 10^-6),
    input$fragments == "4" ~ (100 * ((input$fragment_length * (307.97*strands())) + (18.02*strands())) * 10^-6),
    input$fragments == "5" ~ 1000)})

selected <- reactive(getReactableState("samples", "selected"))

conc_start <- reactive({
  req(selected_samples())
  tibble(TubeNo          = selected_samples()$TubeNo, 
         ExtractConc_DNA = selected_samples()$ExtractConc_DNA)
})

Conc_QC1 <- reactive({
  req(selected_samples())
  map_dbl(selected_samples()$TubeNo, ~ {
    req(input[[paste0("qc1_", .x)]])
    input[[paste0("qc1_", .x)]]
  })
})

Conc_QC2 <- reactive({
  req(selected_samples())
  map_dbl(selected_samples()$TubeNo, ~ {
    req(input[[paste0("qc2_", .x)]])
    input[[paste0("qc2_", .x)]]
  })
})


QC_df <- reactive({
  req(conc_start(), Conc_QC1(), Conc_QC2())
  tibble(
    TubeNo          = conc_start()$TubeNo,
    ExtractConc_DNA = conc_start()$ExtractConc_DNA,
    Conc_QC1        = Conc_QC1(),
    Conc_QC2        = Conc_QC2()
  )
})


endprep_rxn <- reactive({
  endprep_tbl <- map_dbl(endprep_vol_per_rxn, \(x) x * n_rxns()) %>%
    bind_cols(list_simplify(endprep_reagents), 
              list_simplify(endprep_vol_per_rxn)) %>%
    relocate("...2", "...3", "...1") %>%
    arrange("...3")
  
  colnames(endprep_tbl) <- c("Reagent", "Volume_pRxn", "Total_Volume")
  
  endprep_tbl %>%
    summarize(Volume_pRxn    = sum(Volume_pRxn),
              Total_Volume   = sum(Total_Volume)) %>%
    mutate(Reagent = "Total") %>%
    bind_rows(endprep_tbl) %>%
    arrange(Volume_pRxn) %>%
    select(Reagent,
           Volume_pRxn,
           Total_Volume)
})
