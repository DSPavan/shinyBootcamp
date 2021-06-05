
#if (interactive()) { 

library(shiny)
#View(iris) # this is for IRIS Dataset

ui <- fluidPage( 
  # UI code here
  # Sidebar layout with input and output definitions ----
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
      
      plotOutput('plotSelect')
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
  
  
  output$plotSelect <- renderPlot({
    x = x()
    y = y()
    #print(x,y)
    plot(x, y)
  })
  
  
  
}


shinyApp(ui,server)

#}
