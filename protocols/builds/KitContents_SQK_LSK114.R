SQK.LSK114.contents <- tibble(
  abbrev  = c("DCS", "LA", "LNB", "LFB", "SFB", "AXP", "SB", "EB", "LIB", "LIS", "FCF", "FCT"),
  reagent = c("DNA Control Strand", "Ligation Adapter", "Ligation Buffer", "Long Fragment Buffer", "Short Fragment Buffer", "AMPure XP Beads", "Sequencing Buffer", "Elution Buffer", "Library Beads", "Library Solution", "Flow Cell Flush", "Flow Cell Tether"),
  color   = c("yellow", "green", "lightgray", "orange", "gray", "brown", "red", "black", "magenta", "pink", "blue", "purple")
) %>%
  gt() %>%
  tab_header("SQK-LSK114 Contents") %>%
  tab_style_body(style   = cell_fill(color = from_column("color")),
                 columns = "abbrev",
                 pattern = ".") %>%
  cols_label(abbrev ~ "", reagent ~ "") %>%
  cols_hide(color) %>%
  opt_table_lines("none") %>%
  tab_style(locations = cells_title(), style = cell_text(align = "left", size = "medium")) %>%
  opt_horizontal_padding(1.5)
