library(shiny)
data = iris
ui <- fluidPage(
  titlePanel(title = h4("IRIS Dataset", align="center")),
  sidebarPanel(
    
    radioButtons("species", "Select the Species - Any One",
                 choices = c("setosa", "versicolor","virginica"),
                 selected = "setosa")),
  
  
  mainPanel(
    plotOutput("bar",height = 500))
)

server <- function(input,output){
  
  reactive_data = reactive({
    selected_radio = as.character(input$species)
    return(data[data$Species==selected_radio,])
    
  })
  
  output$bar <- renderPlot({
    
    color <- c("blue", "red","green","pink")
    
    our_data <- reactive_data()
    print(our_data)
    # colSums, colMeans
    # Name of the columns
    barplot(colMeans(our_data[,c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")]),
            ylab="Total",
            xlab="species",
            names.arg = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
            col = color)
    
   
  })
}
shinyApp(ui=ui, server=server)
