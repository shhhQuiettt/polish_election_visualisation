# Doesn't work
tab1UI <- function(id) {
    ns <- NS(id)
    fluidPage(
        h2("Plot"),
        plotOutput("plot"),
        h3("asdfasdfasdf"),
        textOutput(ns("abc")),
        h3("dup"),
    )
}
