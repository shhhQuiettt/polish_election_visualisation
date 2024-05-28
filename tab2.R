tab2UI <- function(id) {
  ns <- NS(id)
  splitLayout(
    sidebarPanel(
      titlePanel("Personal Information"),
      imageOutput("image"),
      h2(textOutput("name")),
      textOutput("sex"),
      textOutput("job"),
      textOutput("place"),
      textOutput("votes"),
      textOutput("club"),
      textOutput("number"),
      ),
    mainPanel(textOutput("testText"),
              verbatimTextOutput("clicked_row"),
                DT::DTOutput("table"),
              
    ))
}

