library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Random Number Generator"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("num", "Number of Random Numbers:", min = 10, max = 500, value = 50),
      actionButton("generate", "Generate Numbers")
    ),
    mainPanel(
      plotOutput("histPlot")
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
    hist(random_numbers(), main = "Histogram of Random Numbers", xlab = "Values", col = "skyblue", border = "white")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
