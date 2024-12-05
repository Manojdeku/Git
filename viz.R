library(shiny)
library(shinyjs)

# Define the UI
ui <- fluidPage(
  titlePanel("Advanced Random Number Visualizations"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("num", "Number of Random Numbers:", min = 10, max = 500, value = 50),
      actionButton("generate", "Generate Numbers"),
      textInput("plot_title", "Plot Title", value = "Random Numbers Visualization"),
      colorInput("plot_color", "Choose Plot Color", value = "skyblue"),
      selectInput("plot_type", "Choose Plot Type", 
                  choices = c("Histogram", "Box Plot", "Density Plot"), selected = "Histogram")
    ),
    
    mainPanel(
      plotOutput("mainPlot"),
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
  
  output$mainPlot <- renderPlot({
    data <- random_numbers()
    
    if (input$plot_type == "Histogram") {
      hist(data, main = input$plot_title, xlab = "Values", col = input$plot_color, border = "white")
    } else if (input$plot_type == "Box Plot") {
      boxplot(data, main = input$plot_title, col = input$plot_color)
    } else if (input$plot_type == "Density Plot") {
      plot(density(data), main = input$plot_title, col = input$plot_color, lwd = 2)
    }
  })
  
  output$summary <- renderPrint({
    summary(random_numbers())
  })
}

# Run the application
shinyApp(ui = ui, server = server)
