library(shiny)

# Define UI for application that plots random distributions 
ui <- fluidPage(
  
  # Application title
  titlePanel("Learning Reactivity, Sources, Conductors, Endpoinst"),
  
  # Sidebar with a slider input for number of observations
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", 
                  "Number of observations:", 
                  min = 1, 
                  max = 1000, 
                  value = 500),
      
      numericInput("n","Fib N",value=3)
    ),
   
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      textOutput("distText"),
      textOutput("nthValue"),
      textOutput("nthValueInv")
    )
  )
)

# Define server logic required to generate and plot a random distribution
server <- function(input, output) {
  
  fib <- function(n) ifelse(n<3, 1, fib(n-1)+fib(n-2))
  
  output$distPlot <- renderPlot({
    
    # generate an rnorm distribution and plot it
    dist <- rnorm(input$obs)
    hist(dist)
  })
  
  output$distText <- renderText({
    
    # multiple outputs
    #dist <- rnorm(input$obs)
    return(input$obs)
  })
  
  # It's also possible to put 
  #reactive components in between the sources and endpoints. 
  #These components are called reactive conductors.
  
  # Reactive conductors can be useful for encapsulating slow or computationally expensive operations.
  
  currentFib         <- reactive({ fib(as.numeric(input$n)) })
  
  output$nthValue    <- renderText({ currentFib() })
  output$nthValueInv <- renderText({ 1 / currentFib() })
  
  # OR - OLD without Reactive
  #output$nthValue    <- renderText({ fib(as.numeric(input$n)) })
  #output$nthValueInv <- renderText({ 1 / fib(as.numeric(input$n)) })
  
  # Will give error
  #currentFib      <- fib(as.numeric(input$n))
  #output$nthValue <- renderText({ currentFib })
  
  
  # OK, as long as this is called from the reactive world:
  # currentFib <- function() {
  #   fib(as.numeric(input$n))
  # }
  # output$nthValue <- renderText({ currentFib() })
  
}

shinyApp(ui,server)
