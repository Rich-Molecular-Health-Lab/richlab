# Function to render the R Markdown report
render_report <- function(data, input, step_data) {
  # Ensure all dependencies exist
  req(data$libraries, input$author, step_data$log)
  
  # Evaluate reactive values
  libraries <- isolate(data$libraries)  # Safely access reactive value
  steps     <- isolate(reactiveValuesToList(step_data$log))  # Convert reactiveValues to list
  
  # Validate inputs
  if (nrow(libraries) == 0) stop("No library data available for the report.")
  if (length(steps) == 0) stop("No steps logged for the report.")
  if (is.null(input$author) || input$author == "") stop("Author name is required for the report.")
  
  # Render the R Markdown report
  output_file <- 
  rmarkdown::render(
    input       = paste0(params$base_path, "resources/ReportTemplate.Rmd"),
    output_file = output_file, 
    params      = list(
      author    = input$author,     
      libraries = libraries,   
      steps     = steps
    ),
    envir = new.env(parent = globalenv())  # Avoid polluting the global environment
  )
  
  return(output_file)  # Return the path to the rendered report
}

# Function to create the download handler for the report
create_download <- function(input, output, data, step_data) {
  output$download_report <- downloadHandler(
    filename = function() {
      paste0(Sys.Date(), "_notebook_entry.html")
    },
    content = function(file) {
      tryCatch({
        # Render the report
        report_file <- render_report(data, input, step_data)
        # Copy the report to the specified file path
        file.copy(report_file, file)
        showNotification("Report successfully generated!", type = "message")
      }, error = function(e) {
        # Handle errors gracefully
        showNotification(paste("Error generating report:", e$message), type = "error")
      })
    }
  )
}