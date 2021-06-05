library(shiny)
library(dplyr)

#library(factoextra)
#library(ggplot2)
#
# install.packages("factoextra")

attach(iris)

vars <- setdiff(names(iris), "Species")
ui <- fluidPage(
  headerPanel("Plot with K-Means with NumericInput (Eg: in this = clusterCount)"),
  sidebarLayout(
    sidebarPanel(
      selectInput('xcol', 'X Variable', vars),
      selectInput('ycol', 'Y Variable', vars, selected = vars[[2]]),
      numericInput('clusters', 'Cluster count', 3, min = 1, max = 9)
    ),
    mainPanel(textOutput("txtOutput"),
              plotOutput('plot1'))
  )
)

server <- function(input, output, session) {
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  output$plot1 <- renderPlot({
    palette(
      c(
        "#E41A1C",
        "#377EB8",
        "#4DAF4A",
        "#984EA3",
        "#FF7F00",
        "#FFFF33",
        "#A65628",
        "#F781BF",
        "#999999"
      )
    )
    
    par(mar = c(5.1, 4.1, 0, 1))
    plot(
      selectedData(),
      col = clusters()$cluster,
      pch = 20,
      cex = 3
    )
    points(clusters()$centers,
           pch = 4,
           cex = 4,
           lwd = 4)
  })
  
  #output$value <- renderText({ input$obs })
  
  output$txtOutput = renderText({
    paste0("K means Plot ", input$obs)
  })
  
}

shinyApp(ui, server)
# https://shiny.rstudio.com/gallery/kmeans-example.html
