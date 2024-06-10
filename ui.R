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
        tabPanel("ABOUT",
               h1("Election Results and Mandates Distribution"),
               p("This app is designed to visualize the results of the 2023 Polish Parliament election and to show the distribution of mandates."),
               p("The data comes from the official Government website: ", a("sejmsenat2023.pkw.gov.pl/sejmsenat2023/pl/dane_w_arkuszach", href = "https://sejmsenat2023.pkw.gov.pl/sejmsenat2023/pl/dane_w_arkuszach")),
      ),
        
    ),
    theme = bs_theme(bootswatch = "pulse")
)
