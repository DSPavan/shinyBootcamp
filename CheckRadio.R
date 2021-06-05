library(shiny)
library(ggplot2)
attach(iris)

ui <- fluidPage(titlePanel("Sepal Width Boxplot"),
                sidebarLayout(
                  sidebarPanel(
                    checkboxGroupInput(
                      "species",
                      "Species:",
                      c(
                        "Setosa" = "setosa",
                        "Versicolor" = "versicolor",
                        "Virginica" = "virginica"
                      ),
                      #inline = TRUE,
                      selected = "setosa"
                    ),
                    radioButtons(
                      "points",
                      "Points:",
                      c("Outlier" = "outlier", "All" = "all"),
                      inline = TRUE
                    )
                  ),
                  mainPanel(plotOutput("distPlot"))
                ))

server <-  function(input, output) {
  
  df <- reactive({
    return(subset(iris, Species == input$species))
  })
  
  output$distPlot <- renderPlot({
    if (input$points == "outlier") {
      ggplot(data = df(), aes(x = Species, y = Sepal.Width, fill=Species)) + geom_boxplot(
        color = "black",
        #fill = "palegreen",
        outlier.color = "red",
        outlier.shape = 16,
        coef = (input$iqr*1.5)
      ) + ggtitle("Sepal Width Boxplot")
    } else {
      ggplot(data = df(), aes(x = Species, y = Sepal.Width)) + geom_boxplot(
        lwd = 1,
        color = "black",
        fill = "palegreen",
        coef = input$iqr
      ) + geom_dotplot(
        aes(fill = Species),
        binaxis = "y",
        stackdir = "center",
        method = "histodot",
        binwidth = 0.1,
        dotsize = 0.75
      ) + ggtitle("Sepal Width Boxplot") + guides(fill = FALSE)
    }
  })
}

shinyApp(ui, server)