library(shiny)
# install.packages("shinythemes")
# class = "btn-success"
library(shinythemes)

# cascading style sheets (CSS).

# cyborg, journal
# theme = shinytheme("cerulean")
#Valid themes are: cerulean, cosmo, cyborg, darkly, flatly, journal, lumen, 
#paper, readable, sandstone, simplex, slate, spacelab, superhero, united, yeti.

# https://bootswatch.com/
# theme = shinytheme("yeti"),

#Add style sheets with the www directory
#Add CSS to your HTML header
#Add styling directly to HTML tags

# These methods correspond to the three ways that you can add CSS to an HTML document. In HTML, you can:
#   
#   Link to a stylesheet file
# Write CSS in the document's header, and
# Write CSS in the style attribute of an HTML element.

# Add style sheets with the www directory
# The www subdirectory is a great place to put 
# CSS files, images, and other things a browser needs to build your Shiny App.

# bootstrap.css
# theme = "bootstrap.css"

#tags$head(
#  tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css")
#),

# Add CSS to your HTML header

#' tags$head(
#'   tags$style(HTML("
#'       @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
#'       
#'       h1 {
#'         font-family: 'Lobster', cursive;
#'         font-weight: 500;
#'         line-height: 1.1;
#'         color: #48ca3b;
#'       }
#' 
#'     "))
#' ),
#' h1("Theme"),
#' 
# Add CSS to the header with includeCSS

# includeCSS("styles.css"),
# includeCSS("www/style.css"),
# Add styling directly to HTML tags

# h1("New Application", 
#    style = "font-family: 'Lobster', cursive;
#         font-weight: 500; line-height: 1.1; 
#         color: #4d3a7d;")),

ui <- fluidPage( 
  #includeCSS("www/style.css"),
 
  sliderInput("obs", "Number of observations", 0, 1000, 500),
  actionButton("goButton", "Go!", class = "btn-primary btn-lg"),
  plotOutput("distPlot")
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    # Take a dependency on input$goButton. This will run once initially,
    # because the value changes from NULL to 0.
    input$goButton
    
    # Use isolate() to avoid dependency on input$obs
    dist <- isolate(rnorm(input$obs))
    hist(dist)
  })
}

shinyApp(ui, server)