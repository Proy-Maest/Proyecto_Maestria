# Maestría en Ciencia de los Datos 2019-II

# Integrantes
- Karen Lizeth Velásquez Moná 
- Ana María Uran González 
- Daniel Román Ramírez 
- Daniel Enrique Pinto Restrepo 
- Carlos Alberto Cerro Espinal

# Proyecto integrador: Segmentación de clientes según su transaccionalidad

# Oportunidad
Actualmente el sistema financiero cuenta con una penetración de tarjetas de crédito del 57,3% en la población bancarizada de Colombia, según estudio realizado por la compañía Minsait por medio de su informe Tendencias en Medios de Pago 2018. Lo cual lleva a la industria a tener grandes retos a nivel de facturación y mejoramiento del servicio, fomentando el uso del dinero plástico. De acuerdo a información de la Superintendencia Financiera de Colombia, el país cuenta con alrededor de 15 millones de plásticos vigentes emitidos, siendo el cuarto país entre 18 países latinoamericanos con mayor número de plásticos.

Tomando una muestra de clientes de una entidad bancaria, se quiere identificar segmentos para desarrollar estrategias particulares dependiendo de las características de cada grupo. Estas estrategias pueden ser de fidelización a largo plazo, adquisición de nuevos servicios, aumento de frecuencia del uso de tarjeta de crédito, entre otras.

## Argumentación
Hoy en día para cualquier empresa, segmentar es una manera de dividir un problema en partes más sencillas que ayuda a priorizar esfuerzos y a localizar oportunidades de negocio.

Se puede evidenciar que no todos los clientes son iguales ni tienen las mismas capacidades adquisitivas por lo tanto, es importante entender e identificar valor de grupos de individuos.

# Objetivo

- Segmentar los clientes por su historial de transaccionalidad con la entidad
- Estimar qué variables inciden en el aumento de la frecuencia de transacciones

## Metodología
Con el objetivo de identificar los grupos de personas y saber cuáles son las caractirísticas principales de los consumidores, se tiene en cuenta lo siguiente:
- Detección de Outliers
- Metodologia FMR
- Segmetanción K- Means
- Segmetanción K - Medoids (PAM )
- Análisis de resultados por segmentos

## Detección de Outliers

Detección y Remoción de Outliers
Cómo parte del proceso del proyecto integrador y de los aprendizajes de las diferentes materias, es necesario detectar outliers en nuestros datos. Con respecto al uso de tarjetas de crédito y del modelo RFM, las variables que se usan son: la edad, total de transacciones y monto total de transacciones. A continuación se describe detalladamente el proceso en el que se incurre.

