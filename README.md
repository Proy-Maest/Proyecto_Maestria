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
- Fortalecer estrategias de fidelización


## Modelamiento

## Segmentación mediante el uso de K-MEANS

Hoy en día para cualquier empresa,  segmentar es una manera de dividir un problema en partes más sencillas que ayuda a priorizar esfuerzos y a localizar oportunidades de negocio.

Se puede evidenciar que no todos los clientes son iguales ni tienen las mismas capacidades adquisitivas por lo tanto, es importante entender e identificar valor de grupos de individuos.

**Definición**

Segmentar es dividir una población en grupos homogéneos en función de necesidades, comportamientos, características o actitudes y caracterizar a los grupos resultantes para saber qué les distingue entre sí.


Dado un conjunto de observaciones (\x_1, \x_2, …, \x_n), donde cada observación es un vector real de d dimensiones, k-medias construye una partición de las observaciones en k conjuntos (k ≤ n) a fin de minimizar la suma de los cuadrados dentro de cada grupo (WCSS): S = {\S_1, \S_2, …, \S_k}

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


