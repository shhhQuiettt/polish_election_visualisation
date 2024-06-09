source("districtsUI.R")
source("tab2.R")
source("tab3_w.R")

library(shinydashboard)
library(bslib)

ui <- dashboardPage(
  dashboardHeader(title = "Dashboard"),
  # remove the sidebar
  dashboardSidebar( disable = TRUE),
  dashboardBody(
  fluidPage(
    navbarPage(
        "Navbar!",
        tabPanel("tab1", districtsUI("districtsUI")),
        tabPanel("tab2", tab2UI("tab2")),
        tabPanel("tab3_w", tab3w("tab3_w")),
        tabPanel(
            "Summary",
            textOutput("abc"),
            h3("asdfasdfasdf"),
        ),
    ),
    theme = bs_theme(bootswatch = "pulse")
)))
