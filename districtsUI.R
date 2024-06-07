library(htmltools)

read_svg <- function(file) {
    readLines(file, warn = FALSE)
}
districtsUI <- function(id) {
    fluidPage(
        fluidRow(
            column(
                5,
                verbatimTextOutput("clicked_d"),
                verbatimTextOutput("dummy"),
                plotOutput("district_outcome"),
            ),
            column(
                   7,
                h3("plot"),
                div(
                    HTML(read_svg("www/districts.svg")),
                ),
                tags$script(HTML('
                document.querySelectorAll("path").forEach(function (element) {
                  if (element.parentElement.id.startsWith("text")) {
                    return;
                  }

                  element.addEventListener("click", function () {
                    document.querySelectorAll("path").forEach(function (element) {
                      if (element.parentElement.id.startsWith("text")) {
                        return;
                      }
                      element.style.fill = "#fff6d5"
                    })
                    Shiny.onInputChange("clicked_district", element.id);
                    element.style.fill = "red";
                  })
                })
     ')),
            )
        )
    )
}
