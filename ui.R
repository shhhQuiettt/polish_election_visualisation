source("tab1.R")
source("tab2.R")

ui <- fluidPage(
    navbarPage(
        "Navbar!",
        tabPanel("tab1", tab1UI("tab1")),
        tabPanel("tab2", tab2UI("tab2")),
        tabPanel(
            "Summary",
            textOutput("abc"),
            h3("asdfasdfasdf"),
        ),
    )
)
