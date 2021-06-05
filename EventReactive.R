library(shiny)

# eventReactive
# similar to Reactive
#eventReactives are not dependent on all reactive expressions in their body 
#Instead, they are 
# only dependent on the expressions specified in the event section.

ui <- fluidPage(
  headerPanel("Example eventReactive"),
  
  mainPanel(
    
    # input field
    textInput("user_text", label = "Enter some text:", placeholder = "Please enter some text."),
    
    # submit button
    actionButton("submit", label = "Submit"),
    
    # display text output
    textOutput("text"),
    textOutput("text2"),
    textOutput("text3"),
    )
)

server <- function(input, output) {
  
  # reactive expression
  text_reactive <- eventReactive( input$submit, {
    #input$user_text
    text_reactive$text <- input$user_text
  })
  # text output
  output$text <- renderText({
    text_reactive()
  })
  
  # reactive expression ##############
  text_reactive2 <- reactive( {
    input$user_text
  })
  
  # text output
  output$text2 <- renderText({
    text_reactive2()
  })
  ## reactiveValues can be used to store objects, to which other expressions can take a dependency.
  # reactiveValues
   
  # reactiveValues
  text_reactive3 <- reactiveValues(
    text = "No text has been submitted yet."
  )
  
  # text output
  output$text3 <- renderText({
    text_reactive3$text
    #text_reactive$text <- input$user_text
  })
  
  ##
  # observe event for updating the reactiveValues
  
  
}

shinyApp(ui,server)
