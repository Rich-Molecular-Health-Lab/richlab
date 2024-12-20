# data_gt.R

flowcell_check <-   gt(flowcell_check.tbl) %>%
  tab_header(title = "Optional: Complete a flow cell check to assess the number of pores available before loading the library.") %>%
  cols_label(flow_cell ~ "Flow Cell Version",
             min_pores ~ "Minimum Pores Needed") %>%
  cols_align("left", columns = everything()) %>%
  tab_style(locations = cells_title(), style = list(
    cell_text(align = "left",
              size = "medium"))) %>%
  tab_source_note(md("*This step can be omitted if the flow cell has been checked previously.*")) %>%
  opt_stylize(2, color = "cyan")

SQK.LSK114.contents <-  gt(SQK.LSK114.contents.tbl) %>%
  tab_header("SQK-LSK114 Contents") %>%
  tab_style_body(style   = cell_fill(color = from_column("color")),
                 columns = "abbrev",
                 pattern = ".") %>%
  cols_label(abbrev ~ "", reagent ~ "") %>%
  cols_hide(color) %>%
  opt_table_lines("none") %>%
  tab_style(locations = cells_title(), style = cell_text(align = "left", size = "medium")) %>%
  opt_horizontal_padding(1.5)

gt_supplies <- supplies %>% 
  mutate(Manufacturer = if_else(Manufacturer == "NA", "", Manufacturer),
         Catalog      = if_else(Catalog      == "NA", "", Catalog)) %>%
  arrange(Step, Category) %>%
  mutate(Category = if_else(lag(Step) != Step | lag(Category) != Category | row_number() == 1, Category, "")) %>%
  mutate(Step = case_when(Step == "All" ~ "Multiple Steps",
                          Step == "End_Prep" ~ "1. DNA Repair and End Prep",
                          Step == "Adapter_Ligation" ~ "2. Adapter Ligation",
                          Step == "Library_Cleanup" ~ "3. Library Clean-Up",
                          Step == "Load_Flowcell" ~ "4. Prime and Load the Flow Cell")) %>%
  gt(groupname_col = "Step", rowname_col = "Category") %>%
  cols_label(Item ~ "",
             Manufacturer ~ "",
             Catalog ~ "") %>%
  tab_header("Overview of Supplies Needed") %>%
  tab_style(style = cell_text(align = "left"), locations = cells_title()) %>%
  tab_style(style = cell_text(weight = "bold", transform = "uppercase"), locations = cells_row_groups()) %>%
  tab_stub_indent(rows = everything(), indent = 3) %>%
  tab_style(style = cell_text(weight = "bold", transform = "uppercase"), locations = cells_stub()) %>%
  opt_stylize(6, "pink")

supplies_endprep <- create_supplies_gt(supplies, "End_Prep"        , "Materials & Supplies", "DNA Repair & End Prep")
supplies_adapter <- create_supplies_gt(supplies, "Adapter_Ligation", "Materials & Supplies", "Adapter Ligation")


supplies_cleanup <- supplies %>% filter(Step == "Library_Cleanup") %>%
  select(-Step) %>%
  mutate(Manufacturer = if_else(Manufacturer == "NA" | Manufacturer == "Any", "", Manufacturer),
         Catalog      = if_else(Catalog      == "NA" | Catalog == "Any", "", Catalog)) %>%
  gt(groupname_col = "Category") %>%
  cols_label(Item ~ "",
             Manufacturer ~ "",
             Catalog ~ "") %>%
  tab_header("Materials & Supplies", subtitle = "Library Clean-Up") %>%
  tab_style(style = cell_text(align = "left"), locations = cells_title()) %>%
  tab_style(style = cell_text(weight = "bold", transform = "uppercase"), locations = cells_row_groups()) %>%
  tab_style(style = cell_text(indent = 25), locations = cells_body(columns = "Item")) %>%
  opt_stylize(6, "pink")

supplies_flowcell <- supplies %>% filter(Step == "Load_Flowcell") %>%
  select(-Step) %>%
  mutate(Manufacturer = if_else(Manufacturer == "NA" | Manufacturer == "Any", "", Manufacturer),
         Catalog      = if_else(Catalog      == "NA" | Catalog == "Any", "", Catalog)) %>%
  gt(groupname_col = "Category") %>%
  cols_label(Item ~ "",
             Manufacturer ~ "",
             Catalog ~ "") %>%
  tab_header("Materials & Supplies", subtitle = "Priming & Loading the Flow Cell") %>%
  tab_style(style = cell_text(align = "left"), locations = cells_title()) %>%
  tab_style(style = cell_text(weight = "bold", transform = "uppercase"), locations = cells_row_groups()) %>%
  tab_style(style = cell_text(indent = 25), locations = cells_body(columns = "Item")) %>%
  tab_footnote("Please note, this kit is only compatible with R10.4.1 flow cells (FLO-MIN114).", 
               locations = cells_body(columns = Item, rows = Item == "MinION Flow Cell")) %>%
  tab_footnote("For optimal sequencing performance and improved output on MinION R10.4.1 flow cells (FLO-MIN114), ONT recommends adding Bovine Serum Albumin (BSA) to the flow cell priming mix at a final concentration of 0.2 mg/ml.", 
               locations = cells_body(columns = Item, rows = Item == "Bovine Serum Albumin (BSA) (50 mg/ml)")) %>%
  opt_stylize(6, "pink")


