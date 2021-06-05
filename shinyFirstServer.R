
#if (interactive()) { 

library(shiny)
# using mtcars dataset
# TRY - with and without sidebarLayout
# TRY sidebarLayout, verticalLayout, splitLayout

ui <- fluidPage( 
  # UI code here
  titlePanel("
Eg: ui and server interaction"),
  sidebarLayout(
    sidebarPanel(
  # Input - Slider
              sliderInput(inputId = "bins",
              label = "Number of bins:",
              min = 1,
              max = 35,
              value = 5),
    ),
  mainPanel(
  # print(max(mtcars$mpg))
  # Output: Histogram ----
   plotOutput(outputId = "distPlot")
  )
  
  )
)


server <- function(input,output)  {
  #server Code Here
  output$distPlot <- renderPlot({
    
    x    <- mtcars$mpg
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins)
    # using MTCARS dataset
    # input >>> bins
    # output >>>> distPlot
    # render*
    
  })
  
}


shinyApp(ui,server)

# from Console
#runApp('Udemy/shinyFirstServer.R', display.mode = "showcase")

#}
