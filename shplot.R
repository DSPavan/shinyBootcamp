library(shiny)
library(plotly)

# mtcars,IRIS

ui <- fluidPage(
  headerPanel('Example'),
  sidebarPanel(
    selectInput('xcol','X Variable', names(iris)),
    selectInput('ycol','Y Variable', names(iris)),
    selected = names(iris)[[2]]),
  mainPanel(
   plotlyOutput('plot'),
    plotlyOutput('plotDiamond')
  )
  
 
)

server <- function(input, output) {
  
  x <- reactive({
    iris[,input$xcol]
  })
  
  y <- reactive({
    iris[,input$ycol]
  })
  
  
  output$plot <- renderPlotly(
    plot1 <- plot_ly(
      x = x(),
      y = y(), 
      type = 'scatter',
      mode = 'markers')
  )
  
  data(diamonds, package = "ggplot2")
  #plot_ly(diamonds, x = , color = ~clarity, colors = "Accent")
  
  output$plotDiamond <- renderPlotly(
    plot1 <- plot_ly(
      x = diamonds$cut,
      color = diamonds$clarity,
      colors = "Accent"
    )
  )
  
}

shinyApp(ui,server)

#runApp("shplot.R", display.mode = "showcase")



