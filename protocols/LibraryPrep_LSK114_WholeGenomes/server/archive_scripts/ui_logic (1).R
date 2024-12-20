make_steps <- function(nested_steps) {
  stopifnot(is.list(nested_steps))
  imap(nested_steps, ~ {
    step_name    <- .y
    step_content <- .x
    main_step    <- step_content[[1]]
    substeps     <- step_content[-1]
    
    substep_list <- if (length(substeps) > 0) {
      tags$ol(
        lapply(names(substeps), ~ tags$li(substeps[[.x]])),
        style = "list-style-type: lower-alpha;"
      )
    } else {
      NULL
    }
    
    card(
      id    = paste0("step_", step_name),
      class = "bg-primary",
      card_header(textOutput(outputId = paste0("stamp_", step_name))),
      layout_sidebar(
        fillable = TRUE,
        sidebar  = sidebar(open = FALSE,
                           textAreaInput(inputId = paste0("text_"  , step_name), label = "Add note"),
                           actionButton(inputId = paste0("submit_", step_name), label = "Enter note"),
                           textOutput(outputId = paste0("note_"  , step_name))),
        layout_columns(
          col_widths = c(1, 2, 9),
          checkboxInput(inputId = paste0("check_" , step_name), label = ""),
          tags$h5(step_name),
          tagList(tags$h5(main_step), substep_list))))
  })
}


samples_count_ui <- function(input, output) {
  selected_active <- reactive({
    getReactableState("samples", "selected")
  })
    output$samples_count <- renderText({
    total_selected <- length(selected_active())
    n_controls <- input$add_controls %||% 0  
    paste0("Total Selected: ", total_selected, " (+ ", n_controls, " Controls)")
  })
}

adjust_length_ui <- function(output, est_length) {
  output$adjust_length <- renderUI({
    sliderInput(
      "fragment_length", 
      "Adjust Length (bp) if needed", 
      min = 100, 
      max = 20000, 
      value = est_length()
    )
  })
}

adjust_input_ui <- function(output, InputMassStartSuggest) {
  output$adjust_input <- renderUI({ 
    numericInput(
      "mass_confirmed", 
      "Adjust input mass (ng) here (optional)", 
      value = InputMassStartSuggest(), 
      min = 1, 
      max = 2000
    )
  })
}

checklist_tubes_ui <- function(output, data) {
  output$checklist_tubes <- renderUI({
    req(data$libraries$TubeNo)
    card(
      card_header("Check as you add to each"),
      checkboxGroupInput(
        inputId = "add_rxnmix",
        label   = "Reaction Mix Added",
        choices = c(data$libraries$TubeNo),
        inline  = TRUE,
        width   = "100%"
      ),
      checkboxGroupInput(
        inputId = "add_template",
        label   = "Template Added",
        choices = c(data$libraries$TubeNo),
        inline  = TRUE,
        width   = "100%"
      )
    )
  })
}

qc_result_ui <- function(output, data, column_name, prefix) {
  output[[paste0(prefix, "result")]] <- renderUI({
    req(data$libraries, data$libraries[[column_name]])
    map2(
      data$libraries$TubeNo, 
      data$libraries[[column_name]], 
      ~ numericInput(
        inputId = paste0(prefix, .x),
        label   = paste("Tube", .x, "in ng/ul"),
        value   = .y,
        min     = 0
      )
    )
  })
}