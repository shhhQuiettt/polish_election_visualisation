library(htmltools)

read_svg <- function(file) {
    readLines(file, warn = FALSE)
}
districtsUI <- function(id) {
    splitLayout(
        sidebarPanel(
            h2("Sidebar"),
            verbatimTextOutput("clicked_d"),
            verbatimTextOutput("dummy"),
        ),
        mainPanel(
            h3("plot"),
            div(
                HTML(read_svg("districts.svg"))
            ),
            plotOutput("district_outcome"),
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
}
