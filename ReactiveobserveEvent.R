library(shiny)

# In Shiny, there are three kinds of objects in reactive programming: 
#reactive sources, reactive conductors, and reactive endpoints, 
#which are represented with these symbols:

#https://shiny.rstudio.com/articles/reactivity-overview.html

# https://shiny.rstudio.com/articles/isolation.html

ui <- fluidPage(
titlePanel("Sum of two integers"),

#number input form
sidebarLayout(
  sidebarPanel(
    textInput("one", "First Integer"),
    textInput("two", "Second Integer"),
    actionButton("addButton", "Add")
  ),
  
  # Show result
  mainPanel(
    
    textOutput("sum"),
    textOutput("distText")
    
  )
)
)
  
  server <- function(input,output,session) {
    #observe the add click and perform a reactive expression
    observeEvent( input$addButton,{
      x <- as.numeric(input$one)
      y <- as.numeric(input$two)
      #reactive expression
      n <- x+y
      output$sum <- renderPrint(n)
    }
       )
    
     }
    
    
    
    shinyApp(ui,server)