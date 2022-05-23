library(tidyverse)
duracion <- read_csv("grooming-dur.csv")

duracion <- duracion %>% 
    select(Especie,Diada,IR) %>%
    filter(!is.na(Diada)) %>%
    mutate(Diada=ifelse(Diada=="f-m","m-f",Diada),IR=as.numeric(IR))

############ BOXPLOT GENERAL
duracion %>% ggplot(aes(x=Especie,y=IR))+
    geom_boxplot() +
    coord_flip()

ggsave("ir_duration.png")

############ BOXPLOT POR DIADA
duracion %>% ggplot(aes(x=Especie,y=IR,color=Diada))+
    geom_boxplot() +
    coord_flip()

ggsave("ir_duration_dyad.png")
