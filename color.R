library(shiny)

ui <- fluidPage(
  tags$head(tags$style(HTML('
    .selectize-input {white-space: nowrap}
    #input1+ div>.selectize-dropdown{width: 660px !important; font-style: italic; font-weight: bold; color: green;}
    #input1+ div>.selectize-input{width: 660px !important; font-style: italic; font-weight: bold; color: green; margin-bottom: -10px;}
    #input2+ div>.selectize-dropdown{width: 300px !important; color: red;}
    #input2+ div>.selectize-input{width: 300px !important; color: red; margin-bottom: 0px;}
                            '))),
  
  selectizeInput("input1", "label1", c("A", "B", "C")),
  selectizeInput("input2", "label2", c("D", "E", "F"))
)

server <- function(input, output, session){}
shinyApp(ui = ui, server = server)



  x <- reactive({
    iris[,input$xcol]
  })
  
  # Warning: Error in : object of type 'closure' is not subsettable
 
  
  y <- reactive({
    iris[,input$ycol]
  })
  
  # getting Lebel to plotly - how??
  
  # output$plot <- renderPlotly(
  #   
  #   plot1 <- plot_ly(
  #     x = x(),
  #     y = y(), 
  #     
  #     type = 'scatter',
  #     mode = 'markers',
  #     xaxis= " AAAAA") %>% 
  #     layout(plot_bgcolor='yellow')
  # )
  