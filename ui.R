source("tab1.R")

ui <- fluidPage(
navbarPage("Navbar!" ,
  tabPanel("Plot", tab1UI("tab1")
  ),
  tabPanel("Summary",
    verbatimTextOutput("summary"),
    textOutput("abc"),
    plotOutput("plot"),
    h3("asdfasdfasdf"),
  ),
)
)

