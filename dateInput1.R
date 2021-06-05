
library(shiny)
library(car) # for scatterplot
library(dplyr)
#library(DT)

dateRecord <- data.frame(
  # YYYY-MM-DD
  # temp in Celscius
  dateR = c("2020-10-18","2020-10-19","2020-10-20","2020-10-21","2020-10-22"),
  temp = c(38,37,36,42,31),
  oxygen = c(0.2,0.3,0.1,0.3,0.2)
  
)

#filter(dateRecord, dateR == "2020-10-20")

ui <- fluidPage(
  
  sidebarLayout(
    # Sidebar panel for inputs ----
    
    sidebarPanel(
      
    wellPanel(  
    dateInput("date2", "Date: yyyy/mm/dd"),
      ),
    #dataTableOutput("dateText2"),
      wellPanel(
        dateRangeInput('dateRange',
                       label = 'Date range input: yyyy-mm-dd',
                       start = Sys.Date() - 2, end = Sys.Date() + 2
        ),
      )
    ),
    
  mainPanel(
  verbatimTextOutput("dateText"),
  tableOutput("dateText2"),
  verbatimTextOutput("dateRangeText"),
  tableOutput("dateRangeNew"),
  ),
  
      ),
)

server <- function(input,output) {
  
  output$dateText <- renderText({
    paste("Selected date between 2020-10-18  and 2020-10-22. Current Selected date ", 
          as.character(input$date2))
  })
  
  
  output$dateText2 <- renderTable({
    
    
    filter(dateRecord, dateR == as.character(input$date2))
    
  })
  
  output$dateRangeText <- renderText({
    paste("Selected Range date   between 2020-10-18  and 2020-10-22: FROM "
          , as.character(input$dateRange[1]), "TO",
          as.character(input$dateRange[2]))
  })
  
  output$dateRangeNew  <- renderTable({
     # Between Date range
    filter(dateRecord, dateR >= input$dateRange[1] & dateR <= input$dateRange[2])
  })
  
}

shinyApp(ui,server)






