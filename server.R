
library(shiny)
library(shinyjs)
## shinysky is to customize buttons
library(shinysky)
library(DT)
library(data.table)
library(lubridate)
library(shinyalert)

rm(list = ls())
useShinyalert()
shinyServer(function(input, output, session){
  
  ### interactive dataset 
  vals_trich<-reactiveValues()
  vals_trich$Data<-readRDS("note.rds")
  
  observeEvent(input$refresh, {
    shinyjs::js$refresh()
  })
  #### MainBody_trich is the id of DT table
  output$MainBody_trich<-renderUI({
    fluidPage(
          hr(),
          column(12,dataTableOutput("Main_table_trich"))
      ) 
    })
  
  #### render DataTable part ####
  output$Main_table_trich<-renderDataTable({
    DT=vals_trich$Data
    datatable(DT,editable = TRUE, selection = "none") 
    }, server = T )
  
  proxy = dataTableProxy('Main_table_trich')
  
  observeEvent(input$Main_table_trich_cell_edit, {
    
    info = input$Main_table_trich_cell_edit
    
    str(info) 
    i = info$row 
    j = info$col 
    v = info$value
    
    vals_trich$Data[i, j] <<- DT::coerceValue(v, vals_trich$Data[i, j]) 
    replaceData(proxy, vals_trich$Data, resetPaging = FALSE) # important
      
    
  })


  ### save to RDS part 
  observeEvent(input$Updated_trich,{
    saveRDS(vals_trich$Data, "note.rds")
    shinyalert(title = "Saved!", type = "success")
  })
  



 
 ### This is nothing related to DT Editor but I think it is nice to have a download function in the Shiny so user 
 ### can download the table in csv
  output$Trich_csv<- downloadHandler(
    filename = function() {
      paste("Trich Project-Progress", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(data.frame(vals_trich$Data), file, row.names = F)
    }
  )
 
})
