# ui_logic.R
base_path  <- paste0(params$base_path)
local_path <- paste0(params$local)


samples_count_ui <- function(input, output, samples.loris) {
  output$samples_count <- renderText({
    req(input$add_controls, samples.loris)
    
    selected <- getReactableState("samples", "selected")
    if (is.null(selected)) {
      selected <- integer(0)  
    }
    
    total_selected <- length(selected)
    n_controls <- input$add_controls %||% 0
    
    paste0("Total Selected: ", total_selected, " (+ ", n_controls, " Controls)")})
}

adjust_length_ui <- function(output, Length) {
  output$adjust_length <- renderUI({
    req(Length())  # Ensure input exists
    sliderInput(
      "fragment_length", 
      "Adjust Length (bp) if needed", 
      min   = 100, 
      max   = 20000, 
      value = Length())})
}

adjust_input_ui <- function(output, InputMassStart) {
  output$adjust_input <- renderUI({
    req(InputMassStart())
    numericInput(
      "mass_confirmed", 
      "Adjust input mass (ng)", 
      value = InputMassStart(),  
      min   = 1, 
      max   = 2000)})
}

checklist_tubes_ui <- function(output, data) {
  output$checklist_tubes <- renderUI({
    req(data$libraries$TubeNo)
    tagList(
      checkboxGroupInput(
        inputId = "add_rxnmix",
        label   = "Check when Reaction Mix Added to Tube",
        choices = c(data$libraries$TubeNo),
        inline  = TRUE,
        width   = "100%"),
      checkboxGroupInput(
        inputId = "add_template",
        label   = "Check when Template Added to Tube",
        choices = c(data$libraries$TubeNo),
        inline  = TRUE,
        width   = "100%"))})
}

QC1_input_with_check <- function(TubeNo, ExtractConc) {
  div(
    style = "display: flex; align-items: center; margin-bottom: 10px;",  
    div(
      style = "margin-right: 10px;",  
      numericInput(
        inputId = paste0("QC1_", TubeNo),
        label   = paste0("Tube ", TubeNo),
        value   = ExtractConc,
        min     = 0,
        max     = 1000)),
    checkboxInput(
      inputId = paste0("QC1_check_", TubeNo),
      label = NULL  ))
}


QC1_input_render <- function(output, data, QC1_input_with_check) {
  output$qc1_result <- renderUI({
    req(data$libraries$TubeNo, data$libraries$ExtractConc)
    fluidRow(
      pmap(
        data$libraries %>% select(TubeNo, ExtractConc),  
        QC1_input_with_check),
      actionButton("confirm_qc1", "Confirm QC1 Values"))})
}

QC2_input_with_check <- function(TubeNo, Conc_QC1) {
  div(
    style = "display: flex; align-items: center; margin-bottom: 10px;",  
    div(
      style = "margin-right: 10px;",  
      numericInput(
        inputId = paste0("QC2_", TubeNo),
        label   = paste0("Tube ", TubeNo),
        value   = Conc_QC1,
        min     = 0,
        max     = 1000)),
    checkboxInput(
      inputId = paste0("QC2_check_", TubeNo),
      label = NULL  ))
}

QC2_input_render <- function(output, data, QC2_input_with_check) {
  output$qc2_result <- renderUI({
    req(data$libraries$TubeNo, data$libraries$Conc_QC1)
    fluidRow(
      pmap(
        data$libraries %>% select(TubeNo, Conc_QC1),  
        QC2_input_with_check),
      actionButton("confirm_qc2", "Confirm QC2 Values"))})
}