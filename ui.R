#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library("shiny")
library("DT")
source("/home/app/lib_shiny.R")

# Create the input lists for combo
entry_name_choices <- c("Amanda Elineau",
                        "Anthea Bourrhis",
                        "Emmanuelle Martins",
                        "Marie Hagstrom",
                        "Solène Motreuil",
                        "Thibaut Lamarca")

pi_name_choices <- c("Alexandre Alié",
                     "Cécile Fauvelot",
                     "Cécile Guieu",
                     "Fabien Lombard",
                     "Frédéric Gazeau",
                     "Gabriel Gorsky", 
                     "Jean-Olivier Irisson",
                     "Lars Stemmann",
                     "Laurent Coppola",
                     "Lionel Guidi",
                     "Maria-Luiza Pedrotti",
                     "Patrick Pouline",
                     "Romain Le Gall")

pi_email_choices <- c("alexandre.alie@imev-mer.fr",
                      "cecile.fauvelot@ird.fr ",
                      "cecile.guieu@imev-mer.fr",
                      "frederic.gazeau@imev-mer.fr",
                      "gorsky@imev-mer.fr", 
                      "jean-olivier.irisson@imev-mer.fr",
                      "lars.stemmann@imev-mer.fr",
                      "laurent.coppola@imev-mer.fr",
                      "lguidi@imev-mer.fr",
                      "lombard@imev-mer.fr",
                      "pedrotti@imev-mer.fr",
                      "patrick.pouline@ofb.gouv.fr",
                      "legall@creocean.fr")

pi_institute_choices <- c("Creocean", "IMEV", "LOV", "OFB", "PNMIR")

pi_status_choices <- c("ITA", "Researcher", "Student", "Other")

analysis_choices <- c("Flowcam", "Genetic analysis", "Taxo identification", "Zooscan")


# Define UI for application
fluidPage(
  lov_css(), 
  
  titlePanel("CSV to Excel Converter for analysis table"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("sample_file", "Choose Sample CSV File", accept = ".csv", multiple = TRUE),
      fileInput("scan_file", "Choose Scan CSV File", accept = ".csv", multiple = TRUE),
      textInput("output_name", "Enter Output File Name (without extension)", value = "Inventory_x_sampling"),
      selectizeInput("entry_name", "Name and surname", choices = entry_name_choices, selected = "Amanda Elineau", options=list(create=TRUE)),
      dateInput("selected_date", "Select Date", value = Sys.Date()), 
      textInput("id_lot", "ID Lot"),
      selectizeInput("pi_name", "PI Name and surname", choices = pi_name_choices, selected = "Alexandre Alié", options=list(create=TRUE), multiple = TRUE),
      selectizeInput("pi_email", "PI email address", choices = pi_email_choices, selected = "alexandre.alie@imev-mer.fr", options=list(create=TRUE), multiple = TRUE),
      selectizeInput("pi_institute", "PI Institute", choices = pi_institute_choices, selected = "IMEV", options=list(create=TRUE), multiple = TRUE),
      selectizeInput("pi_status", "PI Status", choices = pi_status_choices, selected = "Researcher", options=list(create=TRUE), multiple = TRUE),
      selectizeInput("analysis", "Analysis", choices = analysis_choices, selected = "Zooscan", options=list(create=TRUE)),
      
      downloadButton("download_excel", "Download Excel File")
    ),
    
    mainPanel(
      DTOutput("preview_sample_table"),
      DTOutput("preview_scan_table")
    )
  )
)
