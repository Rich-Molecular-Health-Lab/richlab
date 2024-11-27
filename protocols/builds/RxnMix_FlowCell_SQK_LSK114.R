rxn_flowcell <- tibble(
  Reagent = c("Flow Cell Flush (FCF)",
              "Bovine Serum Albumin (BSA) at 50 mg/ml",
              "Flow Cell Tether (FCT)"),
  Volume_ul = c(1170, 5, 30)
) %>%
  gt(rowname_col = "Reagent") %>%
  cols_label(Volume_ul ~ "Vol ({{uL}}) per Flow Cell") %>%
  grand_summary_rows(fns = list(label = "Total", id = "total", fn = "sum"), side = "bottom") %>%
  tab_header("In a suitable tube for the number of flow cells, combine the following reagents:") %>%
  tab_style(style = list(
    cell_text(align = "left"),
    cell_borders(sides = "top")), 
    locations = cells_title()) %>%
  tab_source_note("Mix by pipetting at room temperature.") %>%
  opt_stylize(style = 1, color = "cyan")
