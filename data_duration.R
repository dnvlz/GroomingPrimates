library(tidyverse)
duracion <- read_csv("grooming-dur.csv")

duracion <- duracion %>% 
    select(Especie,Diada,IR) %>%
    filter(!is.na(Diada)) %>%
    mutate(Diada=ifelse(Diada=="f-m","m-f",Diada),IR=as.numeric(IR))

sps <- unique(duracion$Especie)
sps <- sps[!is.na(sps)]


########### DATOS POR DIADA
data <- tribble(~Sp,~Diada,~Media,~Varianza)
for (sp in sps){
    data_sp <- duracion %>%
        filter(Especie==sp) %>%
        group_by(Diada) %>%
        summarize(diada=first(Diada),media=mean(IR,na.rm=TRUE),varianza=sd(IR,na.rm=TRUE))
    data <- data %>% add_row(Sp=sp,Diada=data_sp$diada,Media=data_sp$media,Varianza=data_sp$varianza)
}

########### DATOS GENERALES
data_gr <- tribble(~Sp,~Media,~Varianza)
for (sp in sps){
    data_sp <- duracion %>%
        filter(Especie==sp) %>%
        summarize(media=mean(IR,na.rm=TRUE),varianza=sd(IR,na.rm=TRUE))
    data_gr <- data_gr %>% add_row(Sp=sp,Media=data_sp$media,Varianza=data_sp$varianza)
}

write_csv(data,"ir_duration_dyad.csv")
write_csv(data_gr,"ir_duration.csv")