library(ggplot2)
library(shinydashboard)
library(shiny)
# source("districtsServer.R")
library(ggimage)
source("party_palette.R")


server <- function(input, output) {
    # output abc is text "asdfasdf"
    # output$abc <- renderText({
    #     "im abc"
    # })
  print(sprintf("%03d", NULL))
    output$testText <- renderText({
        paste(
            "Boredom level ",
            input$testRange[1], " - ",
            input$testRange[2], "%"
        )
    })

    # import data from csv okregi.csv
    okregi <- read.csv("output.csv", sep = ",", encoding = "UTF-8")[,1:2]
    kandydaci <- read.csv("kandydaci_sejm_utf8.csv", sep = ";", encoding = "UTF-8")
    kandydaci[kandydaci$Nazwisko.i.imiona == okregi[2, 1], 7]

    
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
    

    output$image <- renderImage(
        {
            list(
                src = paste("images/", sprintf("%03d", input$table_rows_selected), ".jpg", sep = ""),
                contentType = "image/jpeg",
                alt = "This is alternate text"
            )
        },
        deleteFile = FALSE
    )
  

    output$clicked_row <- renderPrint({
      sprintf("%03d", input$table_rows_selected)
      
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
        ggplot(
            districts %>%
                filter(
                    district.no == ifelse(is.null(input$clicked_district), 4, input$clicked_district)
                ) %>%
                group_by(party) %>%
                summarize(total_votes = sum(votes)) %>%
                left_join(logo_mapping, by = "party"),
            aes(
                x = reorder(party, total_votes, decreasing = TRUE), y = total_votes, fill = factor(party)
            )
        ) +
            geom_bar(stat = "identity") +
            geom_image(aes(image = logo), size = 0.05, by = "width") +
            ylab("Votes") +
            xlab(NULL) +
            scale_fill_manual(values = party_colors, guide = "none") +
            theme_minimal() +
            theme(axis.text.x = element_blank())
    })
    
   
    
    # add title to the legend of the plot
    
    
    output$mandate_plot <- renderPlot({
      ggplot(
        kandydaci %>%
          filter(Nr.okręgu == ifelse(is.null(input$clicked_district), 4, input$clicked_district), Czy.przyznano.mandat == 'Tak') %>%
          mutate(club = case_when(
            Nr.listy == 4 ~ "PIS",
            Nr.listy == 6 ~ "KO",
            Nr.listy == 2 ~ "Trzecia Droga",
            Nr.listy == 3 ~ "Lewica",
            Nr.listy == 5 ~ "Konfederacja"
          )) %>%
          select(club, Czy.przyznano.mandat) %>%
          group_by(club) %>%
          count(),
        aes(x = "", y = n, fill = factor(club))) +
        geom_bar(stat = "identity",width = 1, color="white") +
        coord_polar("y",start=0)+
        theme_void() +
        labs(fill = "club") +
        geom_text(aes(label = n), position = position_stack(vjust = 0.5)) +
        coord_polar(theta = "y")+
        ggtitle("Mandates")
    })
    
    valueData <- reactiveValues(
      value = 50,
      color = "blue"
    )
    output$box <- renderValueBox({
      valueBox(
        value = okregi[input$table_rows_selected, 2],
        subtitle = "club",
        color = valueData$color
      )
    })
    observeEvent(input$table_rows_selected, {
      t = c("aqua", "red","green",  "maroon","purple")
      club = c("PIS", "KO", "Trzecia Droga", "Lewica", "Konfederacja")
      # get index of club
      index = which(club == okregi[input$table_rows_selected, 2])
      
      valueData$value <- sample(1:100, 1)  # Update value with a random number
      valueData$color <- t[index]
      
    })
    
    # output$box <- renderValueBox({
    #   valueBox(
    #     paste0(okregi[input$table_rows_selected, 2]),  icon = icon("list"),
    #     color = "purple"
    #   )
    # })

    # district <- district %>% select(-"Liczba.uwzględnionych.komisji", -"Liczba.komisji")
    # district %>% gather(key="person_party", value="votes" ,2:length(district) ) %>%
    #   mutate(person = person_party %>% str_extract("^.*\\.\\.\\.") %>% str_replace("\\.\\.\\.","")  %>%
    #   mutate(person = person_party %>% str_extract("\\.\\.\\..*$") %>% str_replace("\\.\\.\\.",""))
}
