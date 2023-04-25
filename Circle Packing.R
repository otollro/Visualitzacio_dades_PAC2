# Dades sobre les ciutats més poblades del món per continent

library(ggraph)
library(devtools)
library(data.tree)
library(circlepackeR)

# Lectura de les dades
# https://app.rawgraphs.io/

setwd("C:/Mis documentos/Estudis/Màster UOC/Semestre 4/Visualització de dades/PAC 2")
dd <- read.csv2("population.csv",sep=";",header=T)

# CRICLE PACKING
dd$pathString <- paste("World", dd$Continent, dd$Country, dd$City, sep = "/")
population <- as.Node(dd)

# Make the plot
#circlepackeR(population, size = "value")

# You can custom the minimum and maximum value of the color range.
p <- circlepackeR(population, size = "Population")
p

