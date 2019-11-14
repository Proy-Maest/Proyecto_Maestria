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

# Objetivo

- Segmentar los clientes por su historial de transaccionalidad con la entidad
- Estimar qué variables inciden en el aumento de la frecuencia de transacciones


## Modelamiento

## Segmentación mediante el uso de K-MEANS

Hoy en día para cualquier empresa,  segmentar es una manera de dividir un problema en partes más sencillas que ayuda a priorizar esfuerzos y a localizar oportunidades de negocio.

Se puede evidenciar que no todos los clientes son iguales ni tienen las mismas capacidades adquisitivas por lo tanto, es importante entender e identificar valor de grupos de individuos.

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

Con el fin de encontrar un modelo indicado se prueba el modelo PAM (Partitioning Around Medoids), todos los modelos de segmentación tratan de resolver el mismo problema de minimizar una diferencia de distancias calculadas, este modelo es muy parecido al algoritmo de k-means la diferencia principal es que PAM está calculado con medioides mientras que K-medias lo hace sobre centroides.
Partitioning Around Medoids:
 
•	Se calcula la distancia de las observaciones con la función Daisy:
 
Es una función que se utiliza cuando se tienen variables mixtas (numéricas y categóricas), donde la métrica con la cual se obtienen las distancias es “gower”, cada una de las observaciones se calcula así:

![Deisy function](https://github.com/Proy-Maest/Proyecto_Maestria/blob/Proy-Maest-patch-1/daisy_funcion.png)

•	Se minimiza una distancia:

![Minimiza la distancia](https://github.com/Proy-Maest/Proyecto_Maestria/blob/Proy-Maest-patch-1/distancia_min.png)

**Referencia: https://rpubs.com/Joaquin_AR/310338**

# Aplicación para el caso de estudio

Con la metodología K-Means se desea responder algunas preguntas de negocio que son importantes para la creación de estrategias para el aumento de valor de la compañia.

Con K-Means se quiere responder los siguientes cuestionamientos.

- Identificar el tipo de clientes
- ¿Cuál es el medio de pago mas utilizado?
- ¿Cuál es el canal mas utilizado?
- ¿Cuáles son las características de los clientes que tienen mas transacciones en el año?
- ¿Cuáles clientes son mas propensos en dejar de pagar con tarjeta?

# Desarrollo

Para realizar el modelo los clientes deben tener como mínimio una transacción acumulada  y luego se seleccionan las variables numéricas del dataset para la clusterización.

Se segmentó de acuerdo a:
- Edad
- Rango Ingresos
- Monto transado
- Total trx acumuladas


