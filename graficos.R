library(tidyverse)
eventos <- read_csv("grooming-ev.csv")

############ BOXPLOT GENERAL
eventos %>% ggplot(aes(x=Especie,y=IR))+
    geom_boxplot() +
    coord_flip()

############ BOXPLOT POR DIADA
eventos %>% ggplot(aes(x=Especie,y=IR,color=Diada))+
    geom_boxplot() +
    coord_flip()