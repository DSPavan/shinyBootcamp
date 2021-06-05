library(shiny)
library(plotly)
library(ggplot2)
  
  ui <- fluidPage(
    # dynamic sliderinput
    sliderInput("obs", "Number of observations:",
                min = 0, max = 30, value = 10
    ),
    plotOutput("distPlot", width = "40%", height = "300px"),
    plotOutput("distPlotggplot", width = "40%", height = "300px")
  )
  
  # Server logic
  server <- function(input, output) {
    
    # renderPlot
    output$distPlot <- renderPlot({
      #hist(mtcars$mpg[,input$obs])
      x = mtcars$mpg
      bins <- seq(min(x), max(x), length.out = input$obs + 1)
      hist(x, breaks = bins, col = 'orange', border = 'black')
    })
    
    output$distPlotggplot <- renderPlot({
      #hist(mtcars$mpg[,input$obs])
      x = mtcars$mpg
      bins <- seq(min(x), max(x), length.out = input$obs + 1)
      # create plot
      ggplot(data=mtcars, aes(mpg)) + 
        geom_histogram(breaks = bins, 
                       col="black", 
                       fill="green", 
                       alpha=.8)
      
    })
  }
  
  # Complete app with UI and server components
  shinyApp(ui, server)
  