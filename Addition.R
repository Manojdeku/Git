5+5
20+20


plot_normal_pdf <- function(mean, sd, n) {
  # Generate a sequence of values from the normal distribution
  x <- seq(mean - 4 * sd, mean + 4 * sd, length.out = n)
  
  # Calculate the PDF values for the sequence
  y <- dnorm(x, mean = mean, sd = sd)
  
  # Plot the PDF
  plot(x, y, type = "l", lwd = 2, col = "blue",
       xlab = "Value", ylab = "Density",
       main = paste("Normal Distribution (mean =", mean, ", sd =", sd, ")"))
  
  # Add a grid for better visualization
  grid()
}

# Example usage
plot_normal_pdf(mean = 10, sd = 5, n = 100)
