districtsServer <- function(input, output, session) {
    print("hi")
    output$plot <- renderPlot(curve(x^2))

}
