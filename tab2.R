tab2UI <- function(id) {
  ns <- NS(id)
  fluidRow(
    column(width = 6,
           fluidRow(
             column(width = 12, style = "height: 75%;",
                    div(style = "margin: 20px;",
                        titlePanel("Personal Information"),
                        imageOutput("image", width = "50%", height = "50%"),
                        h2(textOutput("name")),
                        textOutput("sex"),
                        textOutput("job"),
                        textOutput("place"),
                        textOutput("votes"),
                        textOutput("club"),
                        textOutput("number")
                    )
             ),
             column(width = 12, style = "height: 25%;",
                valueBoxOutput("box", width = 12)
             )
           ),
           ),
    column(width = 6,
           DT::DTOutput("table"),
  )
  )

}


