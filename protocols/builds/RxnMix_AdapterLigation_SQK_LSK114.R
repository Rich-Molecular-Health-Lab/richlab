rxn_adapter <- tibble(
  Reagent = c("DNA sample from the previous step",
              "Ligation Adapter (LA)",
              "Ligation Buffer (LNB)",
              "Salt-T4® DNA Ligase"),
  Volume_ul = c(60, 5, 25, 10)
) %>%
  gt(rowname_col = "Reagent") %>%
  cols_label(Volume_ul ~ "Vol ({{uL}})") %>%
  grand_summary_rows(fns = list(label = "Total", id = "total", fn = "sum"), side = "bottom") %>%
  tab_header("In a 1.5 ml Eppendorf DNA LoBind tube, mix in the following order:") %>%
  tab_style(style = list(
    cell_text(align = "left"),
    cell_borders(sides = "top")), 
    locations = cells_title()) %>%
  tab_source_note("Between each addition, pipette mix 10-20 times.") %>%
  opt_stylize(style = 1, color = "cyan")
