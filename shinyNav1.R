
library(shiny)
library("MASS") # data for chi-square
ui <- fluidPage(
  
  titlePanel("Navlist panel example"),
  # navbarPage , navlistPanel
  # navbarPage Secondary Navigation
  
  navbarPage( 
    title = span( "Header", style = "color:red; background-color:yellow;" ),
   
                     
    tabPanel("First",
             h3("Summary"), verbatimTextOutput("sum"),
    ),
    tabPanel("Second",
             h3("Plot"), plotOutput("Plot"),
    ),
    tabPanel("Third",
             h3("Chisq"), verbatimTextOutput("chisq"),
    ),
    navbarMenu("More",
               tabPanel("Sub-Component A", h3("sub A")),
               tabPanel("Sub-Component B", h3("sub B")))
  ),
  
  
)

server <- function(input,output) {
  
  output$sum <- renderPrint({
    
    summary(iris)
  })
  
  output$Plot <- renderPlot({
    x <- mtcars$wt
    y <- mtcars$mpg
    # Plot with main and axis titles
    # Change point shape (pch = 19) and remove frame.
    
    # Add regression line
    plot(x, y, main = "Main title",
         xlab = "X axis title", ylab = "Y axis title",
         pch = 19, frame = TRUE)
    abline(lm(y ~ x, data = mtcars), col = "blue")
  })
  
  
 
  # Load the library.
  
  output$chisq <- renderPrint({
  # Create a data frame from the main data set.
  car.data <- data.frame(Cars93$AirBags, Cars93$Type)
  
  # Create a table with the needed variables.
  car.data = table(Cars93$AirBags, Cars93$Type) 
  print(car.data)
  
  # Perform the Chi-Square test.
  print(chisq.test(car.data))
  })
  
}

shinyApp(ui,server)
