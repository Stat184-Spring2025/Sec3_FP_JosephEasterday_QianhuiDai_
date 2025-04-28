library(dplyr)
library(readxl)
library(writexl)

raw_data <- read_excel("~/Downloads/Gross_Domestic_Product.xlsx", skip = 5)

cleaned_data <- raw_data %>%
  select(GeoFips, GeoName, `2024`) %>%
  filter(!GeoName %in% c("District of Columbia", "United States"))

state_abbr_df <- tibble(
  GeoName = c(
    "Alabama", "Alaska", "Arizona", "Arkansas", 
    "California", "Colorado", "Connecticut", "Delaware", 
    "Florida", "Georgia", "Hawaii", "Idaho", 
    "Illinois", "Indiana", "Iowa", "Kansas", 
    "Kentucky", "Louisiana", "Maine", "Maryland", 
    "Massachusetts", "Michigan", "Minnesota", "Mississippi", 
    "Missouri", "Montana", "Nebraska", "Nevada", 
    "New Hampshire", "New Jersey", "New Mexico", "New York", 
    "North Carolina", "North Dakota", "Ohio", "Oklahoma", 
    "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", 
    "South Dakota", "Tennessee", "Texas", "Utah", 
    "Vermont", "Virginia", "Washington", "West Virginia", 
    "Wisconsin", "Wyoming"
  ),
  StateAbbr = c(
    "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE",
    "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS",
    "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS",
    "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY",
    "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
    "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV",
    "WI", "WY"
  )
)

tidy_data <- cleaned_data %>%
  left_join(state_abbr_df, by = "GeoName") %>%
  group_by(GeoName, StateAbbr) %>%
  summarise(
    GDP_In_Millions_2024 = sum(`2024`, na.rm = TRUE),
    .groups = 'drop'
  )

print(tidy_data)

write_xlsx(tidy_data, "~/Downloads/state_statistics.xlsx")




