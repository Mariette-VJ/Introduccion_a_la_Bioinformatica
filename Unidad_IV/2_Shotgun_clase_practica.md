# Shotgun Metagenomics: clase práctica

Antes de empezar la práctica, prepararemos nuestra carpeta de trabajo
Vamos a dirigirnos a nuestras carpetas personales, en las que hemos estado trabajando

conectarse al servidor con ``ssh``

``cd ~/Desktop/CURSO_BIOINFO/METAGENOMICA/alumnos/NOMBRE``

``ls``

meta_amplicones/

---

``mkdir meta_shotgun && cd meta_shotgun``


> __Shotgun metagenomics.__ The random sequencing of gene fragments isolated from environmental samples, allowing sequencing of uncultivable organisms.

> __Shotgun sequencing.__ DNA is fragmented into small segments which are individually sequenced and then reassembled into longer, continuous sequences using sequence assembly software.


#### Limpieza de reads crudos

Hagamos una liga simbólica de los reads a nuestras carpetas de trabajo

``ln -s ~/Desktop/CURSO_BIOINFO/METAGENOMICA/data/meta_shotgun/* .``

``ls``

gut1_R1.fastq

gut1_R2.fastq

gut2_R1.fastq

gut2_R2.fastq

---

Ahora, vamos a verificar que todos los reads tengan par (para eso primero tenemos que visualizar el header de los archivos)

``less gut1_R1.fastq``

@SRR492065.1 HWI-EAS385_0095_FC:2:1:6702:1434/1
TCAGCCATCGCTATGCTTGGCTTCACTGTGAAGACCACTCCAATCGCGACTTGTCACGATTGTCGTTACCATTAAANNNNNGAAAACAGGAGAACAAGTA
+

---

``grep -c "^@SRR" gut1_R*``

gut1_R1.fastq:100000

gut1_R2.fastq:100000

---

``grep -c "^@M0" gut2_R*``

gut2_R1.fastq:100000

gut2_R2.fastq:100000

---

#### Union de PE reads o saltar el paso?

#### Anotar taxones con reads o con contigs?

>Recuerden que el orden de los pasos sí va a afectar el producto. Para propósitos académicos, vamos a seguir todos los pasos de la metodología:

>Haremos una unión de los reads tipo PE y, con la salida de esos reads, haremos la anotación taxonómica. Después, haremos un ensamble de los reads, validaremos el ensamble y usaremos los contigs para repetir la anotación taxonómica y hacer una anotación funcional.


#### Pareado de lecturas

creamos una carpeta de trabajo para pear:

``mkdir pear && cd pear``

para la primera muestra:

``pear -f ../gut1_R1.fastq -r ../gut1_R2.fastq -o gut1_pear``

``ls``

gut1_pear.assembled.fastq

gut1_pear.unassembled.forward.fastq

gut1_pear.unassembled.reverse.fastq

gut1_pear.discarded.fastq

---

y para la segunda muestra:

``pear -f ../gut2_R1.fastq -r ../gut2_R2.fastq -o gut2_pear``

``ls``

gut1_pear.assembled.fastq

gut1_pear.unassembled.forward.fastq

gut1_pear.unassembled.reverse.fastq

gut1_pear.discarded.fastq

gut2_pear.assembled.fastq

gut2_pear.unassembled.forward.fastq

gut2_pear.unassembled.reverse.fastq

gut2_pear.discarded.fastq

---

Ahora verificamos el número de reads que se encuentran en los archivos:

``grep -c "^@SRR" gut*_pear.*``

gut1_pear.assembled.fastq:1897

gut1_pear.unassembled.forward.fastq:98103

gut1_pear.unassembled.reverse.fastq:98103

gut1_pear.discarded.fastq:0

gut2_pear.assembled.fastq:889

gut2_pear.unassembled.forward.fastq:99111

gut2_pear.unassembled.reverse.fastq:99111

gut2_pear.discarded.fastq:0

---

___PREGUNTA: _¿por qué para datos shotgun salieron tantas lecturas unassembled?_, _¿estas secuencias pueden o no pueden usarse?_, _¿por qué?____

---

Para usar todos los archivos como entrada, vamos a comprimir a los mismos en una carpeta tipo .tar.bz2 que llamaremos input1 e input2 (separados por muestreo)

---

``tar -cvjSf input1.tar.bz2 gut1_pear.*ssembled.*``

``tar -cvjSf input2.tar.bz2 gut2_pear.*ssembled.*``

``ls``

gut1_pear.assembled.fastq

gut1_pear.unassembled.forward.fastq

gut1_pear.unassembled.reverse.fastq

gut1_pear.discarded.fastq

gut2_pear.assembled.fastq

gut2_pear.unassembled.forward.fastq

gut2_pear.unassembled.reverse.fastq

gut2_pear.discarded.fastq

input1.tar.bz2

input2.tar.bz2


----

Ahora, vamos a mover las carpetas comprimidas que creamos dentro de otra que vamos a llamar taxonomy

``mkdir taxonomy``

``mv input* taxonomy/.``

``cd taxonomy && ls``

input1.tar.bz2

input2.tar.bz2

---


#### Predicción y anotación taxonómica (¿quién está ahí?)

__Para la anotación taxonómica usaremos el programa [MetaPhlAn2](https://bitbucket.org/biobakery/metaphlan2)__


En la carpeta que acabamos de realizar generaremos la predicción y anotación taxonómica usando MetaPhlAn2, un programa que utiliza una base de datos de marcadores clado específicos para asignar taxonomía (Figura 1): 

---

_NOTA: ¿Recuerdan la lectura obligatoria mencionada en la introducción de los análsis metagenómicos?: [An evaluation of the accuracy and speed of metagenome analysis tools](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4726098/pdf/srep19233.pdf)_

---

![alt_text](images/metaphlan_overview.png)

_Figura 1. Diagrama del método de anotación usando marcadores clado específicos que utiliza MetaPhlAn_

---

PREGUNTA: _¿Cómo elegir el mejor programa para anotar taxones en datos metagenómicos?_, _¿Qué otros programas existen para realizar este paso?_, _¿Cuáles son las ventajas y desventajas de cada programa?_

---

Ahora sí, comencemos con la predicción taxonómica y veamos la abundancia relativa de los organismos presentes en la muestra:

Para la primera muestra:

```
tar -xjf input1.tar.bz2 --to-stdout | python ~/Desktop/CURSO_BIOINFO/METAGENOMICA/metaphlan2/metaphlan2.py --input_type multifastq > gut1_taxonomy.txt

```

``mv stdin_map.bowtie2out.txt gut1_map.bowtie2out.txt``

Para la segunda muestra:

```
tar -xjf input2.tar.bz2 --to-stdout | python ~/Desktop/CURSO_BIOINFO/METAGENOMICA/metaphlan2/metaphlan2.py --input_type multifastq > gut2_taxonomy.txt

```
``mv stdin_map.bowtie2out.txt gut2_map.bowtie2out.txt``

---

Veamos los archivos .txt de salida

``less gut1_taxonomy.txt``

> #SampleID       Metaphlan2_Analysis
> k__Bacteria     100.0
> k__Bacteria|p__Firmicutes       86.78502
> k__Bacteria|p__Actinobacteria   13.21498
> k__Bacteria|p__Firmicutes|c__Bacilli    76.57419
> k__Bacteria|p__Actinobacteria|c__Actinobacteria 13.21498
> k__Bacteria|p__Firmicutes|c__Clostridia 10.21083
> k__Bacteria|p__Firmicutes|c__Bacilli|o__Lactobacillales 69.09124
> k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Actinomycetales      13.21498
> k__Bacteria|p__Firmicutes|c__Clostridia|o__Clostridiales        10.21083
> k__Bacteria|p__Firmicutes|c__Bacilli|o__Bacillales      7.48295
> k__Bacteria|p__Firmicutes|c__Bacilli|o__Lactobacillales|f__Enterococcaceae      69.09124
> k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Actinomycetales|f__Propionibacteriaceae      13.21498
> k__Bacteria|p__Firmicutes|c__Clostridia|o__Clostridiales|f__Clostridiales_Family_XI_Incertae_Sedis      10.21083
> k__Bacteria|p__Firmicutes|c__Bacilli|o__Bacillales|f__Staphylococcaceae 7.48295


``less gut2_taxonomy.txt``

> #SampleID       Metaphlan2_Analysis
> k__Bacteria     100.0
> k__Bacteria|p__Firmicutes       81.56846
> k__Bacteria|p__Actinobacteria   18.43154
> k__Bacteria|p__Firmicutes|c__Bacilli    77.19391
> k__Bacteria|p__Actinobacteria|c__Actinobacteria 18.43154
> k__Bacteria|p__Firmicutes|c__Clostridia 4.37455
> k__Bacteria|p__Firmicutes|c__Bacilli|o__Lactobacillales 71.35411
> k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Actinomycetales      18.43154
> k__Bacteria|p__Firmicutes|c__Bacilli|o__Bacillales      5.83979
> k__Bacteria|p__Firmicutes|c__Clostridia|o__Clostridiales        4.37455
> k__Bacteria|p__Firmicutes|c__Bacilli|o__Lactobacillales|f__Enterococcaceae      71.35411
> k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Actinomycetales|f__Propionibacteriaceae      18.43154
> k__Bacteria|p__Firmicutes|c__Bacilli|o__Bacillales|f__Staphylococcaceae 5.83979
> k__Bacteria|p__Firmicutes|c__Clostridia|o__Clostridiales|f__Clostridiales_Family_XI_Incertae_Sedis      4.37455


__NOTA: Vamos a comparar las abundancias taxonómicas de ambos muestreos:__

Concatenar las tablas de abundancias con un programa de metaphlan (el número de muestras a concatenar es ilimitado, _pueden ser 2, 3, 4 o más_):

```~/Desktop/CURSO_BIOINFO/METAGENOMICA/metaphlan2/utils/merge_metaphlan_tables.py gut*_taxonomy.txt > merged_abundance_table.txt```


``less merged_abundance_table.txt``

> ID      gut1_taxonomy   gut2_taxonomy
> #SampleID       Metaphlan2_Analysis     Metaphlan2_Analysis
> k__Bacteria     100.0   100.0
> k__Bacteria|p__Actinobacteria   13.21498        18.43154
> k__Bacteria|p__Actinobacteria|c__Actinobacteria 13.21498        18.43154
> k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Actinomycetales      13.21498        18.43154
> k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Actinomycetales|f__Propionibacteriaceae      13.21498        18.43154
> k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Actinomycetales|f__Propionibacteriaceae|g__Propionibacteriaceae_unclassified 0.8905  0.0
> k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Actinomycetales|f__Propionibacteriaceae|g__Propionibacterium 12.32448        18.43154
> k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Actinomycetales|f__Propionibacteriaceae|g__Propionibacterium|s__Propionibacterium_avidum     12.32448        18.43154
> k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Actinomycetales|f__Propionibacteriaceae|g__Propionibacterium|s__Propionibacterium_avidum|t__Propionibacterium_avidum_unclassified    12.32448        18.43154
> k__Bacteria|p__Firmicutes       86.78502        81.56846
> k__Bacteria|p__Firmicutes|c__Bacilli    76.57419        77.19391
> k__Bacteria|p__Firmicutes|c__Bacilli|o__Bacillales      7.48295 5.83979
> k__Bacteria|p__Firmicutes|c__Bacilli|o__Bacillales|f__Staphylococcaceae 7.48295 5.83979



#### Ensamble 

__ ¿HACEMOS ENSAMBLE O NO HACEMOS ENSAMBLE? ¿ENSAMBLE DE NOVO O CON REFERENCIA?__

Dado a que no esperamos un gen específico (como era el caso de los amplicones), sino un pedacerío del genoma de muchos organismos__, la mayoría no descritos en base de datos__, la estrategia de tener las secuencias más largas antes de la anotación, genera una confianza de anotación mayor (_¿por qué?_).

![alt_text](images/assembly_vs_raw_annotate.png)



La estrategia que se elija, va a depender totalmente en  la pregunta que se quiere contestar y, para algunas situaciones específicas, los ensambles con referencia podrían ser una buena idea... pero hablando a grandes rasgos, dado a que todo el propósito de la metagenómica. Sin embargo, el paso de realizar un ensamble (sobretodo cuando se elige realizar de forma _de novo_) también arrastra un nivel de error. Por esta razón, muchas veces se trabaja con los reads limpios y unidos (_¿recuerdan PEAR, el programa para unir reads tipo paired end?_) y muchas otras se trabaja con contigs (lecturas más largas).

__El día de hoy usaremos megahit para ensamblar PE reads ya limpios__

``wget DATOS_A_ANALIZAR.gz``
``descomprimir datos_limpios``


Prepararemos una carpeta para el ensamble y haremos una liga simbólica a los reads en nuestra carpeta de trabajo de ensamble

``mkdir assemble && cd assemble``
``ln  -s ../datos_limpios .``

Ahora correremos [megahit](http://www.metagenomics.wiki/tools/assembly/megahit) con los siguientes argumentos:

``path_al_programa/megahit kjsdcgyakvdjbkcnkjsgvdbhcnjxdfvhcbsjx``

min_length (longitud mínima) de blah

Dejemos correr al programa y cuando termine, veamos el resultado del ensamble

``cd megahit``
``less final.contigs``


__ El siguiente paso será el de eliminar las secuencias que estén muy cortas__

Haremos un filtro de contigs, eliminando aquellos con una longitud menor a 500 pb. Para lo anterior, usaremos un script que habrá que copiar a la carpeta en la que estamos parados (donde están nuestros contigs finales)

``cp path_al_programa/filter.pl .``
``perl filter.pl 500 final.contigs``

Vamos a ver cuántos reads fueron eliminados (cuántos reads tenían una longitud menor a 500 pb) en este paso.

`` grep ^> final.contigs``
``grep ^> filtered.contigs``

¿Cuántos reads eliminamos?

#### Validación de ensamble:

__Vamos a crear una carpeta de valoración del ensamble__

``cd ../..``

Asegúrate de estar parado en la carpeta shotgun que hicimos al principio de la práctica

``pwd``

Una vez ahí, realicemos una carpeta para la valoración del ensamble y generemos una liga simbólica a los cotigs finales de megahit y también a los contigs que filtramos con el script

``mkdir assessment && cd assessment``
``ln -s ../assemble/megahit/final.contigs .``
``ln -s ../assemble/meganit/filtered .``

__La valoración la realizaremos con el programa quast__ (recuerden que ya usaron este programa antes en la unidad de genómica), usando como input a los contigs que creamos con  megahit y como output obtendremos un reporte en un archivo de texto

``~/path_al_programa/quast-4.6.3/quast.py shotgun_filtered_500_contigs.fa -o assemble_report``

Veamos el reporte

``cd assemble_report``
``less report.txt``

> N50 debe ser un número alto
> L50 es el número de cóntigs con longitud igual o mayor a la N50. En otras palabras, es el número mínimo de contigs que cubren la mitad del ensamble. Entre más pequeño el número, mejor (aunque en metagenomas de muestras muy muy complejas, eso sería muy difícil):

![alt_text](images/assembly_metagenomics.png)

__Elegir un ensamble de mayor o mejor calidad sólo podría tener sentido al comparar varios ensambles entre sí:__

por lo que vamos a hacer el paso anterior pero comparando los contigs finales antes y después de eliminar las lecturas menos de 500 pb

NOTA: Aquí lo ideal sería comparar los contigs finales de ensambles realizados con diferentes programas (por ejemplo, IDBA y megahit)

``~/path_al_programa/quast-4.6.3/quast.py shotgun_contigs.fa shotgun_filtered_500_contigs.fa -o compare_assemble_report``

__Veamos el reporte de comparación de ensambles__

``cd compare_assemble_report``
``less report.txt``


#### Predicción y anotación funcional (¿qué están haciendo -potencialmente-?)

__PREDICCIÓN DE MARCOS DE LECTURA ABIERTOS__

El primer paso antes de anotar los genes, sería el de reconocer las secuencias con marco de lectura abierto dentro de tus reads totales. O sea, encontrar sólo las secuencias que posiblemente se expresen en proteínas.

[MetaGeneMark](http://exon.gatech.edu/GeneMark/license_download.cgi) es un programa que filtra los contigs, reconociendo sólo las secuencias codificantes (elimina incluso los pseudo genes).

``mkdir orfs && cd orfs``
``~/Programs/MetaGeneMark/mgm/gmhmmp``

``amfviundfjdsn  mghfvbdsjhjvddfskjbhdsk``


__ANOTACIÓN DE GENES / BASE DE DATOS DE KEGG:__

[GhostKOALA](https://www.kegg.jp/ghostkoala/)


