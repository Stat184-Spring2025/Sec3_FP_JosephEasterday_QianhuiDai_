library(readxl)
library(dplyr)
library(ggplot2)
library(scales)

gdp_data <- read_excel("desktop/state_statistics.xlsx") %>%
  select(State = StateAbbr, GDP = GDP_In_Millions_2024)

walmart_data <- read_excel("desktop/walmart_store_distribution.xlsx") %>%
  select(State = state, total_stores)

combined_data <- inner_join(gdp_data, walmart_data, by = "State")

combined_data <- combined_data %>%
  mutate(GDP_per_store = GDP / total_stores)

combined_data <- combined_data %>%
  arrange(desc(GDP_per_store))

ggplot(combined_data, aes(x = reorder(State, -GDP_per_store))) +
  geom_bar(aes(y = GDP_per_store), stat = "identity", fill = "#1f77b4", width = 0.7) +
  geom_bar(aes(y = total_stores * max(GDP_per_store) / max(total_stores)), 
           stat = "identity", fill = "#ff7f0e", alpha = 0.7, width = 0.5) +
  scale_y_continuous(
    name = "GDP per Store (Millions USD)",
    sec.axis = sec_axis(~ . * max(combined_data$total_stores) / max(combined_data$GDP_per_store), 
                        name = "Number of Walmart Stores")
  ) +
  labs(title = "State GDP vs. Walmart Store Distribution",
       x = "State (Ordered by GDP per Store)",
       caption = "Blue bars: GDP per store (left axis)\nOrange bars: Number of stores (right axis)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 8),
        plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.title.y = element_text(color = "#1f77b4"),
        axis.title.y.right = element_text(color = "#ff7f0e"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank())



