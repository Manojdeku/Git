library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Interactive Random Number Generator"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("num", "Number of Random Numbers:", min = 10, max = 500, value = 50),
      actionButton("generate", "Generate Numbers"),
      textInput("plot_title", "Plot Title", value = "Random Numbers Histogram"),
      colorInput("plot_color", "Choose Plot Color", value = "skyblue")
    ),
    
    mainPanel(
      plotOutput("histPlot"),
      verbatimTextOutput("summary")
    )
  )
)

# Define the Server
server <- function(input, output) {
  random_numbers <- reactiveVal()
  
  observeEvent(input$generate, {
    random_numbers(rnorm(input$num))
  })
  
  output$histPlot <- renderPlot({
    hist(random_numbers(), 
         main = input$plot_title, 
         xlab = "Values", 
         col = input$plot_color, 
         border = "white")
  })
  
  output$summary <- renderPrint({
    summary(random_numbers())
  })
}

# Run the application
shinyApp(ui = ui, server = server)
