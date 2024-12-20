source(paste0(params$local, "protocols/builds/Supplies_SQK_LSK114.R"))
source(paste0(params$local, "protocols/builds/FlowCellCheck_SQK_LSK114.R"))
source(paste0(params$local, "protocols/builds/Input_SQK_LSK114.R"))
source(paste0(params$local, "protocols/builds/KitContents_SQK_LSK114.R"))
source(paste0(params$local, "protocols/builds/RxnMix_EndPrep_SQK_LSK114.R"))
source(paste0(params$local, "protocols/builds/RxnMix_AdapterLigation_SQK_LSK114.R"))
source(paste0(params$local, "protocols/builds/RxnMix_FlowCell_SQK_LSK114.R"))
source(paste0(params$local, "protocols/builds/ProtocolSteps_SQK_LSK114.R"))
source(paste0(params$local, "protocols/builds/parameters.R"))
source(paste0(params$local, "protocols/builds/server_data_SQK_LSK114.R"))
source(paste0(params$local, "protocols/builds/server_functions_SQK_LSK114.R"))

make_steps <- function(nested_steps) {
  imap(nested_steps, ~ {
    step_name    <- .y
    step_content <- .x
    main_step    <- step_content[[1]]
    substeps     <- step_content[-1]  
    substep_list <- if (length(substeps) > 0) {
      tags$ol(
        lapply(names(substeps), function(substep_name) {tags$li(substeps[[substep_name]])}),
        style = "list-style-type: lower-alpha;")
    } else {NULL}
    
    card(id = paste0("step_", step_name), class = "bg-primary",
         card_header(textOutput(outputId = paste0("stamp_", step_name))),
         layout_sidebar(fillable = TRUE,
                        sidebar = sidebar(
                          open = FALSE,
                          textAreaInput(inputId = paste0("text_", step_name) , label = "Add note"),
                          actionButton(inputId = paste0("submit_", step_name), label = "Enter note"),
                          textOutput(outputId = paste0("note_", step_name))),   
                        layout_columns(
                          col_widths = c(1, 2, 9),
                          checkboxInput(inputId = paste0("check_", step_name), label = ""),
                          tags$h5(step_name),
                          tagList(
                            tags$h5(main_step),
                            substep_list
                          )),
                        layout_columns(col_widths = c(12),
                                       uiOutput(outputId = paste0("card_", step_name))
                        )
         )
    )
  })
}

