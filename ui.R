source("districtsUI.R")
source("tab2.R")
source("tab3_w.R")

library(shinydashboard)
library(bslib)

ui <- fluidPage(
    navbarPage(
      img(src = "herb.png", height = "55px", width = "50px"),
        tabPanel("ELECTION RESULTS", districtsUI("districtsUI")),
        tabPanel("ELECTED SENATORS", tab2UI("tab2")),
        tabPanel("MANDATES DISTRIBUTION", tab3w("tab3_w")),
        
    ),
    theme = bs_theme(bootswatch = "pulse")
)
