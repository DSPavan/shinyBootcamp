library(shiny)
library(dplyr)

ProductRecord <- data.frame(
  # YYYY-MM-DD
  # temp in Celscius
  ProductName = c("Cat A","Cat B","Cat A","Cat D","Cat B"),
  Price = c(3800,3700,3645,4214,3185),
  Quantity = c(1,0.5,0.8,0.5,1)
  
)

ui <- fluidPage(
  # Copy the line below to make a slider range 
  sliderInput("sliderRange1", label = h3("Slider Range"), min = 3000, 
              max = 5000, value = c(3800, 4100)),
  
  verbatimTextOutput("prodRangeText"),
  tableOutput("proRangeTable"),
)

server <- function(input,output) { 
  
  output$prodRangeText <- renderText({
    paste("Selected Range date: FROM ", as.character(input$sliderRange1[1]), "TO",
          as.character(input$sliderRange1[2]))
  })
  
  output$proRangeTable  <- renderTable({
    # Between Date range
    filter(ProductRecord, Price >= input$sliderRange1[1] & Price <= input$sliderRange1[2])
  })
  
  
  }

shinyApp(ui,server)
                 