![](https://github.com/Proy-Maest/Proyecto_Maestria/blob/Proy-Maest-patch-1/6-Deteccion_Outliers/outliers.png)

## Modelamiento

## Segmentación FRM 

![Definición 1](https://github.com/Proy-Maest/Proyecto_Maestria/blob/Proy-Maest-patch-1/Piramide.png)

RFM es uno de los métodos de segmentación de clientes más sencillos de implantar, y al mismo tiempo uno de los que mejores resultados aportan a corto plazo. Se basa en el célebre principio de Pareto, según la cual el 20% de los clientes de una compañía generan el 80% de los ingresos. El RFM es la mejor manera de constatar hasta qué punto este paradigma es real en nuestro caso, y ubicar a cada cliente en su escalón de la pirámide de valor.

El análisis consiste en clasificar a los clientes por su valor en función de tres variables:

- Recencia. Días transcurridos desde la última compra.

- Frecuencia. Número de compras por período de tiempo, como promedio. Por ejemplo, número de compras mensuales.

- Money. Valor de las compras totales realizadas por el cliente en el tiempo de análisis.

## Construcción de percentiles
Se construyen escalas, basadas en estas variables, dando a cada cliente un valor según el percentil en que se encuentra (percentiles = n grupos de igual tamaño, o cantidad de clientes). Lo más habitual es trabajar con 5 valores (quintiles), aunque no es raro el uso de 10 valores (deciles).

Por ejemplo, un cliente que estuviera entre el 20% de los que más recientemente han comprado, en el 2do 20% por frecuencia de compra y el 4to 20% en valor total de compras, se le asignaría el segmento 124, (R)5 (F)4 (M)2. Lo vemos en el gráfico:

 ![Definición 1](https://github.com/Proy-Maest/Proyecto_Maestria/blob/Proy-Maest-patch-1/segmentos.png)
 
 El gráfico siguiente muestra cómo se distribuye la venta de una enseña de comercio minorista, en función del segmento de valor monetario M al que pertenecen los clientes. Efectivamente, refleja la distribución 20/80.

Referencia: https://www.unica360.com/analisis-rfm-en-retail-empezando-a-segmentar-clientes-i
## Segmentación mediante el uso de K-MEANS
**Definición**

Segmentar es dividir una población en grupos homogéneos en función de necesidades, comportamientos, características o actitudes y caracterizar a los grupos resultantes para saber qué les distingue entre sí.


Dado un conjunto de observaciones (X1, X2, …, Xn), donde cada observación es un vector real de d dimensiones, k-medias construye una partición de las observaciones en k conjuntos (k ≤ n) a fin de minimizar la suma de los cuadrados dentro de cada grupo (WCSS): 
S = {S1, S2, …, Sk}

![Definición 1](https://github.com/Proy-Maest/Proyecto_Maestria/blob/Proy-Maest-patch-1/DEFINICION_1.png)

# Algoritmo

**Asignación**: Asigna cada observación al grupo con la media más cercana (es decir, la partición de las observaciones de acuerdo con el diagrama de Voronoi generado por los centroides).

![Asignación](https://github.com/Proy-Maest/Proyecto_Maestria/blob/Proy-Maest-patch-1/ASIGNACION.png)

**Actualización**: Calcular los nuevos centroides como el centroide de las observaciones en el grupo.

![Asignación](https://github.com/Proy-Maest/Proyecto_Maestria/blob/Proy-Maest-patch-1/ACTUALIZACION.png)

Los métodos de inicialización de Forgy y Partición Aleatoria son comúnmente utilizados.El método Forgy elige aleatoriamente k observaciones del conjunto de datos y las utiliza como centroides iniciales. El método de partición aleatoria primero asigna aleatoriamente un clúster para cada observación y después procede a la etapa de actualización, por lo tanto calcular el clúster inicial para ser el centro de gravedad de los puntos de la agrupación asignados al azar. El método Forgy tiende a dispersar los centroides iniciales, mientras que la partición aleatoria ubica los centroides cerca del centro del conjunto de datos. Según Hamerly y compañía, el método de partición aleatoria general, es preferible para los algoritmos tales como los k-medias armonizadas y fuzzy k-medias. Para expectation maximization y el algoritmo estándar el método de Forgy es preferible.

# Resultados

![K-óptimo](https://github.com/Proy-Maest/Proyecto_Maestria/blob/Proy-Maest-patch-1/k_means_1.png)

![Segmentación K-Means](https://github.com/Proy-Maest/Proyecto_Maestria/blob/Proy-Maest-patch-1/kmeans_1.png)

**Referencia: https://es.wikipedia.org/wiki/K-medias**

# Clasificación modelo PAM (Partitioning Around Medoids)


K-medoids es un método de clustering muy similar a K-means ya que ambos agrupan las observaciones en K clusters, donde K es un valor preestablecido por quien lo estudio. La diferencia es que, en K-medoids, cada cluster está representado por una observación presente en el cluster (medoid), mientras que en K-means cada cluster está representado por su centroide, que se corresponde con el promedio de todas las observaciones del cluster pero con ninguna en particular.

Específicamente la definición de metoid es el elemento dentro de un cluster cuya distancia (diferencia) promedio entre él y todos los demás elementos del mismo cluster es lo menor posible. Se corresponde con el elemento más central del cluster y por lo tanto puede considerarse como el más representativo. El hecho de utilizar medoids en lugar de centroides hace de K-medoids un método más robusto que K-means, viéndose menos afectado por outliers o ruido. A modo de idea intuitiva puede considerarse como la analogía entre media y mediana.

## Pasos para el desarrollo del método
- Seleccionar K observaciones aleatorias como medoids iniciales.
- Calcular la matriz de distancia entre todas las observaciones
- Asignar cada observación a su medoid más cercano
Para cada uno de los clusters creados, comprobar si seleccionando otra observación como medoid se consigue reducir la distancia del cluster, si esto ocurre, seleccionar la observación que consigue una mayor reducción como nuevo medoid.

- Si al menos un medoid ha cambiado en el paso 4, volver al paso 3, de lo contrario, se termina el proceso.

## Ventajas y Desventajas
- K - medoids es un método de clustering más robusto que K-means, por lo es más adecuado cuando el set de datos contiene outliers o ruido.

- Necesita que se especifique el número de clusters que se van a crear. Esto puede ser complicado de determinar si no se dispone de información adicional sobre los datos.

- Para sets de datos grandes necesita muchos recursos computacionales. En tal situación se recomienda aplicar el método CLARA.

## Modelo adecuado

El método de k-medoids presentó un mejor desempeño ya que comparado con k-means tuvo  la mínima distancia media.


Dado que el objetivo del proyecto es encontrar eficazmente características importantes en los clientes para realizar una buena segmetanción, se investiga con el negocio cuáles comportamientos son mas comunes en los consumidores por lo tanto buscamos en cada  eslabón de la pirámide buscando caractisticas especiales, finalmente concluimos que por estrategia del negocio se escogen 4 grupos. (k=4).

## Resultados

![K-óptimo](https://github.com/Proy-Maest/Proyecto_Maestria/blob/Proy-Maest-patch-1/k_optimo.png)

![Clasificación PAM](https://github.com/Proy-Maest/Proyecto_Maestria/blob/Proy-Maest-patch-1/PAM.png)

**Referencia: https://rpubs.com/Joaquin_AR/310338**

# Conclusiones

- La identificación outliers permitió preparar  una base de datos  más  eficiente para la  implementación la metodología RFM
- El uso de herramientas en la nube nos permitió generar una infraestructura adecuada para el manejo de grandes volúmenes de  datos, permitiendo la  escalabilidad del  problema.
- El RFM es útil para segmentar los clientes de acuerdo a la fidelidad al medio de pago, sin embargo,  se queda corto  para medir  otras variables  propias de los tarjetahabientes
- El método de k-medoids presentó un mejor desempeño ya que comparado con k-means tuvo  la mínima distancia media
- Las características   expuestas  previamente no se  relacionan con un publico particular, sino con el contexto del cliente lo cual permitirá el diseño de  estrategias focalizadas que  permitan la migración entre las  categorías de la pirámide.​
- Complementar modelos de segmentación estratégica con modelos enfocados en segmentaciones tácticas como k-medoids,  permite aproximarse  a un modelo básico de segmentación dinámica dado un cotexto.
- Dado el dinamismo del medio de pago la aplicación de métodos de clusterización nos permite evidencia en el corto plazo​ el desplazamiento de los clientes en los diferentes eslabones de  fidelización.​




