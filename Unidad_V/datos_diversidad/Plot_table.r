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


