
library(shiny)
library(dplyr)



ui <- fluidPage(
  numericInput("obs", "NUMERIC Input --- Observations:", 10, min = 1, max = 100),
  textInput("formatNumber1", "TEXT Input --  Number should be formatted, e.g.5,000,000", value = 1000),
  
  verbatimTextOutput("value"),
  textOutput("txtOutput")
)
server <- function(input, output,session) {
  # session
  
  observe({
    updateTextInput(session, "formatNumber1", "TEXT Input -- Number should be formatted, e.g.5,000,000", 
                    value = prettyNum(input$formatNumber1, big.mark=",", scientific=FALSE))
   
  })
  
  output$value <- renderText({ input$obs })
  
  output$txtOutput = renderText({
    paste0("The area of the circle is: ", pi*input$obs^2)
  })
  
  
}
shinyApp(ui, server)




