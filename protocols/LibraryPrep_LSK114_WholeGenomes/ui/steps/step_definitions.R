# step_definitions.R
source(paste0(params$base_path, "ui/steps/endprep_steps.R"))
source(paste0(params$base_path, "ui/steps/adapter_steps.R"))
source(paste0(params$base_path, "ui/steps/cleanup_steps.R"))
source(paste0(params$base_path, "ui/steps/flowcell_steps.R"))

make_steps <- function(nested_steps) {
  imap(nested_steps, ~ {
    step_name    <- .y
    step_content <- .x
    main_step    <- step_content[[1]]
    substeps     <- step_content[-1]
    
    substep_list <- if (length(substeps) > 0) {
      tags$ol(
        map(names(substeps), ~ tags$li(substeps[[.x]])),
        style = "list-style-type: lower-alpha;"
      )
    } else {
      NULL
    }
    
    card(
      id = paste0("step_", step_name),
      class = "bg-primary",
      card_header(textOutput(outputId = paste0("stamp_", step_name))),
      layout_sidebar(
        fillable = TRUE,
        sidebar = sidebar(
          open = FALSE,
          textAreaInput(inputId = paste0("text_", step_name), label = "Add note"),
          actionButton(inputId = paste0("submit_", step_name), label = "Enter note"),
          textOutput(outputId = paste0("note_", step_name))
        ),
        layout_columns(
          col_widths = c(1, 2, 9),
          checkboxInput(inputId = paste0("check_", step_name), label = ""),
          tags$h5(step_name),
          tagList(
            tags$h5(main_step),
            substep_list
          )
        ),
        layout_columns(
          col_widths = c(12),
          uiOutput(outputId = paste0("card_", step_name))
        )
      )
    )
  })
}