library(ggplot2)

server <- function(input, output) {
    # output abc is text "asdfasdf"
    # output$abc <- renderText({
    #     "im abc"
    # })
  output$testText <- renderText({ 
    paste("Boredom level ",
          input$testRange[1], " - ", 
          input$testRange[2], "%")
  })
  
  # import data from csv okregi.csv
  okregi <- read.csv("okregi.csv",sep=";")
  
  output$table <- DT::renderDT({
    okregi
    },  selection = 'single')
  
  # output$clicked_row <- renderPrint({
  #   cat("You clicked row", input$clicked_row, "\n")
  # })
  
  output$clicked_row <- renderPrint({
      if (is.null(input$table_rows_selected)) return()
      okregi[input$table_rows_selected,1]
  })
  
  # get data from selected row
  # output$selected_row <- renderPrint({
  #   if (is.null(input$table_rows_selected)) return()
  #   okregi[input$table_rows_selected,]
  # })

    # output$plot <- renderPlot({
    #     ggplot(data.frame(x = 1:100, y = (1:100)^2), aes(x = x, y = y)) +
    #         geom_point()
    # })
 }
