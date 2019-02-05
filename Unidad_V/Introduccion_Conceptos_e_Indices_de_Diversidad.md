# Introducción a los conceptos e índices de diversidad y su aplicación en estudios metagneómicos

Tres formas de caracterizar a la diversidad

Alfa - La diversidad intrínseca de una sóla población. (índice de Shannon)

¿qué nos dice la diversidad alfa? la riquza de las especies (número de especies, taxas y OTUs) y abundancia (de las mismas especies dentro del total de especies).

Beta - Comparación de dos comunidades

y 

Gamma - Landscape o el ecosistema (comunidades de un ecosistema)

Los índices de diversidad no te dicen la diversidad real, sino un _score_ o una calificación que representa la estimación de la actual diversidad (porque la diversidad se calcula haciendo sensos no muestreos y los índices de diversidad se generan a partir de un muestreo)

> ALFA

índice de Shannon - diversidad de especies ¿qué tantas especies diferentes hay?. Se pregunta también si todas las especies se encuentran en la misma proporción o exiten unas que dominen sobre de otras. Propuesta por Claude Shannon para medir entropía en _string_ (se mide de 0 - muy poco abundante a 1 - muy abundante). Es el cálculo de la incertidumbre o de la entropía. Parte de una prueba de hipótesis

ídnice de Gini-Simpson - índice de probabilidad de que, al sacar dos elementos del grupo, que éstos sean diferentes elementos o el mismo (se mide de 0 a 1 también)


> BETA qué tan diferente es la composición de un habitat a otro

índice de disimilaridad Bray-Curtis - Se cuentifica la disimilaridad entre dos sitios en el número de especies totales que tiene cada uno. 0 significa que los dos sitios tienen la misma abundancia de especies y 1 es que son completamente diferentes en abundancias de especies.

índice de distancia de Jaccard - el coeficiente Jaccard es el tamaño de la intersección entre dos conjuntos dividido por el tamaño de la unión. La distancia de Jaccard es 1 - el coeficiende de Jaccard. Este resultado nos diriía precencia o ausencia de las mismas especies en dos muestras. 0 los dos grupos tienen las mismas especies (no hay intersecciones en los grupos) y 1 son los grupos no tienen especies en común.

> GAMMA


índice de Chao - 

índice de Simpson - 


#### Lenguajes de programación (básicos: compartidos por todos los lenguajes)

Un entero - un dígito o combinación de varios dígitos. (8 bits)

Un caracter - alfa numéricos (""), incluso si es un número "2", será procesado por la computadora como un caracter y no como un eneter. (8 bits)

Un booleano - un proceso lógico (falso o verdadero). (1 bit)

Un factor -una categoría a la que se le asigna un enetero para ser interpretada.



### Parte Práctica


tenemos que sustituir los ; del archivo de tabla de diversidades por tabuladores para poder tener un espaciador por filo, clado, orde, familia, género, especie y el valor de abundancia relativa, todos separados por tabuladores (que serán interpretados como columnas diferentes) y lo guardaremos en un archivo nuevo llamado abundancia.txt

``sed 's/;/\t/g' lsu.ttt.level_4.txt > abundance.txt``


EN RStudio


````
#!/bin/r
#name: abundance_plot.r
# author: Jazmin Sanchez Perez

# Objective: Plot abundance of a organisms within a metagenomic abundance table

# Packages:
#	- Ggplot2
#	- Vegan
#	- gridExtra

# How to install those libraries
# install.package("ggplot2")
# install.package("vegan")
# install.package("gridExtra")

library(ggplot2)
library(vegan)
library(gridExtra)

##### Rarefraction curve
# Level 6 Bacteria
# set your working directory to where the abundance table is setwc("path/abundance.txt")
# import abundance table data to r
# un archivo .csv es un archivo que generará una tabla, cuyo delimitador serán las ,  (para leerlo podemos usar read.csv)
# un archivo .csv es un archivo que generará una tabla, cuyo delimitador serán las ; (para leerlo podemos usar read.csv2)
# un archivo .csv es un archivo que generará una tabla, cuyo delimitador será el \t (para leerlo podemos usar read.delim)

abundance_table <- read.delim("abundance.txt", header = FALSE, sep = "\t")

# si cargamos la tabla como está, los espacios vacíos de la tabla, los va a interpretar como un archivo incompleto, por lo que:
# una de dos: o vamos a cambiar el vacío por un NA o vamos a darle un último argumento al comando que me ayude a llenar los espacios vacíos

abundance_table <- read.delim("abundance.txt", header = FALSE, sep = "\t", fill = TRUE)

# el tipo de archivo con el que estamos trabajando es un data frame (un archivo de tipo tabla que contiene no sólo caracteres o enteros o buleanos, sino dos de estos o hasta los tres dentro de un sólo archivo). Este data frame es de dos dimensiones, donde x & y son filas y columnas.

# see type of data
class(abundance.txt)

# change names of column names
colnames(abundance.txt) <- c("Dominio","Phyla","Class","Order","Frequency")

# agregate frequency from class

class_sum <- aggregate(Frequency~Class, abundance.txt, sum)

# cambiar las abundancias a abundancia relativa. Para esto, le vamos a añadir a la variable original = a cada valor en la columna de frecuencias * 100 / la suma de todas las frecuencias, o sea el número total de todas las frecuencias

class_sum$ARelative <- clas_sum$Frequency*100/sum(class_sum$Frequency)

# y también vamos a llenar al primer valor de la columna Class el string de caracteres "Unclassified" porque está vacío para este archivo

class_sum$Class[1] <- "Unclassified"

# Vamos a plotear ahora sí.









````









