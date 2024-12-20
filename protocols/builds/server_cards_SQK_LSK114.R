output$card_I.3.    <- renderUI({page_fluid(card(reactableOutput("extracts_endprep")))})
output$card_I.5.    <- renderUI({page_fluid(card(reactableOutput("endprep_react"),
                                                 uiOutput("checklist_tubes")))})
output$card_I.19.   <- renderUI({page_fluid(
  uiOutput("qcresult1"),
  card(class = "bg-dark", card_header("End of Step"), 
       layout_columns(col_widths = c(2, 10), bs_icon("pause-circle-fill", size = "3em"),
                      "Take forward the repaired and end-prepped DNA into the adapter ligation step. However, at this point it is also possible to store the sample at 4°C overnight.")))})

output$card_II.5.   <- renderUI({page_fluid(card(gt_output("rxn_adapter")))})
output$card_III.11. <- renderUI({uiOutput("qcresult2")})
output$card_III.12. <- renderUI({page_fluid(card(reactableOutput("final_libraries")))})
output$card_IV.2.   <- renderUI({page_fluid(card(gt_output("rxn_flowcell"),
                                                 uiOutput("checklist_tubes")))})
output$card_IV.3.   <- renderUI({page_fluid(accordion(open = FALSE, 
                                                      accordion_panel(title = "Illustration", 
                                                                      card(layout_columns(col_widths = 1/2, 
                                                                                          imageOutput("imgIV3a"), 
                                                                                          imageOutput("imgIV3b"))))))})
output$card_IV.4. <- renderUI({page_fluid(accordion(open = FALSE, accordion_panel(title = "Illustration", card(imageOutput("imgIV4")))))})
output$card_IV.5. <- renderUI({page_fluid(accordion(open = FALSE, accordion_panel(title = "Illustration", card(imageOutput("imgIV5")))))})
output$card_IV.6. <- renderUI({page_fluid(accordion(open = FALSE, accordion_panel(title = "Illustration", card(imageOutput("imgIV6")))))})
output$card_IV.8. <- renderUI({page_fluid(card(gt_output("rxn_sequence")))})
output$card_IV.9. <- renderUI({page_fluid(accordion(open = FALSE, 
                                                    accordion_panel(title = "Illustration", 
                                                                    card(layout_columns(col_widths = 1/2, 
                                                                                        imageOutput("imgIV9a"), 
                                                                                        imageOutput("imgIV9b"))))))})
output$card_IV.11. <- renderUI({page_fluid(accordion(open = FALSE, 
                                                     accordion_panel(title = "Illustration", 
                                                                     card(imageOutput("imgIV11")))))})
output$card_IV.12. <- renderUI({page_fluid(accordion(open = FALSE, 
                                                     accordion_panel(title = "Illustration", 
                                                                     card(layout_columns(col_widths = 1/2, 
                                                                                         imageOutput("imgIV12a"), 
                                                                                         imageOutput("imgIV12b"))))))})
output$card_IV.13. <- renderUI({page_fluid(
  accordion(open = FALSE, 
            accordion_panel(title = "Illustration", 
                            card(imageOutput("imgIV13")))),
  card(class = "bg-dark", card_header("End of Step"), 
       layout_columns(col_widths = c(2, 10), bs_icon("pause-circle-fill", size = "3em"),
                      "The prepared library is used for loading into the flow cell. Store the library on ice or at 4°C until ready to load.")))})
