
#if (interactive()) { 

library(shiny)

ui <- fluidPage( 
  # UI code here
  titlePanel("First Output"),
  
  sidebarLayout(
    sidebarPanel("Side Panel"),
    mainPanel("Main Panel",
              h1("First level title", align = "center"),
              p("Shiny is a Library in R."),
              strong("Shiny is a Library in R."), br(),
              em("Shiny is a Library in R."),br(),
              code("Shiny is a Library in R."), br(),
              p("Shiny is a Library in R."),
              img(src = "pharma1.jpg", height = 140, width = 400)
              # Folder www required for images
              
              )
  )
  
)

server <- function(input,output)  {
  #server Code Here
  
}


shinyApp(ui,server)

#}
