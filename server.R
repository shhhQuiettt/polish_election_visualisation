library(ggplot2)
source("districtsServer.R")

server <- function(input, output) {
    # output abc is text "asdfasdf"
    # output$abc <- renderText({
    #     "im abc"
    # })
    output$testText <- renderText({
        paste(
            "Boredom level ",
            input$testRange[1], " - ",
            input$testRange[2], "%"
        )
    })

    # import data from csv okregi.csv
    okregi <- read.csv("output.csv", sep = ",", encoding = "UTF-8")
    kandydaci <- read.csv("kandydaci_sejm_utf8.csv", sep = ";", encoding = "UTF-8")
    kandydaci[kandydaci$Nazwisko.i.imiona == okregi[2, 1], 7]

    output$image <- renderImage(
        {
            list(
                src = "image.jpg",
                contentType = "image/jpeg",
                alt = "This is alternate text"
            )
        },
        deleteFile = FALSE
    )
    output$table <- DT::renderDT(
        {
            okregi
        },
        selection = "single",
        options = list(list(
            scrollX = TRUE,
            scrollY = "250px"
        ))
    )


    # output$clicked_row <- renderPrint({
    #   cat("You clicked row", input$clicked_row, "\n")
    # })
    name <- "stefan"
    output$name <- renderText({
        okregi[input$table_rows_selected, 1]
    })
    output$job <- renderText({
        paste("job: ", kandydaci[kandydaci$Nazwisko.i.imiona == okregi[input$table_rows_selected, 1], 7])
    })
    output$sex <- renderText({
        paste("sex: ", kandydaci[kandydaci$Nazwisko.i.imiona == okregi[input$table_rows_selected, 1], 6])
    })
    output$place <- renderText({
        paste("domicile: ", kandydaci[kandydaci$Nazwisko.i.imiona == okregi[input$table_rows_selected, 1], 8])
    })
    output$votes <- renderText({
        paste("number of votes: ", kandydaci[kandydaci$Nazwisko.i.imiona == okregi[input$table_rows_selected, 1], 13])
    })
    output$club <- renderText({
        paste("club: ", okregi[input$table_rows_selected, 2])
    })
    output$number <- renderText({
        input$table_rows_selected
    })
    # upload image
    imageURL <- "image.jpg"
    # imageURL = "./obrazy/001.jpg"
    output$image <- renderImage(
        {
            list(
                src = paste("obrazy/", sprintf("%03d", input$table_rows_selected), ".jpg", sep = ""),
                contentType = "image/jpeg",
                alt = "This is alternate text"
            )
        },
        deleteFile = FALSE
    )
    observeEvent(
        input$table_rows_selected,
        function() {
            if (is.null(input$table_rows_selected)) {
                imageURL <- "image.jpg"
            } else {
                imageURL <- paste("obrazy/", sprintf("%03d", input$table_rows_selected), ".jpg", sep = "")
            }
        }
    )

    output$clicked_row <- renderPrint({
        if (is.null(input$table_rows_selected)) {
            return()
        }
        okregi[input$table_rows_selected, 1]
    })

    output$clicked_d <- renderPrint({
        if (is.null(input$clicked_district)) {
            return()
        }
        input$clicked_district
    })

    # get data from selected row
    # output$selected_row <- renderPrint({
    #   if (is.null(input$table_rows_selected)) return()
    #   okregi[input$table_rows_selected,]
    # })

    # output$plot <- renderPlot({
    #     ggplot(data.frame(x = 1:100, y = (1:100)^2), aes(x = x, y = y)) +
    #         geom_point()
    # })

    ##### DISTRICTS TAB

    library(tidyr)
    library(dplyr)
    library(stringr)
    library(tibble)


    districts <- tibble(district.no = integer(), person = character(), party = character(), votes = integer())
    for (district_no in 1:41) {
        temp_district <- read.csv(sprintf("./wyniki_okregi/okreg_%s_utf8.csv", district_no), sep = ";")
        districts <- districts %>% union(
            temp_district %>%
                select(-"Liczba.komisji", -"Liczba.uwzględnionych.komisji") %>%
                gather(key = "person_party", value = "votes", 2:(length(temp_district) - 2)) %>%
                mutate(person = person_party %>% str_extract("^.*\\.\\.\\.") %>% str_replace("\\.\\.\\.", "")) %>%
                mutate(party = person_party %>% str_extract("\\.\\.\\..*$") %>% str_replace("\\.\\.\\.", "")) %>%
                select(district.no = Nr.okręgu, person, party, votes)
        )
    }

    output$district_outcome <- renderPlot({
        if (is.na(input$clicked_district)) {
            return()
        }
        ggplot(
            districts %>% filter(
                district.no == input$clicked_district
            ) %>% group_by(party) %>% summarize( total_votes = sum(votes) )
        ) + geom_bar(stat="identity", aes(
                x = party, y = total_votes
        ))
    })

    # district <- district %>% select(-"Liczba.uwzględnionych.komisji", -"Liczba.komisji")
    # district %>% gather(key="person_party", value="votes" ,2:length(district) ) %>%
    #   mutate(person = person_party %>% str_extract("^.*\\.\\.\\.") %>% str_replace("\\.\\.\\.","")  %>%
    #   mutate(person = person_party %>% str_extract("\\.\\.\\..*$") %>% str_replace("\\.\\.\\.",""))
}
