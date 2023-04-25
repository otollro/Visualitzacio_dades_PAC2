# Dades sobre el preu de l'energia mensual des del 2010 fins al 2018

library(tidyverse)
library(stringr)
library(readr)

# Lectura de les dades
# https://data.world/city-of-bloomington/feca8aa2-d266-454a-b4e2-508581c99994
setwd("C:/Mis documentos/Estudis/Màster UOC/Semestre 4/Visualització de dades/PAC 2")
dd <- read.csv2("intake-monthly-electricity-bills.csv",sep=",",header=T)
colnames(dd) <- c("Date", "Total_Energy", "Peak_Demand", "Total_Pumped", "Cost")
dd$Cost <- parse_number(dd$Cost)
dd$Any <- str_split_fixed(dd$Date, "/",3)[,1]

# Find the convex hull of the points being plotted
hull <- dd %>%
  slice(chull(Total_Energy, Cost))

# Define the scatterplot
p <- ggplot(dd, aes(Total_Energy, Cost)) + geom_point(shape = 21, colour = "#D69628") +
  scale_size_continuous(range = c(1,4)) +
  theme_minimal() +
  theme(axis.line = element_line(colour = "black"), axis.text.y = element_text(hjust = 1)) +
  labs(y = "Cost ($)", x = "Total Energy (Kwh)")

# Overlay the convex hull
p + geom_polygon(data = hull, alpha = 0.4, colour = "#D69628", fill = "#D69628")
