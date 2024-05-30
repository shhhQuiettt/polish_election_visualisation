library(dplyr)
library(tidyr)
library(tibble)

districts <- tibble(Nr.okręgu = integer(), person = character(), party = character(), votes = integer())
for (district_no in 1:41) {
    temp_district <- read.csv(sprintf("./wyniki_okregi/okreg_%s_utf8.csv", district_no), sep = ";")
    districts <- districts %>% union(
        temp_district %>%
            select(-"Liczba.komisji", -"Liczba.uwzględnionych.komisji") %>%
            gather(key = "person_party", value = "votes", 2:(length(temp_district) - 2)) %>%
            mutate(person = person_party %>% str_extract("^.*\\.\\.\\.") %>% str_replace("\\.\\.\\.", "")) %>%
            mutate(party = person_party %>% str_extract("\\.\\.\\..*$") %>% str_replace("\\.\\.\\.", "")) %>%
            select("Nr.okręgu", "person", "party", votes)
    )
}

districts %>%
    select(party) %>%
    distinct()

order

temp_district <- read.csv("./wyniki_okregi/okreg_1_utf8.csv", district_no, sep = ";")
temp_district %>%
    select(-"Liczba.komisji", -"Liczba.uwzględnionych.komisji") %>%
    gather(key = "person_party", value = "votes", 2:(length(temp_district) - 2)) %>%
    mutate(person = person_party %>% str_extract("^.*\\.\\.\\.") %>% str_replace("\\.\\.\\.", "")) %>%
    mutate(party = person_party %>% str_extract("\\.\\.\\..*$") %>% str_replace("\\.\\.\\.", "")) %>%
    select("Nr.okręgu", "person", "party") %>%
    head()
