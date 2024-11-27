
supplies <- bind_rows(
  tibble(
    Step = rep("All", 7),
    Category = rep("Equipment", 7),
    Item = c("MinION Device",
             "Qubit fluorometer",
             "Thermal cycler",
             "Hula mixer",
             "Magnetic rack",
             "Microfuge",
             "Ice bucket or freezy block"),
    Manufacturer = c("ONT", "Invitrogen", rep("NA", 5)),
    Catalog = rep("NA", 7)
  ),
  tibble(
    Step = rep("All", 2),
    Category = rep("Kit", 2),
    Item = c("Ligation Sequencing Kit V14", "NEBNext Companion Module v2 for ONT Ligation Sequencing"),
    Manufacturer = c("ONT", "NEB"),
    Catalog = c("SQK-LSK114", "E7672S")
  ),
  tibble(Step     = c("End_Prep"),
         Category = c("Other"),
         Item = c("1 µg (or 100-200 fmol) high molecular weight genomic DNA"),
         Manufacturer = c("NA"),
         Catalog = c("NA")),
  
  tibble(Step     = rep("End_Prep", 10),
         Category = rep("Materials", 10),
         Item = c("DNA Control Sample",
                  "AMPure XP Beads",
                  "NEBNext® FFPE DNA Repair Buffer v2",
                  "NEBNext® Ultra II End Prep Enzyme Mix",
                  "Qubit dsDNA HS Assay Kit",
                  "Nuclease-free water",
                  "Freshly prepared 80% ethanol in nuclease-free water",
                  "Qubit™ Assay Tubes",
                  "0.2 ml thin-walled PCR tubes",
                  "1.5 ml Eppendorf DNA LoBind tubes"),
         Manufacturer = c("ONT", "ONT", "NEB", "NEB", "Invitrogen", "Any", "Any", "Invitrogen", "Any", "Any"),
         Catalog = c("NA", "NA", "E7672S/M6630", "E7672S/E7363", "Q32851", "NA", "NA", "Q32856", "NA", "NA")),
  tibble(
    Step     = rep("Adapter_Ligation", 4),
    Category = rep("Materials", 4),
    Item  = c("Ligation Adapter (LA)",
              "Ligation Buffer (LNB)",
              "Long Fragment Buffer (LFB)",
              "Short Fragment Buffer (SFB)"), 
    Manufacturer = rep("ONT", 4),
    Catalog = rep("NA", 4)),
  tibble(
    Step     = rep("Adapter_Ligation", 2),
    Category = rep("Consumables", 2),
    Item  = c("Salt-T4® DNA Ligase",
              "1.5 ml Eppendorf DNA LoBind tubes"),
    Manufacturer = c("NEB",
                     "Any"),
    Catalog = c("M0467",
                "NA")),
  tibble(
    Step    = rep("Library_Cleanup", 2),
    Category = rep("Materials", 2),
    Item = c("AMPure XP Beads (AXP)",
             "Elution Buffer (EB)"), 
    Manufacturer = rep("ONT", 2),
    Catalog = rep("NA", 2)),
  tibble(
    Step    = rep("Library_Cleanup", 3),
    Category = rep("Consumables", 3),
    Item = c("1.5 ml Eppendorf DNA LoBind tubes",
             "Qubit dsDNA HS Assay Kit",
             "Qubit™ Assay Tubes"),
    Manufacturer = c("Any",
                     "Invitrogen",
                     "Invitrogen"),
    Catalog = c("NA",
                "Q32851",
                "Q32856")),
  tibble(
    Step    = rep("Load_Flowcell", 5),
    Category = rep("Materials", 5),
    Item = c("Flow Cell Flush (FCF)",
             "Flow Cell Tether (FCT)",
             "Library Solution (LIS)",
             "Library Beads (LIB)",
             "Sequencing Buffer (SB)"),
    Manufacturer = rep("ONT", 5),
    Catalog = rep("NA", 5)),
  tibble(
    
    Step    = rep("Load_Flowcell", 3),
    Category = rep("Consumables", 3),
    Item     = c("MinION Flow Cell",
                 "Bovine Serum Albumin (BSA) (50 mg/ml)",
                 "1.5 ml Eppendorf DNA LoBind tubes"),
    Manufacturer = c("ONT", rep("Any", 2)),
    Catalog = rep("NA", 3)
  )
) %>%
  mutate(Category = factor(Category, levels = c("Equipment", "Kit", "Materials", "Consumables", "Other"), ordered = T),
         Step     = factor(Step, levels = c("All", "End_Prep", "Adapter_Ligation", "Library_Cleanup", "Load_Flowcell"), ordered = T)) %>%
  arrange(Step, Category, Manufacturer)

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

supplies_endprep <- supplies %>% filter(Step == "End_Prep") %>%
  select(-Step) %>%
  mutate(Manufacturer = if_else(Manufacturer == "NA" | Manufacturer == "Any", "", Manufacturer),
         Catalog      = if_else(Catalog      == "NA" | Catalog == "Any", "", Catalog)) %>%
  gt(groupname_col = "Category") %>%
  cols_label(Item ~ "",
             Manufacturer ~ "",
             Catalog ~ "") %>%
  tab_header("Materials & Supplies", subtitle = "DNA Repair & End Prep") %>%
  tab_style(style = cell_text(align = "left"), locations = cells_title()) %>%
  tab_style(style = cell_text(weight = "bold", transform = "uppercase"), locations = cells_row_groups()) %>%
  tab_style(style = cell_text(indent = 25), locations = cells_body(columns = "Item")) %>%
  opt_stylize(6, "pink") %>%
  opt_interactive(use_highlight        = T,
                  use_page_size_select = T)

supplies_adapter <- supplies %>% filter(Step == "Adapter_Ligation") %>%
  select(-Step) %>%
  mutate(Manufacturer = if_else(Manufacturer == "NA" | Manufacturer == "Any", "", Manufacturer),
         Catalog      = if_else(Catalog      == "NA" | Catalog == "Any", "", Catalog)) %>%
  gt(groupname_col = "Category") %>%
  cols_label(Item ~ "",
             Manufacturer ~ "",
             Catalog ~ "") %>%
  tab_header("Materials & Supplies", subtitle = "Adapter Ligation") %>%
  tab_style(style = cell_text(align = "left"), locations = cells_title()) %>%
  tab_style(style = cell_text(weight = "bold", transform = "uppercase"), locations = cells_row_groups()) %>%
  tab_style(style = cell_text(indent = 25), locations = cells_body(columns = "Item")) %>%
  tab_footnote("Although third-party ligase products may be supplied with their own buffer, the ligation efficiency of the Ligation Adapter (LA) is higher when using the Ligation Buffer (LNB) supplied in the Ligation Sequencing Kit.",
               locations = cells_body(columns = Item, rows = Item == "Ligation Buffer (LNB)")) %>%
  tab_footnote("ONT recommends using the Salt-T4® DNA Ligase (NEB, M0467). Salt-T4® DNA Ligase (NEB, M0467) can be bought separately or is provided in the NEBNext® Companion Module v2 for Oxford Nanopore Technologies® Ligation Sequencing (catalogue number E7672S or E7672L). The Quick T4 DNA Ligase (NEB, E6057) available in the previous version NEBNext® Companion Module for Oxford Nanopore Technologies® Ligation Sequencing (NEB, E7180S or E7180L) is also compatible, but the new recommended reagent offers more efficient ligation.",
               locations = cells_body(columns = Item, rows = Item == "Salt-T4® DNA Ligase")) %>%
  opt_stylize(6, "pink")

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
