library(openxlsx)
  
createWorksheetTemplate <- function() {
  ###
  # Create a template for the excel table used as output.
  # Output : 
  #   - wb : Template of a workbook with proper header and merged cells. 
  ###
  
  # Create a new workbook
  wb <- createWorkbook()
  
  # Define custom header style
  header_style <- createStyle(
    fontSize = 11,
    fontColour = "#000000",
    halign = "center",
    valign = "center",
    border = "TopBottomLeftRight",
    borderColour = "#000000"
  )
  
  
  # Add a worksheet
  addWorksheet(wb, "Sheet 1")
  
  # Merge cells and define headers
  mergeCells(wb, 1, cols = 1, rows = 1:2)
  writeData(wb, 1, "ID lot", startCol = 1, startRow = 1)
  
  mergeCells(wb, 1, cols = 2, rows = 1:2)
  writeData(wb, 1, "Parent Barcode", startCol = 2, startRow = 1)
  
  mergeCells(wb, 1, cols = 3, rows = 1:2)
  writeData(wb, 1, "Parent Jar", startCol = 3, startRow = 1)
  
  mergeCells(wb, 1, cols = 4, rows = 1:2)
  writeData(wb, 1, "Initial Barcode", startCol = 4, startRow = 1)
  
  mergeCells(wb, 1, cols = 5:6, rows = 1)
  writeData(wb, 1, "Entry information", startCol = 5, startRow = 1)
  writeData(wb, 1, "First and Last names", startCol = 5, startRow = 2)
  writeData(wb, 1, "Date (YYYY/MM/DD)", startCol = 6, startRow = 2)
  
  mergeCells(wb, 1, cols = 7:10, rows = 1)
  writeData(wb, 1, "Analysis Operator", startCol = 7, startRow = 1)
  writeData(wb, 1, "First and Last names", startCol = 7, startRow = 2)
  writeData(wb, 1, "Mail adress", startCol = 8, startRow = 2)
  writeData(wb, 1, "Institute", startCol = 9, startRow = 2)
  writeData(wb, 1, "Status (student / ITA/ researcher / other)", startCol = 10, startRow = 2)
  
  mergeCells(wb, 1, cols = 11:14, rows = 1)
  writeData(wb, 1, "Scientific Analysis Manager", startCol = 11, startRow = 1)
  writeData(wb, 1, "First and Last names", startCol = 11, startRow = 2)
  writeData(wb, 1, "Mail adress", startCol = 12, startRow = 2)
  writeData(wb, 1, "Institute", startCol = 13, startRow = 2)
  writeData(wb, 1, "Status (student / ITA/ researcher / other)", startCol = 14, startRow = 2)
  
  mergeCells(wb, 1, cols = 15, rows = 1:2)
  writeData(wb, 1, "Analysis ( zooscan/flowcam/taxo identification/genetic analysis)", startCol = 15, startRow = 1)
  
  mergeCells(wb, 1, cols = 16, rows = 1:2)
  writeData(wb, 1, "Magnification", startCol = 16, startRow = 1)
  writeData(wb, 1, c("Cell size", "µm"), startCol = 17, startRow = 1)
  writeData(wb, 1, c("Dilution/Concentration volume", "ml"), startCol = 18, startRow = 1)
  writeData(wb, 1, c("Dil/Conc method", "txt"), startCol = 19, startRow = 1)
  writeData(wb, 1, c("Fraction analysed", "ex : 1/X ou vol en ml"), startCol = 20, startRow = 1)
  writeData(wb, 1, c("Fraction method", "txt"), startCol = 21, startRow = 1)
  writeData(wb, 1, c("fracmin (sieve mesh)", "µm"), startCol = 22, startRow = 1)
  writeData(wb, 1, c("fracsup (sieve mesh)", "µm"), startCol = 23, startRow = 1)
  
  mergeCells(wb, 1, cols = 24, rows = 1:2)
  writeData(wb, 1, "subsampleID", startCol = 24, startRow = 1)
  
  mergeCells(wb, 1, cols = 25, rows = 1:2)
  writeData(wb, 1, "Observation during analysis", startCol = 25, startRow = 1)
  
  mergeCells(wb, 1, cols = 26, rows = 1:2)
  writeData(wb, 1, "Children Barcode", startCol = 26, startRow = 1)
  
  mergeCells(wb, 1, cols = 27, rows = 1:2)
  writeData(wb, 1, "Reference documents", startCol = 27, startRow = 1)
  
  
  # Apply header style to header area
  addStyle(wb, 1, style = header_style, rows = 1:2, cols = 1:27, gridExpand = TRUE)
  
  # Define columns width
  options("openxlsx.minWidth" = 10)
  setColWidths(wb, 1, cols = 1:27, widths = "auto")
  
  # Return workbook as output
  return(wb)
}
  
