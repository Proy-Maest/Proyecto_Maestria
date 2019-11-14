#setwd("D:/Usuarios/danirorm/Seguros Suramericana, S.A/PROYECTO_MAESTRIA_EAFIT - General/3-Data")

setwd("D:/Usuarios/danirorm/Seguros Suramericana, S.A/PROYECTO_MAESTRIA_EAFIT - General/1-R")



install.packages('dplyr', dependencies=T)

library(readr)


#Base Inicial
BASE <-read_delim("D:/Usuarios/danirorm/Seguros Suramericana, S.A/PROYECTO_MAESTRIA_EAFIT - General/1-R/Base_modelo.csv",

                                   ";", escape_double = FALSE, trim_ws = TRUE)
summary(BASE)
#Extraemos el ID
BASE_ID <- BASE[1]

#Base solo con variables

BASE <- BASE[,-1]

BASE$Estrato <- as.factor(BASE$Estrato)
BASE$Edad <- as.factor(BASE$Edad)




BASE_num <- BASE[sapply(BASE, is.numeric)]
BASE_cat <- BASE[sapply(BASE, is.factor)]


for(i in 1:ncol(BASE_num)){
  BASE_num[,i] = ((BASE_num[,i])-min(BASE_num[,i])/(max(BASE_num[,i]))-(min(BASE_num[,i])))
}


###Creacion de funcion

# enumerate linear combinations
enumLC <- function(object, ...) UseMethod("enumLC")

#' @export
enumLC.default <- function(object, ...)
{
  # there doesn't seem to be a reasonable default, so
  # we'll throw an error
  stop(paste('enumLC does not support ', class(object), 'objects'))
}

enumLC.matrix <- function(object, ...)
{
  # factor the matrix using QR decomposition and then process it
  internalEnumLC(qr(object))
}

enumLC.lm <- function(object, ...)
{
  # extract the QR decomposition and the process it
  internalEnumLC(object$qr)
}

#' @importFrom stats lm
enumLC.formula <- function(object, ...)
{
  # create an lm fit object from the formula, and then call
  # appropriate enumLC method
  enumLC(lm(object))
}

# this function does the actual work for all of the enumLC methods
internalEnumLC <- function(qrObj, ...)
{
  R <- qr.R(qrObj)                     # extract R matrix
  numColumns <- dim(R)[2]              # number of columns in R
  rank <- qrObj$rank                   # number of independent columns
  pivot <- qrObj$pivot                 # get the pivot vector

  if (is.null(numColumns) || rank == numColumns)
  {
    list()                            # there are no linear combinations
  } else {
    p1 <- 1:rank
    X <- R[p1, p1]                    # extract the independent columns
    Y <- R[p1, -p1, drop = FALSE]     # extract the dependent columns
    b <- qr(X)                        # factor the independent columns
    b <- qr.coef(b, Y)                # get regression coefficients of
    # the dependent columns
    b[abs(b) < 1e-6] <- 0             # zap small values

    # generate a list with one element for each dependent column
    lapply(1:dim(Y)[2],
           function(i) c(pivot[rank + i], pivot[which(b[,i] != 0)]))
  }
}

findLinearCombos <- function(x)
{
  if(!is.matrix(x)) x <- as.matrix(x)
  lcList <- enumLC(x)
  initialList <- lcList
  badList <- NULL
  if(length(lcList) > 0)
  {
    continue <- TRUE
    while(continue)
    {
      # keep removing linear dependencies until it resolves
      tmp <- unlist(lapply(lcList, function(x) x[1]))
      tmp <- unique(tmp[!is.na(tmp)])
      badList <- unique(c(tmp, badList))
      lcList <- enumLC(x[,-badList, drop = FALSE])
      continue <- (length(lcList) > 0)
    }
  } else badList <- NULL
  list(linearCombos = initialList, remove = badList)
}


library(dplyr)
library(ggplot2)
library(GGally)
library(Hmisc)
library(corrplot)
library(PerformanceAnalytics)



comboinfo <- findLinearCombos(BASE_num)
comboinfo

#View(BASE)
N_BASE_num <- BASE_num[, -comboinfo$remove]
comboinfo <- findLinearCombos(N_BASE_num)

library(dplyr)
library(ggplot2)
library(GGally)
library(Hmisc)
library(corrplot)
library(PerformanceAnalytics)



BASE <- cbind(N_BASE_num,BASE_cat)

correlacion <- round(cor(N_BASE_num),1)
correlacion
par(mar=c(3,1,1,3))
corrplot(correlacion, method = "number", type = "upper")
corrplot(correlacion,type="upper",order="hclust",t.col="black",tl.srt = 45)

###Estandarizaci?n de variables#####

library(cluster)
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
cluster <- cutree(clusters_d, k=4)

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
