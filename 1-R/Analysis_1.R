#                           Maestria en ciencia de los Datos
#                               Proyecto Integrador
#                              Coeficiente de fidelización al medio de pago tarjeta crédito
#directorio de trabajo

setwd("~/GitHub/Proyecto_Maestria/2-Data")

#importar data
library(readr)
library(dplyr)

data_full<- read_delim("Base_modelo.csv",
                         ";", escape_double = FALSE, trim_ws = TRUE)
