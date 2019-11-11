#                           Maestria en ciencia de los Datos
#                               Proyecto Integrador
#                              Coeficiente de fidelización al medio de pago tarjeta crédito
#directorio de trabajo

setwd("D:/Usuarios/danirorm/Seguros Suramericana, S.A/PROYECTO_MAESTRIA_EAFIT - General/3-Data")

#importar data
library(readr)
library(dplyr)

options("scipen"=100, "digits"=4)
data_full<- read_delim("Base_modelo.csv",
                         ";", escape_double = FALSE, trim_ws = TRUE)

#Estructura de la base

str(data_full)
dim(data_full)
glimpse(data_full)
#Nombres de las columnas
names(data_full)

#Resumen de la base
summary(data_full)

# Al ver el resumen de la base , se evidencia observaciones que estan fuera de la población para
#analizar

#Rango de ingresos acumulados al año entre 450 mil y 90 millones

data1<-data_full %>% filter(Rango_ingresos_acum %in% (450000:90000000))

#numero de hijos existe un elemento extraño =? reemplazo por cero

data1$Hijos<- gsub("[?]",'0', data1$Hijos)

#El monto transado debe ser mayor que cero

data2<-data1 %>% filter(Monto_transado != 0 )

library(plotly)
# Ahora vamos a analizar como se  distribuye la poblacion
plot_ly(data2, x = ~Edad, type = "histogram")%>% config(displayModeBar = F)


#la poblacion estudio esta entre 25 y 60 años
data3<-data2 %>% filter(Edad %in% (25:60))
#histograma
plot_ly(data3, x = ~Edad, type = "histogram")%>% config(displayModeBar = F)
#boxplot
plot_ly(data3, y = ~Edad, type = "box")

 #estructura de la nueva base
glimpse(data3)

#Análisis de Tablas de Frecuencias de Variables Categóricas y sus Porcentajes con respecto al total de registros
#Distribucion por genero
table(data3$Sexo)
# se evidencia en la poblacion que el 50.5% son Mujeres y el 49.5% son Hombres
sort(prop.table(table(data3$Sexo))*100, decreasing = T)


#Distribución por Nivel estudio
table(data3$Nivel_estudio)
sort(prop.table(table(data3$Nivel_estudio))*100, decreasing = T)
plot_ly(data3, x = ~Nivel_estudio, type = "histogram")%>% config(displayModeBar = F)

#Estado civil
table(data3$Estado_civil)
sort(prop.table(table(data3$Estado_civil))*100, decreasing = T)

#Departamento
table(data3$Departamento)
sort(prop.table(table(data3$Departamento))*100, decreasing = T)

#Franquicias
table(data3$Franquicia)
sort(prop.table(table(data3$Franquicia))*100, decreasing = T)
plot_ly(data3, x = ~Franquicia, type = "histogram")%>% config(displayModeBar = F)

#Canal
table(data3$canal)
sort(prop.table(table(data3$canal))*100, decreasing = T)


#Origen
table(data3$origen)
sort(prop.table(table(data3$origen))*100, decreasing = T)

#Estrato
#Canal
table(data3$Estrato)
sort(prop.table(table(data3$Estrato))*100, decreasing = T)
plot_ly(data3, x = ~Estrato, type = "histogram")%>% config(displayModeBar = F)

#Reclamos
table(data3$Reclamos)
sort(prop.table(table(data3$Reclamos))*100, decreasing = T)
plot_ly(data3, x = ~Reclamos, type = "histogram")%>% config(displayModeBar = F)
#hijos
plot_ly(data3, y = ~Hijos, type = "box", name = "Num Hijos")
plot_ly(data3, x = ~Hijos, type = "histogram")%>% config(displayModeBar = F)

#Distribucion del total de trx acum
plot_ly(data3, x = ~Total_trx, type = "histogram")%>% config(displayModeBar = F)

#Correlación entre las varaibles cuantitativas

cor(select(data3, "Edad", "Rango_ingresos_acum", "Monto_transado", "Total_trx"))
library(PerformanceAnalytics)
chart.Correlation(select(data3, "Edad", "Rango_ingresos_acum", "Monto_transado", "Total_trx"),histogram = TRUE, pch=19)

summary(data3)

##MOdelamiento

#Las personas deben tener como minimo una trx acumulada en el año

data4<-data3 %>% filter(Total_trx>0)

write.csv(data4, file = "Data_clean.csv")

## Clusterizacion

library(cluster)
library(factoextra)
library(tidyverse)
library(ggpubr)
#selección de las variables para la clusterización

data_mod1<-data4 %>% select("Rango_ingresos_acum", "Monto_transado", "Total_trx")

#Se agrupa por Rango de ingresos

data_mod2<-data_mod1 %>% select("Rango_ingresos_acum", "Monto_transado", "Total_trx") %>%
  group_by(Rango_ingresos_acum) %>%
  summarise_all(funs(sum))

#Selección del k optimo = 3
fviz_nbclust(data_mod2, kmeans, method = "gap_stat")
#Modelo K means

#modelo kmeans
ModeloKMEANS <- kmeans(data_mod2,3)


### Grafica del modelo
#my_data2<-select(my_data1, -Macrosector_sura_desc,-Grupo_cluster)
km.res <- kmeans(data_mod2, 3)

fviz_cluster(km.res, data = data_mod2, frame.type = "convex")
cluster<-km.res$cluster
#creamos la columna donde se le asigna el grupo donde queda
data_mod2$Grupo_cluster <- ModeloKMEANS$cluster

table(data_mod2$Grupo_cluster)
sort(prop.table(table(data_mod2$Grupo_cluster))*100, decreasing = T)

#Agrupación por cluster


Clusters_1<-data_mod2 %>% select("Grupo_cluster","Rango_ingresos_acum", "Monto_transado", "Total_trx") %>%
  group_by(Grupo_cluster) %>%
  summarise_all(funs(sum))

#Descargamos el archivo
#write.csv(data_mod2, file = "data_cluster.csv")


