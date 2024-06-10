library(htmltools)

read_svg <- function(file) {
    readLines(file, warn = FALSE)
}
districtsUI <- function(id) {
    fluidPage(
        fluidRow(
            column(
                6,
                plotOutput("district_outcome", height = "60%"),
            ),
            column(
                   6,
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
