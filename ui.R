source("districtsUI.R")
source("filtersUI.R")
source("tab2.R")
library(shinydashboard)
library(bslib)

ui <- dashboardPage(
    dashboardHeader(title = "Dashboard"),
    dashboardSidebar(disable = TRUE),
    dashboardBody(
        navbarPage(
            "Navbar!",
            tabPanel("Filters", filtersUI("tab2")),
            tabPanel("Districts results", districtsUI("districtsUI")),
            tabPanel("tab2", tab2UI("tab2")),
            tabPanel(
                "Summary",
                textOutput("abc"),
                h3("asdfasdfasdf"),
            ),
            theme = bs_theme(bootswatch = "journal")
        )
    )
)
