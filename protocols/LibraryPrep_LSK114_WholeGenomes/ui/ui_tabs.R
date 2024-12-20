# ui_tabs.R
setup_tab <- function() {
  nav_panel("Setup", value = "start_page",
    accordion(open = F,
          accordion_panel(title = "Protocol Overview",
              card(navset_card_tab( 
                nav_panel("Equipment and Materials", 
                          gt_output(outputId = "supplies_all")), 
                nav_panel( "Input DNA", 
                           gt_output(outputId = "input_dna")), 
                nav_panel("SQK-LSK114 Contents", 
                          layout_columns(col_widths = c(4, 8), 
                                         full_screen = T,
                                         card(gt_output(outputId = "kit_contents")), 
                                         card(imageOutput("LSK114_tubes")))))
                                      ))),
            card(card_header("Setup Basics"),
              card(card_header(numericInput("add_controls", "N Controls to Include", value = 0, min = 0, max = 10)),
                    accordion(accordion_panel(id = "select_samples", 
                                              title = "Select sample extracts to include", 
                                              reactableOutput("samples"))),
                 card_footer(layout_column_wrap(
                   textOutput("samples_count", inline = TRUE)))), 
              layout_column_wrap(
                radioButtons("strands", "DNA Type", choices = list("dsDNA (nuclear DNA)" = 2, "ssDNA (mtDNA)" = 1), selected = 2),
                radioButtons("fragments", "Input Length", choices = input_options, selected = 1),
              ),
              layout_column_wrap(
                dateInput("exp_date", "Start Date", value = Sys.Date(), format = "yyyy-mm-dd"),
                selectInput("author", "Your Name", lab.members),
                selectizeInput("assist", "Others Assisting", lab.members, multiple = T, selected = "NA")),
              layout_column_wrap(
                selectInput("flowcell_type", "Flow Cell Type", choices = c("Flongle", "MinION", "PromethION")),
                textInput("flowcell_num", "Flow Cell Serial Num", value = "SERIAL"),
              selectInput("minion", "Device Name", choices = c("Angel", "Spike"))),
            actionButton("exp_submit", "Confirm Setup/Sample Choices"),
            card(
              card_header("Adjust target length or input mass (optional):"),
                uiOutput("adjust_length"),
                uiOutput("adjust_input")),
            card(
              card_header("Setup Summary", actionButton("recalculate", "Calculate/Recalculate Values")),
              reactableOutput("setup_summary")),
            textAreaInput("start_note", "Notes/Comments (Optional)"),
            actionButton("submit_start_note", label = "Enter note"),
            textOutput("start_note_submitted"),
            actionButton("setup_done", "Next: Begin Protocol"))
)}

endprep_tab <- function() {
  nav_panel("I. DNA Repair and End Prep", value = "endprep",
            card(
              card_header("I. DNA Repair and End Prep"),
              accordion(open = F, 
                        accordion_panel("Materials", gt_output(outputId = "supplies_endprep")), endprep.recs,
                        accordion_panel("Sample Dilutions and Concentrations", reactableOutput("extract_prep"))),
              make_steps(endprep),
              card_footer(actionButton("endprep_done", "Next: Adapter Ligation"))
            )
  )
}

adapter_tab <- function() {
  nav_panel("II. Adapter Ligation", value = "adapter",
            card(
              card_header("II. Adapter Ligation"),
              accordion(open = F, 
                        accordion_panel("Materials", gt_output(outputId = "supplies_adapter")), adapter.recs),
              make_steps(adapter),
              card_footer(actionButton("adapter_done", "Next: Library Cleanup"))
          )
  )
}

cleanup_tab <- function() {
  nav_panel("III. Library Clean-up", value = "cleanup",
            card(
              card_header("III. Library Clean-up"),
              accordion(open = F, 
                        accordion_panel("Materials", gt_output(outputId = "supplies_cleanup")),
                        accordion_panel("Quality Control Results", reactableOutput("qc_results"))),
              make_steps(cleanup),
              card_footer(actionButton("cleanup_done", "Next: Prime/Load Flow Cell"))))
}

flowcell_tab <- function() {
  nav_panel("IV. Prime and Load Flow Cell", value = "flowcell",
            card(
              card_header("IV. Prime and Load Flow Cell"),
              accordion(open = F, 
                        accordion_panel("Materials", gt_output(outputId = "supplies_flowcell")), flowcell.recs,
                        accordion_panel("Library Dilutions and Concentrations", reactableOutput("final_libraries"))),
              make_steps(flowcell),
              card_footer(actionButton("flowcell_done", "Next: Complete Experiment"))))
}

conclude_tab <- function() {
  nav_panel("Conclude", value = "closer",
            card(card_header("Notebook Entry Conclusion"),
                 tags$h2("Before you finish:"), tags$br(),
                 tags$h4("Conclude your notebook entry and export report..."), tags$br(),
                 dateInput("end_date", "End Date", value = Sys.Date(), format = "yyyy-mm-dd"),
                 textAreaInput("end_note", "Notes/Comments"),
                 textOutput("end_note_render"),
                 actionButton("generate_report", "Generate Report for Download"),
                 layout_column_wrap(downloadButton("download_csv", "Download Updated Table"), 
                                    downloadButton("download_report", "Download Report")),
                 uiOutput("step_progress"))
  )
}