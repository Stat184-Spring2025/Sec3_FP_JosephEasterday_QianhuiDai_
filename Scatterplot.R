library(readxl)
library(dplyr)
library(ggplot2)
library(scales)

walmart <- read_excel("~/Downloads/walmart_store_distribution.xlsx")
state_stats <- read_excel("~/Downloads/state_statistics.xlsx")

merged_data <- inner_join(walmart, state_stats, by = c("state" = "StateAbbr")) %>%
  select(GeoName, state, total_stores, GDP_In_Millions_2024)

Walplot <- ggplot(merged_data, aes(x = total_stores, y = GDP_In_Millions_2024, label = state)) +
  geom_point(color = "blue", size = 3) +
  geom_label(vjust = -0.5, size = 3, fill = "white", label.size = 0.2) +
  labs(title = "State GDP vs. Walmart Store Distribution",
       subtitle = "(* Denotes every value eligible is millions of millions of dollars)",
       x = "Total Stores in One State",
       y = "GDP per Store* (Millions USD)") +
  scale_y_continuous(limits = c(40000, 4200000), labels = comma) +
  theme_minimal()

print(Walplot)


