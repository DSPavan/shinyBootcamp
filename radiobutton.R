data = data.frame(Population=sample(1:20,10),Households = sample(1:20,10), year=sample(c(2000,2010),10,replace=T))

ui <- fluidPage(
  titlePanel(title = h4("Hillsborough County Population by Census", align="center")),
  sidebarPanel(
    
    radioButtons("YEAR", "Select the Census Year",
                 choices = c("2000", "2010"),
                 selected = "2000")),
  
  
  mainPanel(
    plotOutput("bar",height = 500))
)

server <- function(input,output){
  
  reactive_data = reactive({
    selected_year = as.numeric(input$YEAR)
    return(data[data$year==selected_year,])
    
  })
  
  output$bar <- renderPlot({
    
    color <- c("blue", "red")
    
    our_data <- reactive_data()
    
    barplot(colSums(our_data[,c("Population","Households")]),
            ylab="Total",
            xlab="Census Year",
            names.arg = c("Population", "Households"),
            col = color)
  })
}
shinyApp(ui=ui, server=server)
