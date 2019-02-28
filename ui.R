#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(shinysky)
library(DT)
library(data.table)
library(lubridate)
library(shinyalert)
useShinyalert()
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("DT Editor Minimal Example"),
  shinyjs::useShinyjs(),
  shinyjs::extendShinyjs(text = "shinyjs.refresh = function() { location.reload(); }"),
  actionButton("refresh", "Reset",style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
  
  helpText("Note: Remember to save any updates!"),
  br(),
  ### tags$head() is to customize the download button
  tags$head(tags$style(".butt{background-color:#230682;} .butt{color: #e6ebef;}")),
  downloadButton("Trich_csv", "Download in CSV", class="butt"),
  useShinyalert(), # Set up shinyalert
  uiOutput("MainBody_trich"),actionButton(inputId = "Updated_trich",label = "Save")
))
