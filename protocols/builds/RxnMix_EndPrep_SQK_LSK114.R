rxn_endprep <- tibble(
  Reagent = c("Prepared DNA (from previous step)", 
              "DNA CS (optional)",
              "NEBNext FFPE DNA Repair Buffer v2",
              "NEBNext FFPE DNA Repair Mix ",
              "Ultra II End-prep Enzyme Mix"),
  Volume_ul = c(47, 1, 7, 2, 3)
) %>%
  gt(rowname_col = "Reagent") %>%
  cols_label(Volume_ul ~ "Vol ({{uL}})") %>%
  grand_summary_rows(fns = list(label = "Total", id = "total", fn = "sum"), side = "bottom") %>%
  tab_header("In a 0.2 ml thin-walled PCR tube, mix the following:") %>%
  tab_style(style = list(
    cell_text(align = "left"),
    cell_borders(sides = "top")), 
    locations = cells_title()) %>%
  tab_source_note("Between each addition, pipette mix 10-20 times.") %>%
  tab_source_note("Then thoroughly mix the reaction by gently pipetting and briefly spinning down.") %>%
  opt_stylize(style = 1, color = "cyan")
