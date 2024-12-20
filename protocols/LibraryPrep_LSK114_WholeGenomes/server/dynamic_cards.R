
render_image <- function(output, outputId, filename, base_path, height = "75%") {
  full_path <- paste0(base_path, "resources/images/", filename)
  output[[outputId]] <- renderImage({
    list(src = full_path, height = height)
  }, deleteFile = FALSE)
}

render_images <- function(output) {
  render_image(output, "LSK114_tubes", "SQK-LSK114_tubes.svg"                                      , base_path, height = "90%")
  render_image(output, "imgIV3a"     , "Flow_Cell_Loading_Diagrams_Step_1a.svg"                    , base_path, height = "90%")
  render_image(output, "imgIV3b"     , "Flow_Cell_Loading_Diagrams_Step_1b.svg"                    , base_path, height = "75%")
  render_image(output, "imgIV4"      , "Flow_Cell_Loading_Diagrams_Step_2.svg"                     , base_path, height = "75%")
  render_image(output, "imgIV5"      , "Flow_Cell_Loading_Diagrams_Step_03_V5.gif"                 , base_path, height = "75%")
  render_image(output, "imgIV6"      , "Flow_Cell_Loading_Diagrams_Step_04_V5.gif"                 , base_path, height = "75%")
  render_image(output, "imgIV9a"     , "Flow_Cell_Loading_Diagrams_Step_06_V5.gif"                 , base_path, height = "75%")
  render_image(output, "imgIV11"     , "Flow_Cell_Loading_Diagrams_Step_07_V5.gif"                 , base_path, height = "75%")
  render_image(output, "imgIV12a"    , "Step_8_update.png"                                         , base_path, height = "75%")
  render_image(output, "imgIV12b"    , "Flow_Cell_Loading_Diagrams_Step_9.svg"                     , base_path, height = "75%")
  render_image(output, "imgIV13"     , "J2264_-_Light_shield_animation_Flow_Cell_FAW_optimised.gif", base_path, height = "75%")
}

render_card <- function(header, reactable_id, footer_text, checklist = TRUE) {
  card(
    card_header(header),
    reactableOutput(reactable_id),
    card_footer(
      footer_text,
      if (checklist) uiOutput("checklist_tubes") else NULL
    ))
}

render_illustration <- function(img) {
  page_fluid(
    accordion(
      open = FALSE, 
      accordion_panel(
        title = "Illustration", 
        card(imageOutput(img)))))
}

render_illustration_x2 <- function(img1, img2) {
  page_fluid(
    accordion(
      open = FALSE, 
      accordion_panel(
        title = "Illustration", 
        card(
          layout_columns(
            col_widths = 1/2, 
            imageOutput(img1), 
            imageOutput(img2))))))
}

render_dynamic_cards <- function(output) {
  output$card_I.4. <- renderUI(
    render_card(
      header = "After diluting each DNA extract, prepare the reaction mix:",
      reactable_id = "endprep_react",
      footer_text = "As you add each reagent, pipette mix 10-20 times and check the box."))
  
  output$card_I.19. <- renderUI(uiOutput("qc1_result"))
  
  output$card_II.5. <- renderUI(
    render_card(
      header = "In a 1.5 ml Eppendorf DNA LoBind tube, mix in the following order:",
      reactable_id = "adapter_react",
      footer_text = "Between each addition, pipette mix 10-20 times."))
  
  output$card_III.11. <- renderUI(uiOutput("qc2_result"))
  
  output$card_III.12. <- renderUI(
    render_card(
      header = "Dilute final libraries as follows by adding either additional elution buffer or sterile H2O:",
      reactable_id = "final_libraries",
      footer_text = "Note: If the library yields are below the input recommendations, load the entire library. You may also want to consider a clean & concentrator kit or other enrichment step first."))
  
  output$card_IV.2. <- renderUI(
    render_card(
      header = "In a suitable tube for the number of flow cells, combine the following reagents:",
      reactable_id = "fcprime_react",
      footer_text = "Mix by pipetting at room temperature and check as you add each:"))
  
  output$card_IV.8. <- renderUI(
    render_card(
      header = "Prepare the reaction mix with diluted library as Template DNA:",
      reactable_id = "fcload_react",
      footer_text = render_illustration("imgIV8")))
  
  output$card_IV.3.  <- renderUI(render_illustration_x2("imgIV3a", "imgIV3b"))
  output$card_IV.4.  <- renderUI(render_illustration("imgIV4"))
  output$card_IV.5.  <- renderUI(render_illustration("imgIV5"))
  output$card_IV.6.  <- renderUI(render_illustration("imgIV6"))
  output$card_IV.9.  <- renderUI(render_illustration_x2("imgIV9a", "imgIV9b"))
  output$card_IV.11. <- renderUI(render_illustration("imgIV11"))
  output$card_IV.12. <- renderUI(render_illustration_x2("imgIV12a", "imgIV12b"))
}
