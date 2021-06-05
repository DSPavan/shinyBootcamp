
#if (interactive()) { 

library(shiny)
#View(iris) # this is for IRIS Dataset
# This is for adavnced plots
library(plotly)
# install.packages("plotly")
library(ggplot2)
library(ggthemes)


ui <- fluidPage( 
  # UI code here
  # Sidebar layout with input and output definitions ----
  titlePanel(" SelectInput Second Example"),
  sidebarLayout(
    # Sidebar panel for inputs ----
    
    sidebarPanel( id="sidebar",
                  
                  
                  selectInput(inputId = "xcolumn",'X Variable', 
                              choices = c("Species" = "Species", "Sepal Length" = "Sepal.Length"),
                              selected =   "Sepal.Length"),
                  
                  selectInput(inputId = 'ycolumn','Y Variable', names(iris),selectize = FALSE  ),
    ),
    # Main panel for displaying outputs ----
    mainPanel(
      
      column(6,plotlyOutput('plotSelect')),
      column(6,plotOutput('plotSelect2'))
      
      ##plotlyOutput('plotSelect')
    )
    
  )                 
  
)

server <- function(input,output)  {
  #server Code Here
  # REACTIVE
  x <- reactive({
    iris[,input$xcolumn]
  })
  
  
  
  y <- reactive({
    iris[,input$ycolumn]
  })
  
  
  # renderPlotly
  output$plotSelect <- renderPlotly(

    plot1 <- plot_ly(
      x = x(),
      y = y(),
      type = 'scatter', # "scatter", "bar", "box"
      mode = 'markers', # related to scatter
      color = ~iris$Species,
      symbols =   ~iris$Species,

    )
  )
    

  output$plotSelect2<-renderPlot({
    
    ggplot(iris,aes(x=x(),y=y(), color=Species))+geom_point()},
    
    )
  #Plot interactions
  
  
  
}


shinyApp(ui,server)

#}
