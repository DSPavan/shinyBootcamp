library(shiny)
library(plotly)



# Define UI for random distribution app ----
ui <- fluidPage(
  
  tags$head(tags$style(
    HTML('
         
         #sidebar {
            background-color: pink ;
         }
         
         #xcol ~ .selectize-control .option:nth-child(even) {
          background-color: rgba(30,144,255,0.5);
          color:red;

         }
         #xcol ~ .selectize-control .option:nth-child(odd) {
          background-color: green;
          color:orange;

        }

        #ycol~ .selectize-control 
        .selectize-input {white-space: nowrap; color: red;} 
        .selectize-dropdown{  color: red;} 
        .option:nth-child(even) { background-color: yellow;  } 
        
        
         
        

        body, label, input, button, select { 
          font-family: "Arial";
          #background-color:green;
        }')
  )),
  
  
  
  # App title ----
  titlePanel("Tabsets"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    # Sidebar panel for inputs ----
    
    sidebarPanel( id="sidebar",
                
                  
      selectInput(inputId = "xcol",'X Variable', choices = c("Species" = "Species",
                                                     "SL" = "Sepal.Length"), selected =   "Sepal.Length"),
      tags$style("#ycol {background-color:yellow; color:red}"),
      
      selectInput(inputId = 'ycol','Y Variable', names(iris),selectize = FALSE  ),
      
      # #selected = names(iris)[[2]]  # ALternative
      #
      h4("Please check for Diamonds"),
      # Add checkbox for best fit line
      checkboxGroupInput("varSelect", "Variables to show:",
                         c("cut","color","clarity"),selected = "cut"),
    ),
      
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",id = "analysis_tabs",
                  tabPanel("plot", id = "pk", plotlyOutput('plot')),
                  tabPanel("plot2",id ="pk2", fluidRow(
                    column(4, plotlyOutput('plot2')),
                    column(4,plotlyOutput('plot3')),
                    column(4,plotlyOutput('plot4')),
                  )
                  
      )
      
    )
  )
)
)


# Define server logic for random distribution app ----
server <- function(input, output) {
  
  observe({
    print(input$analysis_tabs)
   
  })
  
  
  
  
  x <- reactive({
    iris[,input$xcol]
  })
  
  
  
  y <- reactive({
    iris[,input$ycol]
  })
  
  
  
 
  output$plot <- renderPlotly(
    plot1 <- plot_ly(
      x = x(),
      y = y(), 
      type = 'scatter',
      mode = 'markers')
  )
  
  data(diamonds, package = "ggplot2")
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

# tags$style("#ycol {background-color:green;}"),

shinyApp(ui,server)