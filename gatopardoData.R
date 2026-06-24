
# code --------------------------------------------------------------------


rm(list = ls())
gatopardo=read.csv("sectores_all.csv")
# str(gatopardo)
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
      year < 1883 ~ "State_Formation_before1883",
      year < 1933 ~ "Oligarchic_State_before1933",
      year < 1975 ~ "PowerSharing_State_before1975",
      year < 1993 ~ "Transition_and_Crisis_before1993",
      year < 2022 ~ "Democracy_WithoutParties_upto2021",
      TRUE        ~ "Current_CriticalJuncture"
    )
  )
saveRDS(gatopardo,"gatopardo.RDS")
rm(list = ls())