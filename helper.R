source("party_palette.R")

library(dplyr)
library(ggplot2)
library(ggimage)
library(forcats)
library(tidyr)
library(tibble)
library(stringr)

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



ggplot(
    districts %>%
        filter(
            district.no == 4
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
    theme(axis.text.x=element_blank())

districts$party %>%
    as.data.frame() %>%
    distinct()
