xfun::pkg_load2(c("htmltools", "mime"))

# Set global options for all chunks
opts_chunk$set(message = FALSE,
               warning = FALSE,
               echo    = TRUE,
               include = TRUE,
               eval    = TRUE)


# Custom engine for swan that substitutes variables and prints the code
knit_engines$set(swan = function(options) {
  code <- paste(options$code, collapse = "\n")
  
  # Substitute all params variables with their values
  for (param in names(params)) {
    param_placeholder <- paste0("\\$\\{params\\$", param, "\\}")
    param_value <- params[[param]]
    code <- gsub(param_placeholder, param_value, code)
  }
  
  # Print the code as a formatted code block
  output <- paste0("paste to terminal:\n\n", code, "\n\n")
  
  # Return the output to be displayed in the knitted document
  knitr::knit_print(output)
})

open.job <- function(name, mem, hrs, cpus) {
  chunk   <- paste("paste to cluster shell:\n\nsrun --partition=guest --nodes=1 --ntasks-per-node=1",
                   paste0(" --job-name=", 
                          name, 
                          " --mem=", 
                          mem, 
                          "GB --time=", 
                          hrs, 
                          ":00:00 --cpus-per-task=", 
                          cpus),
                   "--pty $SHELL\n\n")
  
  if(knitr::is_html_output()) {
    output <- knit_print(asis_output(paste("<div class='swan-chunk'>",  chunk,  "</div>") ) )
    
  } else {
    
    output <- chunk
  }
  
  return(output)
}

load.pkg <- function(pkg) {
  chunk <- paste("paste to cluster shell:\n\ncd", params$work_dir, "\nmodule load", pkg, "\n\n")
  
  if(knitr::is_html_output()) {
    output <- knit_print(asis_output(paste("<div class='swan-chunk'>",  chunk,  "</div>") ) )
    
    
  } else {
    output <- chunk
  }
  
  return(output)
}




fix.strings <-  function(df) {
  df <- df %>%
    mutate(across(where(is.character), ~str_remove_all(.x, fixed("'")))) %>%
    mutate(across(where(is.character), ~str_remove_all(.x, fixed("[")))) %>%
    mutate(across(where(is.character), ~str_remove_all(.x, fixed("]")))) %>%
    mutate(across(where(is.character), ~str_trim(.x, "both"))) %>%
    mutate(across(where(is.character), ~str_squish(.x)))
  return(df)
}

export.list <- function(df, filename) {
  write.table(df,
              paste0(params$local, "/dataframes/", filename, ".txt"),
              sep       = "\t",
              quote     = FALSE,
              row.names = FALSE,
              col.names = FALSE)
}


backup.df  <- function(df, filename) {
  write.table(df,
              paste0(params$local, "/dataframes/", filename, "_", Sys.Date(), ".tsv"),
              sep       = "\t",
              quote     = FALSE,
              row.names = FALSE)
}


since.start <- function(date.col, units) {
  as.numeric(as.period(interval(ymd(params$day1), date.col), unit = units), units)
}


check.duplicates <- function(df2, df, group) {
  df2 <- df %>%
    group_by(group) %>%
    filter(n() > 1) %>%
    ungroup()
}

read.tables <- function(file) {
  data <- read.table(file, 
                     header = TRUE, 
                     sep = "\t", 
                     stringsAsFactors = FALSE) %>%
    tibble()
  return(data)
}

read.summaries <- function(file) {
  
  data <- readr::read_lines(file) %>%
    tibble() %>%
    separate(everything(), into = c("key", "value"), sep = "=", fill = "right", extra = "merge") %>%
    pivot_wider(names_from = "key", values_from = "value")
  return(data)
}

scanBams <- function(file){
  data <- scanBam(file)
  return(data)
}

