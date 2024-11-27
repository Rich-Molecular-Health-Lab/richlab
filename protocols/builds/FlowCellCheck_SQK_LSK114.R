flowcell_check <- tibble(
  flow_cell = c("Flongle",
                "MinION",
                "PromethION"),
  min_pores = c(50, 800, 5000)) %>%
  gt() %>%
  tab_header(title = "Optional: Complete a flow cell check to assess the number of pores available before loading the library.") %>%
  cols_label(flow_cell ~ "Flow Cell Version",
             min_pores ~ "Minimum Pores Needed") %>%
  cols_align("left", columns = everything()) %>%
  tab_style(locations = cells_title(), style = list(
    cell_text(align = "left",
              size = "medium"))) %>%
  tab_source_note(md("*This step can be omitted if the flow cell has been checked previously.*")) %>%
  opt_stylize(2, color = "cyan")
