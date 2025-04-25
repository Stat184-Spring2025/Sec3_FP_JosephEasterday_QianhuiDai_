library(tidyverse)
library(writexl)

store_data <- read_csv("~/Desktop/STORE_STATUS_PUBLIC_VIEW.csv")

store_data <- store_data %>%
  rename_with(~ str_replace_all(., " ", "_")) %>%
  rename_with(tolower)

store_data <- store_data %>%
  distinct() %>%
  drop_na(state)

store_data_open <- store_data %>%
  filter(operation_status == "Open")

store_distribution <- store_data_open %>%
  group_by(state) %>%
  summarise(total_stores = n()) %>%
  arrange(desc(total_stores))

View(store_distribution)

write_xlsx(store_distribution, "~/Desktop/walmart_store_distribution.xlsx")

