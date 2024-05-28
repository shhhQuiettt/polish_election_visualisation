library(ggplot2)
source("districtsServer.R")

server <- function(input, output) {
    output$testText <- renderText({
        paste(
            "Boredom level ",
            input$testRange[1], " - ",
            input$testRange[2], "%"
        )
    })

    # import data from csv okregi.csv
    okregi <- read.csv("okregi.csv", sep = ";")

    output$table <- DT::renderDT(
        {
            okregi
        },
        selection = "single"
    )

    output$clicked_row <- renderPrint({
        if (is.null(input$table_rows_selected)) {
            return()
        }
        okregi[input$table_rows_selected, 1]
    })

    output$clicked_d  <-  renderPrint({
        if (is.null(input$clicked_district)) {
            return()
        }
        input$clicked_district
    })


    # callModule(districtsServer, "districtsServer")
}
