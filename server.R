library(ggplot2)

server <- function(input, output) {
    # output abc is text "asdfasdf"
    output$abc <- renderText({
        "im abc"
    })

    output$plot <- renderPlot({
        ggplot(data.frame(x = 1:100, y = (1:100)^2), aes(x = x, y = y)) +
            geom_point()
    })
 }
