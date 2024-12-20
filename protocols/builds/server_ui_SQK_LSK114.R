walk(step_names, ~ {
  id <- .x  
  observeEvent(input[[paste0("check_", id)]], {
    toggleCssClass(
      id = paste0("step_", id),
      class = "bg-secondary",
      condition = input[[paste0("check_", id)]])
    
    output[[paste0("stamp_", id)]] <- renderText({
      if (input[[paste0("check_", id)]]) {
        paste(format(Sys.time(), "%Y-%m-%d %H:%M:%S"))
      } else {
        ""  
      }})})})

walk(step_names, ~ {
  id <- .x  
  observeEvent(input[[paste0("submit_", id)]], {
    output[[paste0("note_", id)]] <- renderText({
      if (input[[paste0("submit_", id)]]) {
        paste(format(Sys.time(), "%Y-%m-%d %H:%M:%S"), input[[paste0("text_", id)]])
      } else {
        ""
      }})})})

output$supplies_all      <- render_gt(gt_supplies)
output$kit_contents      <- render_gt(SQK.LSK114.contents)
output$supplies_endprep  <- render_gt(supplies_endprep)
output$supplies_adapter  <- render_gt(supplies_adapter)
output$supplies_cleanup  <- render_gt(supplies_cleanup)
output$supplies_flowcell <- render_gt(supplies_flowcell)
output$input_dna         <- render_gt(input_dna)
output$flowcell_check    <- render_gt(flowcell_check)
output$rxn_endprep       <- render_gt(rxn_endprep)
output$rxn_adapter       <- render_gt(rxn_adapter)
output$rxn_flowcell      <- render_gt(rxn_flowcell)
output$rxn_sequence      <- render_gt(rxn_sequence)


output$adjust_length <- renderUI({
  req(est_length())
  sliderInput("fragment_length", "Adjust Length (bp) if needed", min = 100, max =  20000, value = est_length())
})

output$adjust_input <- renderUI({ 
  req(InputMassStartSuggest())
  numericInput("input_confirmed", "Adjust input mass (ng) here (optional)", value = InputMassStartSuggest(), min = 1, max = 2000)
})

output$checklist_tubes <- renderUI({
  card(
    card_header("Check as you add to each"),
    checkboxGroupInput(
      inputId = "add_rxnmix",
      label   = "Reaction Mix Added",
      choices = c(1:n_rxns()),
      inline  = TRUE,
      width   = "100%"),
    checkboxGroupInput(
      inputId = "add_template",
      label   = "Template Added",
      choices = c(1:n_rxns()),
      inline  = TRUE,
      width   = "100%")
  )
})


generate_qc_inputs <- function(input_prefix, conc_data) {
  layout_column_wrap(
    map(1:nrow(conc_data), \(idx) {
      numericInput(
        inputId = paste0(input_prefix, "_"       , conc_data$TubeNo[idx]),
        label   = paste0("Concentration of Tube ", conc_data$TubeNo[idx]),
        value   = conc_data$ExtractConc_DNA[idx],
        min     = 0,
        max     = 200
      )
    })
  )
}

output$qcresult1 <- renderUI({
  req(conc_start())
  card(
    card_header("Enter QC1 Results Below:"),
    generate_qc_inputs("qc1", conc_start())
  )
})

output$qcresult2 <- renderUI({
  req(conc_start())
  card(
    card_header("Enter QC2 Results Below:"),
    generate_qc_inputs("qc2", conc_start())
  )
})