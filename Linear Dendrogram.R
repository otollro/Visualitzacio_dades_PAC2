# Dades sobre el risc d'extinció de les diferents races de felins

library(ggraph)
library(igraph)
library(tidyverse)
library(RColorBrewer) 

# Lectura de les dades
# https://app.rawgraphs.io/
setwd("C:/Mis documentos/Estudis/Màster UOC/Semestre 4/Visualització de dades/PAC 2")
dd <- read.csv2("Felidae_classification.csv",sep=";",header=T)

d1 <- unique(dd[,c(1,2)])
colnames(d1) <- c("from", "to")
d2 <- unique(dd[,c(2,3)])
colnames(d2) <- c("from", "to")
edges <- rbind(d1, d2)

name <- unique(c(as.character(edges$from), as.character(edges$to)))
value1 <- aggregate(dd$Risk.of.Extinction, by=list(dd$Family), FUN=mean)
value2 <- aggregate(dd$Risk.of.Extinction, by=list(dd$Family, dd$Subfamily), FUN=mean)
value3 <- aggregate(dd$Risk.of.Extinction, by=list(dd$Family, dd$Subfamily, dd$Genus), FUN=mean)

# We can add a second data frame with information for each node!
vertices <- data.frame(
  name=name,
  group=c( rep(NA,4), d2$from),
  cluster=sample(letters[1:4], length(name), replace=T),
  value=c(value1$x, value2$x, value3$x)
)

# Create a graph object
mygraph <- graph_from_data_frame(edges, vertices=vertices)
colores <- vertices$group
colores[1:4] <- c(unique(colores))
colores[1] <- "Original"

options(repr.plot.width = 5, repr.plot.height =2)

ggraph(mygraph, layout = 'dendrogram') + 
  geom_edge_diagonal(colour="grey") +
  geom_node_text(aes(label=name, color=colores), 
                 hjust=c(1,0.5, 0.5, 0.5, rep(0,13)), 
                 nudge_y = c(-.04, 0, 0, 0, rep(.04,13)),
                 nudge_x = c(0, .5, .4, .5, rep(0,13))) +
  geom_node_point(aes(size=value, color=colores) , alpha=0.6) +
  theme(legend.position="none") + 
  scale_y_reverse() +
  coord_flip(ylim=c(2.2,-0.3))
