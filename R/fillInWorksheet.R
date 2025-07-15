source("./R/createWorksheetTemplate.R")

fillInWorksheet <- function(df_sample, df_scan, id_lot = NA, entry_names = NA, entry_date = NA, pi_names = NA, pi_email = NA, pi_institute = NA, pi_status = NA, analysis = NA) {
  ###
  # Fill in the worksheet with desired data.
  # Start by managing barcodes. Then merge all 3 dataframes (sample + scan + barcode). Finally, create an output dataframe to feed our worksheet.
  # Input : 
  #   - df_sample : dataframe that comes from sample csv
  #   - df_scan : dataframe that comes from scan csv
  #   - All other inputs : come from the ui. They are user input
  # 
  # Output : 
  #   - wb : Workbook containing 1 worksheet with proper header (created in createWorksheetTemplate.R) and filled in with data from df_sample and df_scan.
  ###
  
  # Split and manage barcodes in a separate df
  # Function to categorize based on suffix
  categorize_barcode <- function(bc) {
    # /!\ This function is case sensitive on the suffix /!\
    suffix <- substr(bc, nchar(bc)-1, nchar(bc))
    if (suffix == "zz") {
      return("barcode_parent")
    } else if (grepl("^[a-y][a-z]$", suffix)) {
      return("barcode_children")
    } else {
      return("barcode_initial")
    }
  }
  
  print("before strsplit")
  # Process each row. First turn barcode column to character in case it has been recognized as numeric. Then split and categorize barcodes.
  result_list <- lapply(as.character(df_sample$barcode), function(cell_content) {
    barcodes <- unlist(strsplit(cell_content, "/"))
    print("after strsplit")
    # Categorize each barcode
    parent <- children <- initial <- ""
    for (bc in barcodes) {
      category <- categorize_barcode(bc)
      if (category == "barcode_parent") {
        parent <- c(parent, bc)
      } else if (category == "barcode_children") {
        children <- c(children, bc)
      } else {
        initial <- c(initial, bc)
      }
    }
    
    # return a df that contains barcodes
    return(data.frame(barcode = cell_content,
                      barcode_parent = if (length(parent) > 0) paste(parent[parent != ""], collapse = "/") else NA,
                      barcode_children = if (length(children) > 0) paste(children[children != ""], collapse = "/") else NA,
                      barcode_initial = if (length(initial) > 0) paste(initial[initial != ""], collapse = "/") else NA))
  })

  
  # Combine all lists into one data frame
  df_barcode <- do.call(rbind, result_list)
  
  # Merge tables
  df <- merge(df_sample, df_scan, by = "sampleid", all = TRUE)
  df <- merge(df, df_barcode, by = "barcode", all = TRUE)

  df_output <- data.frame(
    id_lot = id_lot,
    parent_barcode = df$barcode_parent,
    parent_jar = paste(df$stationid, year(ymd_hm(df$date, tz = "UTC")), isoweek(ymd_hm(df$date, tz = "UTC")), df$netmesh, df$townb),
    initial_parent_barcode = df$barcode_initial,
    entry_names = entry_names,
    entry_date = format(entry_date, "%Y/%m/%d"),
    operator_names = df$scanop,
    operator_email = "x",
    operator_institute = "x",
    operator_status = "x",
    pi_names = pi_names,
    pi_email = pi_email,
    pi_institute = pi_institute,
    pi_status = pi_status,
    analysis = analysis,
    magnification = "x",
    cell_size = "x",
    dil_conc_volume = "x",
    dil_conc_method = "x",
    fraction_analysed = df$fracnb,
    fraction_method = df$submethod,
    fracmin = df$fracmin,
    fracsup = df$fracsup,
    subsampleid = df$scanid,
    observation = df$observation,
    children_barcode = df$barcode_children,
    reference_document = "x"
  )
  
  # Return X in any empty column
  print(df_output)
  
  # Call function to create templated workbook
  wb <- createWorksheetTemplate()
  
  # Write data into the templated workbook.
  writeData(wb, sheet = 1, x = df_output, startRow = 3, colNames = FALSE)
  
  return(wb)
}



