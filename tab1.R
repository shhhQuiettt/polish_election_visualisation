tab1UI <- function(id) {
    # ns <- NS(id)
    splitLayout(
        sidebarPanel(h2("Sidebar")),
        mainPanel(
            h3("plot"),
            plotOutput("plot")
        )
    )
}
