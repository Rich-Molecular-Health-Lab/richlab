# helper_functions.R


base_path  <- paste0(params$base_path)
local_path <- paste0(params$local)

# Read the most recent CSV file
read.recent.version.csv <- function(directory, pattern, base_path) {
  # Build file path
  file_path <- paste0(base_path, directory, "/")
  files <- list.files(
    path = file_path,
    pattern = paste0(pattern, "\\d{4}-\\d{1,2}-\\d{1,2}\\.csv"),
    full.names = TRUE
  )
  
  # Check if files exist
  if (length(files) == 0) stop(paste("No matching CSV files found in", file_path))
  
  # Get the most recent file
  dates <- gsub(".*_(\\d{4}-\\d{1,2}-\\d{1,2})\\.csv", "\\1", files)
  most_recent_file <- files[which.max(as.Date(dates))]
  
  # Read the file
  read.csv(most_recent_file, header = TRUE)
}

# Read the most recent TSV file
read.recent.version.tsv <- function(directory, pattern, base_path) {
  # Build file path
  file_path <- paste0(base_path, directory, "/")
  files <- list.files(
    path = file_path,
    pattern = paste0(pattern, "\\d{4}-\\d{1,2}-\\d{1,2}\\.tsv"),
    full.names = TRUE
  )
  
  # Check if files exist
  if (length(files) == 0) stop(paste("No matching TSV files found in", file_path))
  
  # Get the most recent file
  dates <- gsub(".*_(\\d{4}-\\d{1,2}-\\d{1,2})\\.tsv", "\\1", files)
  most_recent_file <- files[which.max(as.Date(dates))]
  
  # Read the file
  read.table(most_recent_file, sep = "\t", header = TRUE)
}

link_tabs <- function(input) {

  tab.link <- function(tab1, tab2, input, nav_id = "main.nav") {
    observeEvent(input[[paste0(tab1, "_done")]], {
      req(nav_id, tab2) 
      nav_select(nav_id, tab2)
    })
  }
  
  tab.link("setup", "endprep", input)
  tab.link("endprep", "adapter", input)
  tab.link("adapter", "cleanup", input)
  tab.link("cleanup", "flowcell", input)
  tab.link("flowcell", "closer", input)
}

initialize_step_data <- function(steps) {
  step_data <- reactiveValues()
  imap(steps, ~ {
    
    step_name    <- .y
    step_content <- .x
    main_step    <- step_content[[1]]
    
    step_data[[step_name]] <- reactiveValues(
      detail    = main_step,
      note      = NULL,
      timestamp = NULL
    )
  })
  
  return(step_data)
}

render_image <- function(output, outputId, filename, base_path, height = "75%") {
  full_path <- paste0(base_path, "resources/images/", filename)
  output[[outputId]] <- renderImage({
    list(src = full_path, height = height)
  }, deleteFile = FALSE)
}

seq_subtable <- function(index, samples.loris) {
  req(samples.loris, index)
  seq_data <- samples.loris %>%
    filter(ExtractID_DNA == samples.loris$ExtractID_DNA[index]) %>%
    select(SequenceID,
           Seq_16sDate,
           LibraryBarcode,
           LibraryFinalConc,
           LibraryCode,
           LibraryPoolVol_ul) %>%
    filter(!is.na(SequenceID))
  
  div(style = "padding: 1rem",
      if (nrow(seq_data) > 0) {
        reactable(seq_data, 
                  outlined = TRUE, 
                  columns = columns_subtable)
      } else {
        div("Not sequenced yet.")
      })
}

render_reactable <- function(output, outputId, data, included_columns, ...) {
  output[[outputId]] <- renderReactable({
    req(data())  
    if (nrow(data()) == 0) {
      return(div("No data available to display."))
    }
    reactable(
      data(),
      columns             = included_columns,
      showPageSizeOptions = TRUE, 
      highlight           = TRUE, 
      compact             = TRUE,
      ...
    )
  })
}


rxn_vols <- function(rxn, n_rxns) {
  rxn %>% mutate(Volume_total = Volume_rxn * n_rxns)
}

calculate_length <- function(fragment_type) {
  case_when(
    fragment_type == 1 ~ 10000,
    fragment_type == 2 ~ 900,
    fragment_type == 3 ~ 2000,
    fragment_type == 4 ~ 7000,
    fragment_type == 5 ~ 10000,
    TRUE ~ 10000
  )
}

calculate_mass_start <- function(fragment_type, Length, strands) {
  case_when(
    fragment_type == 1 ~ 1000,
    fragment_type == 2 ~ (200 * ((Length * (307.97 * strands)) + (18.02 * strands)) * 10^-6),
    fragment_type == 3 ~ (150 * ((Length * (307.97 * strands)) + (18.02 * strands)) * 10^-6),
    fragment_type == 4 ~ (100 * ((Length * (307.97 * strands)) + (18.02 * strands)) * 10^-6),
    fragment_type == 5 ~ 1000,
    TRUE ~ 1000
  )
}

calculate_mass_final <- function(fragment_type, Length, strands) {
  case_when(
    fragment_type == 1 ~ 300,
    fragment_type == 2 ~ (50 * ((Length * (307.97 * strands)) + (18.02 * strands)) * 10^-6),
    fragment_type == 3 ~ (45 * ((Length * (307.97 * strands)) + (18.02 * strands)) * 10^-6),
    fragment_type == 4 ~ (35 * ((Length * (307.97 * strands)) + (18.02 * strands)) * 10^-6),
    fragment_type == 5 ~ 300,
    TRUE ~ 300
  )
}
