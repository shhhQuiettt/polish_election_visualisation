read_svg <- function(file) {
    readLines(file, warn = FALSE)
}

districtsServer <- function(input, output, session) {
    # output$plot <- renderPlot(curve(x^2))
    print("ge")
    output$plot <- renderPlot(curve(x^2))
    # output$clicked_d <- renderPrint({

    #     if (is.null(input$clicked_district)) {
    #         return()
    #     }
    #     input$clicked_district
    # })
    # output$dummy = renderPrint({
    #     "dummy"
    # })
}
