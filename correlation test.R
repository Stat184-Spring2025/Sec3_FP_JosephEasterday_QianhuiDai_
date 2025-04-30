library(readxl)
library(dplyr)

gdp_data <- read_excel("desktop/state_statistics.xlsx") %>%
  select(state = StateAbbr, gdp = GDP_In_Millions_2024)

store_data <- read_excel("desktop/walmart_store_distribution.xlsx") %>%
  select(state, stores = total_stores)

combined_data <- inner_join(gdp_data, store_data, by = "state") %>%
  filter(!state %in% c("PR", "DC")) 

pearson_test <- cor.test(combined_data$gdp, combined_data$stores, 
                         method = "pearson")

spearman_test <- cor.test(combined_data$gdp, combined_data$stores,
                          method = "spearman")

cor_matrix <- cor(combined_data[, c("gdp", "stores")])

results <- list(
  pearson = list(
    estimate = pearson_test$estimate,
    p_value = pearson_test$p.value,
    conf_int = pearson_test$conf.int
  ),
  spearman = list(
    estimate = spearman_test$estimate,
    p_value = spearman_test$p.value
  ),
  correlation_matrix = cor_matrix
)

results