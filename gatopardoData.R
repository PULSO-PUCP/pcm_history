
# code --------------------------------------------------------------------


rm(list = ls())
gatopardo=read.csv("sectores_all.csv")
# str(gatopardo)
gatopardo$cartera=ifelse(gatopardo$cartera=='salud',"Salud",gatopardo$cartera)
gatopardo$fecha_start <- as.Date(gatopardo$fecha_start)
gatopardo$fecha_end   <- as.Date(gatopardo$fecha_end)

gatopardo$duration <- as.numeric(
  gatopardo$fecha_end - gatopardo$fecha_start
)

gatopardo$event <- ifelse(
  is.na(gatopardo$fecha_end),
  0,
  1
)
library(dplyr)
library(lubridate)

gatopardo <- gatopardo |>
  mutate(
    year = year(fecha_start),
    
    epoch = case_when(
      year < 1883 ~ "1. State Formation",
      year < 1933 ~ "2. Oligarchic State",
      year < 1975 ~ "3. Power-Sharing State",
      year < 1993 ~ "4. Transition and Crisis",
      year < 2022 ~ "5. Democracy without Parties",
      TRUE        ~ "6. Current Critical Juncture"
    ))

myOrder=c("1. State Formation","2. Oligarchic State","3. Power-Sharing State","4. Transition and Crisis","5. Democracy without Parties","6. Current Critical Juncture")

gatopardo$epoch=factor(gatopardo$epoch,levels = myOrder, ordered = T)
gatopardo$cartera=relevel(factor(gatopardo$cartera), ref = "MEF")
str(gatopardo)
table(gatopardo$epoch)

table(gatopardo$cartera)
names(gatopardo)
gatopardo$political_framework=gatopardo$epoch
gatopardo$portfolio=gatopardo$cartera
gatopardo$President=gatopardo$Presidente
gatopardo$startDate=gatopardo$fecha_start
gatopardo$endDate=gatopardo$fecha_end
gatopardo$Name=gatopardo$Nombre
gatopardo$duration=gatopardo$duration+1

gatopardo$epoch=NULL
gatopardo$cartera=NULL
gatopardo$Presidente=NULL
gatopardo$fecha_start=NULL
gatopardo$fecha_end=NULL
gatopardo$Nombre=NULL
gatopardo$Partido=NULL
names(gatopardo)
##
gatopardo=gatopardo[,c("Name","startDate","endDate","duration","event","year","political_framework","portfolio","President")]
saveRDS(gatopardo,"gatopardo.RDS")
rm(list = ls())
