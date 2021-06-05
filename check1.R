
#if (interactive()) { 

library(shiny)
library(plotly)

ui <- fluidPage( 
  titlePanel(" Example Checkbox: "),
  # UI code here
  sidebarLayout(
    sidebarPanel (
      
  h4("Please check for Diamonds Dataset"),
  h4("Individual check"),
  checkboxInput("test1", "Show summary", FALSE),
  
  # Add checkbox gRoup
  checkboxGroupInput("varSelect", "Choose Group Checkbox",
                     c("cut","color","clarity"),selected = "cut"),
  
  
    ),
  mainPanel (
    verbatimTextOutput("summary"),
    br(),
  
  column(4, plotlyOutput('plot2')),
  column(4,plotlyOutput('plot3')),
  column(4,plotlyOutput('plot4')),
  ##
 
    )
  )
  
)

server <- function(input,output, session)  {
  
  observe({
    # TRUE if input$controller is odd, FALSE if even.
    
    if("color" %in% input$varSelect){
      
    updateCheckboxInput(session, "test1", value = TRUE)
    }
    else{
      updateCheckboxInput(session, "test1", value = FALSE)
    }
  })
  
  output$summary <- renderPrint(
    if(input$test1 == TRUE) {
      summary(diamonds)
    }
  )
  
  suppressPlotlyMessage <- function(p) {
    suppressMessages(plotly_build(p))
  }
  
  #server Code Here
  output$plot2 <- renderPlotly(
    if("cut" %in% input$varSelect){
      color = rainbow(10)
      plot2b <- plot_ly( diamonds, x = ~cut, marker = list(color = c('blue', 'green',
                                                                     'red', 'black',
                                                                     'orange'))) 
    }
    
  )
  
  
  output$plot3 <- renderPlotly(
    if("color" %in% input$varSelect){
      plot2b <- plot_ly(diamonds, x = ~color, marker = list(color = c('blue', 'green',
                                                                      'red', 'black',
                                                                      'orange','pink','yellow')))      
    }
    
  )
  
  output$plot4 <- renderPlotly(
    if("clarity" %in% input$varSelect){
      plot2b <- plot_ly(
        diamonds, x = ~clarity , marker = list(color = c('blue', 'green',
                                                         'red', 'black',
                                                         'orange','pink','yellow')))  
    }
    
  )
  
}


shinyApp(ui,server)

#}
