library(shiny)
library(numbers)

# we need  Numbers package for fibnocci
# install.packages("numbers")
# Define UI for application that plots random distributions 
ui <- fluidPage(
  
  # Application title
  titlePanel("Learning Reactivity, Sources, Conductors, Endpoinst"),
  
  # Sidebar with a slider input for number of observations
  sidebarLayout(
    sidebarPanel(
      
      
      numericInput("n","fibonacci N",value=3)
    ),
   
    # Show a plot of the generated distribution
    mainPanel(
      
      
      textOutput("nthValue"),
      textOutput("nthValueInv")
    )
  )
)

# Define server logic required to generate and plot a random distribution
server <- function(input, output) {
  
  # I am using R function for Fibonacci
  # This will give ERROR ********************************
 
          #fib <- fibonacci(input$n, sequence = FALSE)
          
          #output$nthValue <- renderText({ fib })
  
  # ****************************************************
  # It's also possible to put 
  #reactive components in between the sources and endpoints. 
  #These components are called reactive conductors.
  # Reactive conductors can be useful for encapsulating slow or 
  # computationally expensive operations.
  
  # With Reactive ********************************
      currentFib         <- reactive({  fibonacci(input$n, sequence = FALSE) })
      output$nthValue    <- renderText({ paste(" Nth Value: ", currentFib()) })
      output$nthValueInv <- renderText({ paste(" 1/ Nth Value: ", 1 / currentFib()) })
  
  # ********************************************
  
  
  # OLD without Reactive
  # Burden on Server
  #output$nthValue    <- renderText({ fibonacci(input$n, sequence = FALSE) })
  #output$nthValueInv <- renderText({ 1 / fibonacci(input$n, sequence = FALSE) })
  
  
   # OK, as long as this is called from the reactive world:
  # currentFib <- function() {
  #   fib(as.numeric(input$n))
  # }
  # output$nthValue <- renderText({ currentFib() })
  
}

shinyApp(ui,server)
