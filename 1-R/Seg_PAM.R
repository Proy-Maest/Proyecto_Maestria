require(caret)

#Base Inicial
BASE <- read.csv(file.choose(),header = T, sep = ";")

#Extraemos el ID
BASE_ID <- BASE[1]

#Base solo con variables

BASE <- BASE[,-1]

BASE$Estrato <- as.factor(BASE$Estrato)
BASE$Edad <- as.factor(BASE$Edad)

summary(BASE)


BASE_num <- BASE[sapply(BASE, is.numeric)]
BASE_cat <- BASE[sapply(BASE, is.factor)]


for(i in 1:ncol(BASE_num)){
  BASE_num[,i] = ((BASE_num[,i])-min(BASE_num[,i])/(max(BASE_num[,i]))-(min(BASE_num[,i])))
}

comboinfo <- findLinearCombos(BASE_num)
comboinfo

View(BASE)
N_BASE_num <- BASE_num[, -comboinfo$remove]
comboinfo <- findLinearCombos(N_BASE_num)

library(dplyr)
require(dplyr)
library(ggplot2)
library(GGally)
require(GGally)
library(Hmisc)
require(Hmisc)
library(corrplot)
require(corrplot)
library(PerformanceAnalytics)
require(PerformanceAnalytics)


BASE <- cbind(N_BASE_num,BASE_cat)

correlacion <- round(cor(N_BASE_num),1)

corrplot(correlacion, method = "number", type = "upper")
corrplot(correlacion,type="upper",order="hclust",t.col="black",tl.srt = 45)

###Estandarización de variables#####

require(cluster)
library(dplyr)
library(Rtsne)

dist_grid<- daisy(BASE,metric = "gower")
d_matrix <- as.matrix(dist_grid)

sil_width <- c(NA)

for(i in 2:15){
  pam_fit <- pam(dist_grid,
                 diss = TRUE,
                 k = i)
  sil_width[i] <- pam_fit$silinfo$avg.width
}

plot(1:15, sil_width,
     xlab = "Número de cluster",
     ylab = "Silueta")
lines(1:15,sil_width)

## Se selccionan 4 grupos

clusters_d <- hclust(dist_grid,method = "ward.D2")
cluster <- cutree(clusters_d, k=2)

BASE_cluster <- cbind(BASE, cluster)

pam_results <- BASE_cluster%>%
  dplyr::select(-cluster)%>%
  mutate(cluster=pam_fit$clustering)%>%
  group_by(cluster)%>%
  do(the_summary = summary(.))


pam_results$the_summary

### Algoritmo para medir rendimiento

tsne_obj <- Rtsne(dist_grid,is_distance=TRUE)


tsne_data <- tsne_obj$Y%>%
  data.frame()%>%
  setNames(c("X","Y"))


BASE_cluster_full <- cbind(BASE_cluster,tsne_data)

library(ggplot2)

g1 <- ggplot(aes(x=X,y=Y),data=BASE_cluster_full)
g1+geom_point(aes(color=factor(cluster)))+
  ggtitle("")


  summary(BASE_cluster$`pam_fit$clustering`)
  