read.recent.version.csv <- function(directory, pattern) {
  files             <- list.files(path       = paste0(params$local, "/", directory, "/"), 
                                  pattern    = paste0(pattern, "\\d{4}-\\d{1,2}-\\d{1,2}\\.csv"), 
                                  full.names = TRUE)
  dates             <- gsub(".*_(\\d{4}-\\d{1,2}-\\d{1,2})\\.csv", "\\1", files)
  dates             <- as.Date(dates, format = "%Y-%m-%d")
  most_recent_index <- which.max(dates)
  most_recent_file  <- files[most_recent_index]
  data              <- read.csv(most_recent_file, header = TRUE)
  
  return(data)
}


read.recent.version.tsv <- function(directory, pattern) {
  files             <- list.files(path       = paste0(params$local, "/", directory, "/"), 
                                  pattern    = paste0(pattern, "\\d{4}-\\d{1,2}-\\d{1,2}\\.tsv"), 
                                  full.names = TRUE)
  dates             <- gsub(".*_(\\d{4}-\\d{1,2}-\\d{1,2})\\.tsv", "\\1", files)
  dates             <- as.Date(dates, format = "%Y-%m-%d")
  most_recent_index <- which.max(dates)
  most_recent_file  <- files[most_recent_index]
  data              <- read.table(most_recent_file, sep = "\t", header = T)
  
  return(data)
}

open.job <- function(name, mem, hrs, cpus) {
  chunk   <- paste("paste to cluster shell:\n\nsrun --partition=guest --nodes=1 --ntasks-per-node=1",
                   paste0(" --job-name=", 
                          name, 
                          " --mem=", 
                          mem, 
                          "GB --time=", 
                          hrs, 
                          ":00:00 --cpus-per-task=", 
                          cpus),
                   "--pty $SHELL\n\n")
  
  if(knitr::is_html_output()) {
    output <- knit_print(asis_output(paste("<div class='swan-chunk'>",  chunk,  "</div>") ) )
    
  } else {
    
    output <- chunk
  }
  
  return(output)
}

load.pkg <- function(pkg) {
  chunk <- paste("paste to cluster shell:\n\ncd", params$work_dir, "\nmodule load", pkg, "\n\n")
  
  if(knitr::is_html_output()) {
    output <- knit_print(asis_output(paste("<div class='swan-chunk'>",  chunk,  "</div>") ) )
    
    
  } else {
    output <- chunk
  }
  
  return(output)
}

# Function to process multiple BAM files and return a tidy dataframe with only primary alignments
bam.extract.primary <- function(bam.list) {
  
  # Helper function to tidy the output of scanBam
  bam_to_tibble <- function(bam_data, seqrun_id) {
    # Extract relevant fields from BAM data
    bam_df <- data.frame(
      qname  = unlist(bam_data[[1]]$qname),
      rname  = unlist(bam_data[[1]]$rname),
      pos    = unlist(bam_data[[1]]$pos),
      qwidth = unlist(bam_data[[1]]$qwidth),
      mapq   = unlist(bam_data[[1]]$mapq),
      cigar  = unlist(bam_data[[1]]$cigar)
    )
    
    # Add seqrun ID
    bam_df <- bam_df %>%
      mutate(seqrun = seqrun_id)
    
    return(bam_df)
  }
  
  # Process each BAM file and convert to tidy dataframe
  seqrun_bam <- lapply(bam.list, function(bamfile) {
    
    # Define parameters to extract primary alignments (skip reference sequence filtering)
    param <- ScanBamParam(
      what = c("qname", "rname", "pos", "qwidth", "mapq", "cigar"),
      flag = scanBamFlag(isUnmappedQuery = FALSE,   # Only mapped reads
                         isSecondaryAlignment = FALSE)  # Only primary alignments
    )
    
    # Extract reads from BAM file
    mapped_reads <- scanBam(BamFile(bamfile), param = param)
    
    # Get the seqrun ID from the BAM file name
    seqrun_id <- str_extract(bamfile, "hdzmt\\d{1,2}(?=.sorted.aligned.bam$)")
    
    # Convert BAM data to a tidy tibble
    bam_tibble <- bam_to_tibble(mapped_reads, seqrun_id)
    
    return(bam_tibble)
  })
  
  # Combine all results into a single tidy dataframe (or tibble)
  tidy_bam_df <- bind_rows(seqrun_bam)
  
  return(tidy_bam_df)
}

