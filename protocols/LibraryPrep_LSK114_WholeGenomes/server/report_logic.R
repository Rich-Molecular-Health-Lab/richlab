
record_step_data <- function(steps, step_data) {
  imap(steps, ~ {
    step_name    <- .y
    step_content <- .x
    main_step    <- step_content[[1]]
    
    step_data()[[paste0(step_name)]] <- list(detail = main_step,
                                             timestamp = NULL,
                                             note      = NULL)
  })
}

observe_steps <- function(steps, step_data, tab, input, output) {
  imap(steps, )
}






render_csv_download <- function(output, data, file_prefix) {
  
  output$download_csv <- downloadHandler(
    filename = function() {
      paste0(file_prefix(), ".csv")
    },
    content  = function(file) { 
      req(data$libraries)
      data_output <- isolate(data$libraries) %>% tibble()
      write.csv(data_output, file)  
    }
  )
}

report_aslist <- function(step_data) {
  req(step_data$log)
  
  # Extract the step data into a list
  steps <- lapply(names(step_data$log), function(step_name) {
    step <- step_data$log[[step_name]]
    
    # Ensure required elements exist
    req(step$timestamp, step$step)
    
    # Return the step details as a named list
    list(
      step_name  = step_name,
      timestamp  = step$timestamp,
      main_step  = step$step,
      substeps   = step$substeps %||% NULL,
      note       = step$note %||% "No note provided"
    )
  })
  
  setNames(steps, names(step_data$log))
}

render_report <- function(input, step_data, file_prefix) {
  req(input$author, input$exp_date, step_data$log, file_prefix())
  
  steps <- report_aslist(step_data)
  
  if (length(steps) == 0) stop("No steps logged for the report.")
  
  file <- paste0(file_prefix(), "_report.html")
  
  rmarkdown::render(
    input       = paste0(params$base_path, "resources/report.Rmd"),
    output_file = file, 
    params      = list(
      author    = input$author,   
      date      = input$exp_date,
      steps     = steps
    ),
    envir = new.env(parent = globalenv())
  )
  
  return(file)
}

