library(tidyverse)
eventos <- read_csv("grooming-ev.csv")

sps <- unique(eventos$Especie)
sps <- sps[!is.na(sps)]

########### DATOS POR DIADA
data <- tribble(~Sp,~Diada,~Media,~Varianza)
for (sp in sps){
     data_sp <- eventos %>%
         filter(Especie==sp) %>%
         group_by(Diada) %>%
         summarize(diada=first(Diada),media=mean(IR,na.rm=TRUE),varianza=sd(IR,na.rm=TRUE))
     data <- data %>% add_row(Sp=sp,Diada=data_sp$diada,Media=data_sp$media,Varianza=data_sp$varianza)
}

########### DATOS GENERALES
data_gr <- tribble(~Sp,~Media,~Varianza)
for (sp in sps){
    data_sp <- eventos %>%
        filter(Especie==sp) %>%
        summarize(media=mean(IR,na.rm=TRUE),varianza=sd(IR,na.rm=TRUE))
    data_gr <- data_gr %>% add_row(Sp=sp,Media=data_sp$media,Varianza=data_sp$varianza)
}

write_csv(data,"datos_por_diada.csv")
write_csv(data_gr,"datos_general.csv")