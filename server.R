library("shiny")
library("readr")
library("dplyr")
library("lubridate")
library("DT")
source("./R/fillInWorksheet.R")

# Define server logic required to display preview of the tables
function(input, output, session) {
  
  # Retrieve data from CSV files
  sample_data <- reactive({
    req(input$sample_file)
    read_delim(input$sample_file$datapath, delim = ";", escape_double = FALSE, trim_ws = TRUE, show_col_types = FALSE)
  })
  
  scan_data <- reactive({
    req(input$scan_file)
    read_delim(input$scan_file$datapath, delim = ";", escape_double = FALSE, trim_ws = TRUE, show_col_types = FALSE)
  })
  
  # Function to display a preview of the CSV files
  read_csv_preview <- function(file_path) {
    if (file.exists(file_path)) {
      # Read CSV file
      df <- read_delim(file_path, delim = ";", escape_double = FALSE, trim_ws = TRUE, show_col_types = FALSE)
      # Modify comment format
      if ("sample_comment" %in% names(df)) {
        mutate(df, sample_comment = iconv(sample_comment, "latin1", "UTF-8",sub=''))
      }
      
      return(df)  # Display the table as a preview
    } else {
      return(NULL)
    }
  }
  
  # Reactive function to read and display preview of the uploaded CSV sample file
  output$preview_sample_table <- renderDT({
    req(input$sample_file)  # Wait until a sample file is uploaded  
    sample_file_path <- input$sample_file$datapath
    read_csv_preview(sample_file_path)
  })
  
  # Reactive function to read and display preview of the uploaded CSV scan file
  output$preview_scan_table <- renderDT({
    req(input$scan_file)  # Wait until a scan file is uploaded  
    scan_file_path <- input$scan_file$datapath
    read_csv_preview(scan_file_path)
  })
  

  
  output$download_excel <- downloadHandler(
    filename = function() {
      paste(input$output_name, ".xlsx", sep = "")
    },
    content = function(file) {
      # Call your custom function with sample_data, scan_data and all inputs from user.
      result <- fillInWorksheet(df_sample = sample_data(), df_scan = scan_data(), id_lot = input$id_lot, entry_names = input$entry_name, entry_date = input$selected_date, pi_names = input$pi_name, pi_email = input$pi_email, pi_institute = input$pi_institute, pi_status = input$pi_status, analysis = input$analysis)

      # Save result to Excel file
      saveWorkbook(result, file)
    }
  )
}


