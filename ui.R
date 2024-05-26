ui <- fluidPage(
  numericInput(inputId = "Num",
               "Sample size", value = 14),
  plotOutput(outputId = "LinePlot")
)

