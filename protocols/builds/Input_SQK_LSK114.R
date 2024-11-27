input_dna <- tibble(
  min_kb = c(0, 1, 10),
  max_kb = c(1, 10, 100),
  input  = c("200 fmol",
             "100-200 fmol",
             "1 ug")) %>%
  gt() %>%
  tab_header(title = "Input DNA Amounts") %>%
  cols_label(min_kb ~ "Length of Target",
             input  ~ "Template Needed") %>%
  cols_merge(columns = c("min_kb", "max_kb"),
             pattern = "{1} kb - {2} kb") %>%
  fmt_units(columns = everything()) %>%
  cols_align("left", columns = everything()) %>%
  tab_style(locations = cells_title(), style = list(
    cell_text(align = "left",
              size = "medium"))) %>%
  opt_stylize(4, color = "cyan") %>%
  tab_source_note("Note: If the library yields are below the input recommendations, load the entire library.") %>%
  tab_source_note(md("If required, use a mass to mol calculator such as the [NEB calculator](https://nebiocalculator.neb.com/#!/dsdnaamt).")) %>%
  tab_source_note("The prepared library is used for loading into the flow cell.")
