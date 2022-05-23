library(tidyverse)
eventos <- read_csv("grooming-ev.csv")

eventos <- eventos %>%
    mutate(Diada=ifelse(Diada=="mf","m-f",Diada))

############ BOXPLOT GENERAL
eventos %>% ggplot(aes(x=Especie,y=IR))+
    geom_boxplot() +
    coord_flip()

ggsave("ir_events.png")

############ BOXPLOT POR DIADA
eventos %>% ggplot(aes(x=Especie,y=IR,color=Diada))+
    geom_boxplot() +
    coord_flip()

ggsave("ir_events_dyad.png")
