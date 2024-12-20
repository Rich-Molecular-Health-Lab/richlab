# assets_loader.R

ngul        <- " \u006E\u0067\u002F\u00B5\u004C"
ul          <- " \u00B5\u004C"

checklist_js <- JS("
  function(cellInfo) {
    return cellInfo.value === 'no' ? '\u2717' : '\u2713';
  }
")

certainty_js <- JS("function(cellInfo) {
    return cellInfo.value === 'no' ? '\u2753' : '\u2713'
  }")

checklist_r <- function(value) {if (value == 0) "\u2717" else "\u2713"}
certainty_r <- function(value) {if (value == "no") "\u2753" else "\u2713"}

format_select      <- reactableTheme(rowSelectedStyle = list(backgroundColor = "#eee", boxShadow = "inset 2px 0 0 0 #ffa62d"))
format_checklist   <- reactableTheme(rowSelectedStyle = list(backgroundColor = "darkgray"      , color = "#eee"),
                                     rowStyle         = list(backgroundColor = "darkgoldenrod1", borderColor = "black"))


create_supplies_gt <- function(data, step, title, subtitle) {
  data %>%
    filter(Step == step) %>%
    select(-Step) %>%
    mutate(
      Manufacturer = if_else(Manufacturer %in% c("NA", "Any"), "", Manufacturer),
      Catalog      = if_else(Catalog %in% c("NA", "Any"), "", Catalog)
    ) %>%
    gt(groupname_col = "Category") %>%
    cols_label(Item ~ "", Manufacturer ~ "", Catalog ~ "") %>%
    tab_header(title = title, subtitle = subtitle) %>%
    tab_style(style = cell_text(align = "left"), locations = cells_title()) %>%
    tab_style(style = cell_text(weight = "bold", transform = "uppercase"), locations = cells_row_groups()) %>%
    tab_style(style = cell_text(indent = 25), locations = cells_body(columns = "Item")) %>%
    opt_stylize(6, "pink")
}