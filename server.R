library(ggplot2)

server <- function(input, output) {

  output$LinePlot <- renderPlot({
    x=seq(0, input$Num, 0.1)
    y=sin(x)
    df <- data.frame(x, y)

    ggplot(data = df, aes(x, y)) +
      geom_line() +
      labs(x = "Time", y = "Sine Wave")
  })
 }
