source("tab1.R")
source("tab2.R")

ui <- fluidPage(
navbarPage("Navbar!" ,
  tabPanel("Plot", tab1UI("tab1")
  ),
  tabPanel("tab2", tab2UI("tab2")
  ),
  tabPanel("Summary",
    verbatimTextOutput("summary"),
    textOutput("abc"),
    plotOutput("plot"),
    h3("asdfasdfasdf"),
  ),
)
)

