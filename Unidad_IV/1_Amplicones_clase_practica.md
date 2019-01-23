# Metabarcoding (amplicones): clase práctica

Antes de empezar la práctica, prepararemos nuestra carpeta de trabajo.

conectarse al servidor con ``ssh``

``cd ~/Desktop/CURSO_BIOINFO/METAGENOMICA/``

``ls``

``cd alumno``

``mkdir NOMBRE && cd NOMBRE``

``mkdir meta_amplicones && cd meta_amplicones``


> __Metabarcoding.__ Uses gene‐specific PCR primers to amplify DNA from a collection of organisms or from environmental DNA. Another term for amplicon sequencing.
>
>__Marker gene.__ A gene or DNA sequence targeted in amplicon sequencing to screen for a specific organism group or functional gene.
>
>__Amplicon sequencing.__ Targeted sequencing of an amplified marker gene.


#### Limpieza de reads crudos

* [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) - all purpose

Los reads proporcionados para trabajar, ya están procesados en calidad (recuerden que ya vimos este paso y es el mismo, así que nos lo saltaremos). Sin embargo, vale la pena comentar un par de programas extra que son muy útiles para limpieza y análisis de salida de datos.

* gnx-tools - te ayuda a ver en la terminal, el número de reads totales que tienes, la longitud menor y mayor de tus reads y el N50

``# sudo apt-cache search gnx-tools``

``# sudo apt-get install gnx-tools``

* [fastx-toolkit](http://hannonlab.cshl.edu/fastx_toolkit/) - este repositorio en realidad contiene muchos programas/comandos para hacer pasos muy específicos con los datos fastq, por ejemplo fastx_quality_stats te genera un reporte de calidad de tus datos, fastq_quality_trimmer únicamente limpia reads de baja calidad, fasq_to_fasta te ayuda a convertir archivos fastq a su versión en fasta, ya que algunos programas necesitan tus reads en fasta como input, etc)

``# sudo apt-cache search fastx-toolkit``

``# sudo apt-get fastx-toolkit``


PROBEMOS ALGUNO DE ESTOS COMANDOS: Vamos a crear una liga simbólica de los reads de amplicones con los que trabajaremos a nuestras carpetas personales (_para poder trabajar con los datos de manera cómoda sin estar usando tanta memoria copiando archivos_)


``ln -s ~/Desktop/CURSO_BIOINFO/METAGENOMICA/data/meta_amplicon/* .``

``gnx-tools BR_R1_paired.q15.fastq``

``grep -c "^@M0" BR_R*``

BR_R1_paired.q15.fastq:286

BR_R2_paired.q15.fastq:286


``fastq_to_fasta -h``

usage: fastq_to_fasta [-h] [-r] [-n] [-v] [-z] [-i INFILE] [-o OUTFILE]

Part of FASTX Toolkit 0.0.14 by A. Gordon (assafgordon@gmail.com)


[-h]         = This helpful help screen.

[-r]         = Rename sequence identifiers to numbers.

[-n]         = keep sequences with unknown (N) nucleotides.
                  Default is to discard such sequences.

[-v]         = Verbose - report number of sequences.
                  If [-o] is specified,  report will be printed to STDOUT.
                  If [-o] is not specified (and output goes to STDOUT),
                  report will be printed to STDERR.

[-z]         = Compress output with GZIP.

[-i INFILE]  = FASTA/Q input file. default is STDIN.

[-o OUTFILE] = FASTA output file. default is STDOUT.

---

``fastq_to_fasta -i BR_R1_paired.q15.fastq -o BR_R1_paired.q15.fasta``

``fastq_to_fasta -i BR_R2_paired.q15.fastq -o BR_R2_paired.q15.fasta``

``ls``

BR_R1_paired.q15.fasta

BR_R1_paired.q15.fastq

BR_R2_paired.q15.fasta

BR_R2_paired.q15.fastq



#### Pareando reads

> Aquí no hay ensambles ni evaluación de ensambles, dado a que cada lectura (en teoría) corresponde a una secuencia del marcador molecular elegido para hacer la clasificación (16S, por ejemplo). Lo que sí se puede hacer para verificar que las lecuras sean exactamente lo que se pidió secuenciar (sobretodo si tú no hiciste las PCRs a partir de tu ADN ambiental, sino que lo hicieron en un centro de secuenciación).

> Podríamos descargar un genoma de referencia o un gen 16S completo y mapear los reads para verificar a partir de que pb se une y termina y comprobar la región hipervariable que se secuenció (así podemos corroborar que nos secuenciaron exactamente lo que pedimos).

> Además, se puede predecir si tus reads tipo PE tendrán sobrelape (esto dependerá del tamaño de read total que pueden alcanzar tus lecturas y el tamaño de la región de marcador que elegiste secuenciar). Las lecuturas tipo paired end están diseñadas como lecturas con un espacio de separación y que se secuenciaron en direcciones contrarias. Esto quiere decir que tienen un punto de sobre lape intermedio que es complementario y que les permitirá unirse y formar una lectura más grande.


Como ya se ha mencionado, un programa que hace la unión pareada de los Reads es [PEAR](https://cme.h-its.org/exelixis/web/software/pear/).

``pear``

``pear -f BR_R1_paired.q15.fastq -r BR_R2_paired.q15.fastq -j 2 -o BR_pear``

``ls``

BR_pear.assembled.fastq

BR_pear.unassembled.forward.fastq

BR_pear.unassembled.reverse.fastq

BR_pear.discarded.fastq

BR_R1_paired.q15.fastq

BR_R2_paired.q15.fastq

BR_R1_paired.q15.fasta

BR_R2_paired.q15.fasta


``grep -c "^@M0" BR_pear.*``

BR_pear.assembled.fastq:282

BR_pear.unassembled.forward.fastq:4

BR_pear.unassembled.reverse.fastq:4

BR_pear.discarded.fastq:0




#### Eliminar secuencias no deseadas (quimeras):

Se han desarrollado muchos programas específicos para detectar secuencias quiméricas generadas por el PCR para amplicones. Ejemplos de estos programas son:

*	Chimera Check
*	Chimeric Alignment
*	ChimeraSlayer (algoritmo de qiime) - necesita una base de datos (ej RDP)
*	USEARCH (algoritmo de qiime) - necesita una base de datos (ej RDP)
*	Perseus

----

Para la práctica, nosotros vamos a generar una predicción de las quimeras con el programa USEARCH (usando la base de datos [RDP](https://sourceforge.net/projects/rdp-classifier/)).  a través de un programa llamado [qiime2](http://qiime.org/tutorials/chimera_checking.html)

Antes de correr qiime, tenemos que converir nuestros reads pareados en fasta porque qiime requiere fastas como input

``fastq_to_fasta -i BR_pear.assembled.fastq -o BR_pear.assembled.fasta``

Y vamos a mover estos archivos a una carpeta separada que llamaremos qiime

``mkdir qiime``

``mv BR_pear.assembled.fasta qiime/.``

``cd qiime && ls``

BR_pear.assembled.fasta

---

Ahora sí, comencemos con qiime. Qiime es un programa complicado de instalar, que requiere de muchas pre instalaciones para trabajar. Si quieren ver toda la información para instalar el programa, da click [aquí](http://qiime.org/install/index.html)

```
source ~/miniconda2/bin/activate ~/Desktop/CURSO_BIOINFO/METAGENOMICA/qiime2-2018.11
```

```
identify_chimeric_seqs.py -i BR_pear.assembled.fasta -m usearch61 -o BR_checked_chimeras.rdp -r ~/Downloads/RDPClassifier_16S_trainsetNo15_rawtrainingdata/trainset15_092015.fa
```

para salir de qiime: ``source deactivate``

``ls``

BR_checked_chimeras.rdp

BR_pear.assembled.fasta


``ls BR_checked_chimeras.rdp/``

BR_pear.assembled.fasta_chimeras_denovo.log	

BR_pear.assembled.fasta_consensus_fixed.fasta

BR_pear.assembled.fasta_chimeras_denovo.uchime	

BR_pear.assembled.fasta_consensus_with_abundance.fasta

identify_chimeric_seqs.log

BR_pear.assembled.fasta_chimeras_ref.log	BR_pear.assembled.fasta_consensus_with_abundance.uc

BR_pear.assembled.fasta_chimeras_ref.uchime	BR_pear.assembled.fasta_smallmem_clustered.log

chimeras.txt

non_chimeras.txt


``less chimeras.txt``

``less non_chimeras.txt``

``less identify_chimeric_seqs.log``

El siguiente paso sería el de eliminar las quimeras identificadas del archivo original (o sea, filtrar las quimeras del archivo de reads)

volvamos a entrar a qiime: 

```
source ~/miniconda2/bin/activate ~/Desktop/CURSO_BIOINFO/METAGENOMICA/qiime2-2018.11
```

```
filter_fasta.py -f BR_pear.assembled.fasta -o BR_non_chimeric.fasta -s BR_checked_chimeras.rdp/chimeras.txt -n
```

>"Don’t forget to pass the -n parameter to filter_fasta.py – this tells filter_fasta.py to discard the sequences you’ve passed via -s, rather than to keep only those sequences. Then pass the resulting subalignment (non_chimeric_rep_set_aligned.fasta) in the downstream steps filter_alignment.py prior to tree-building"

``less BR_non_chimeric.fasta``

`` grep -c "^>M0" BR_non_chimeric.fasta``

_¿se eliminaron todas las quimeras?_, _¿cómo sabemos eso?_


#### Anotación taxonómica (OTUs) (¿quién está ahí?)

El último paso es el de predecir los OTUs.

Antes de usar la detección de OTUs, hay que renombrar cada uno de los headers de las secuencias en nuestro archivo sin quimeras (o sea, que no todos digan >M0...) porque si no se cambia el nombre, todas las salidas estarán mal identificadas.

```
awk '/^>/{print">BR_nombre_"++i;}{print}' BR_non_chimeric.fasta | sed ':a;N;$!ba;s/\n>M/M/g' > BR_non_chimeric_header.fasta
```

``less BR_non_chimeric_header.fasta``

---

__PREDICCIÓN DE OTUs CON REFERENCIA__

Ahora sí, realizaremos la predicción de OTUs con referencia (la predicción se hace con una base de datos de referencia: 97_otus.fasta)

```
pick_open_reference_otus.py -i BR_non_chimeric_header.fasta -o otus_open_reference -r /usr/local/lib/python2.7/dist-packages/qiime_default_reference/gg_13_8_otus/rep_set/97_otus.fasta
```

``ls``
BR_checked_chimeras.rdp

BR_non_chimeric.fasta

BR_non_chimeric_header.fasta

BR_pear.assembled.fasta

otus_open_reference/


``cd otus_open_reference/ && ls``

final_otu_map_mc2.txt

log_20190122233934.txt

otu_table_mc2_w_tax.biom

rep_set.fna

step4_otus

final_otu_map.txt

new_refseqs.fna

otu_table_mc2_w_tax_no_pynast_failures.biom

rep_set.tre

uclust_assigned_taxonomy

index.html

otu_table_mc2.biom

pynast_aligned_seqs

step1_otus

---

``tail -5 final_otu_map.txt``

New.CleanUp.ReferenceOTU0	BR_nombre_244M00842:113:000000000-ABGJC:1:2114:14573:15559	BR_nombre_245M00842:113:000000000-ABGJC:1:2114:14589:15569	BR_nombre_277M00842:113:000000000-ABGJC:1:2114:7718:25486	BR_nombre_273M00842:113:000000000-ABGJC:1:2114:6897:24983	BR_nombre_274M00842:113:000000000-ABGJC:1:2114:6915:24985	BR_nombre_246M00842:113:000000000-ABGJC:1:2114:14576:15580

New.CleanUp.ReferenceOTU1	BR_nombre_202M00842:113:000000000-ABGJC:1:2114:12871:7772	BR_nombre_203M00842:113:000000000-ABGJC:1:2114:12889:7777	BR_nombre_204M00842:113:000000000-ABGJC:1:2114:12873:7792	BR_nombre_1M00842:113:000000000-ABGJC:1:2112:17481:4281	BR_nombre_2M00842:113:000000000-ABGJC:1:2112:17491:4296BR_nombre_3M00842:113:000000000-ABGJC:1:2112:17479:4309

New.CleanUp.ReferenceOTU2	BR_nombre_222M00842:113:000000000-ABGJC:1:2114:5840:12084

New.CleanUp.ReferenceOTU3	BR_nombre_95M00842:113:000000000-ABGJC:1:2113:15220:4270

New.CleanUp.ReferenceOTU4	BR_nombre_152M00842:113:000000000-ABGJC:1:2113:27485:16661

---

__Este método pudo detectar 4 OTUs__
>NOTA: recuerden que estos datos son de chocolate ya que submuestreamos, de datos reales, un archivo con una cantidad de reads muuuuy reducido. Datos reales de microbioma, por ejemplo, tendrían miles de OTUs anotados (si esperas muchos taxones y te salen poquitos, debes revisar tu base de datos)


---


__PREDICCION DE OTUs SIN REFERENCIA (de novo)__

``cd ..``

``pick_de_novo_otus.py -i BR_non_chimeric_header.fasta -o otus_denovo``

``ls``

BR_checked_chimeras.rdp

BR_non_chimeric.fasta

BR_non_chimeric_header.fasta

BR_pear.assembled.fasta

otus_open_reference/

otus_denovo/


``cd otus_denovo/ && ls``

log_20190122235759.txt

otu_table.biom

pynast_aligned_seqs

rep_set

rep_set.tre

uclust_assigned_taxonomy

uclust_picked_otus


``cd uclust_assigned_taxonomy/ && ls``

BR_non_chimeric_header_rep_set_tax_assignments.log  

BR_non_chimeric_header_rep_set_tax_assignments.txt


``less BR_non_chimeric_header_rep_set_tax_assignments.txt``

>denovo0 k__Bacteria; p__Bacteroidetes; c__Sphingobacteriia; o__Sphingobacteriales; f__Sphingobacteriaceae; g__; s__     1.00    3
denovo1 k__Bacteria; p__Proteobacteria; c__Betaproteobacteria; o__Burkholderiales; f__Burkholderiaceae; g__Burkholderia; s__    1.00    3
denovo2 k__Bacteria; p__Proteobacteria; c__Alphaproteobacteria; o__Sphingomonadales; f__Sphingomonadaceae; g__Novosphingobium   0.67    3
denovo3 k__Bacteria; p__Proteobacteria; c__Alphaproteobacteria; o__Rhizobiales; f__Bradyrhizobiaceae; g__Bradyrhizobium; s__    0.67    3
denovo4 k__Bacteria; p__Proteobacteria; c__Alphaproteobacteria; o__Rhizobiales; f__Bartonellaceae; g__Bartonella; s__   1.00    3
denovo5 k__Bacteria; p__Actinobacteria; c__Actinobacteria; o__Actinomycetales; f__Brevibacteriaceae; g__Brevibacterium; s__     1.00    3
denovo6 k__Bacteria; p__Actinobacteria; c__Actinobacteria; o__Actinomycetales; f__Brevibacteriaceae; g__Brevibacterium; s__     1.00    3
denovo7 k__Bacteria; p__Actinobacteria; c__Actinobacteria; o__Actinomycetales; f__Brevibacteriaceae; g__Brevibacterium; s__     0.67    3
denovo12        k__Bacteria; p__Firmicutes; c__Bacilli; o__Lactobacillales; f__Leuconostocaceae; g__; s__       1.00    3
denovo13        k__Bacteria; p__Proteobacteria; c__Alphaproteobacteria; o__Sphingomonadales; f__Sphingomonadaceae; g__Sphingomonas; s__ 0.67    3
denovo10        k__Bacteria; p__Proteobacteria; c__Betaproteobacteria; o__Burkholderiales; f__Oxalobacteraceae; g__; s__        1.00    3
denovo11        k__Bacteria; p__Actinobacteria; c__Actinobacteria; o__Actinomycetales; f__Dietziaceae; g__Dietzia; s__  0.67    3
denovo14        k__Bacteria; p__Bacteroidetes; c__Bacteroidia; o__Bacteroidales; f__S24-7; g__; s__     1.00    3
denovo15        k__Bacteria; p__Actinobacteria; c__Actinobacteria; o__Actinomycetales; f__Dermabacteraceae; g__Brachybacterium; s__     0.67    3
denovo8 k__Bacteria; p__Proteobacteria; c__Betaproteobacteria; o__Burkholderiales; f__Comamonadaceae; g__; s__  0.67    3
denovo9 k__Bacteria; p__Proteobacteria; c__Gammaproteobacteria; o__Pseudomonadales; f__Pseudomonadaceae; g__; s__       0.67    3



para salir de qiime: ``source deactivate``


#### Lecturas sugeridas para pasos posteriores:


Los datos utilizados para el curso, fueron un submuestreo de reads (para acortar el tamaño del archivo) obtenidos [aquí](https://datadryad.org/resource/doi:10.5061/dryad.m3p7d)

[STAMP (Statistical Analysis of Metagenomic Profiles)](http://kiwi.cs.dal.ca/Software/STAMP) - es una herramienta útil que promueve las mejores prácticas al escoger técnicas esdarísticas apropiadas y reportar resultados.

[QIIME](http://qiime.org/1.2.1/tutorials/tutorial.html) también tiene opciones para generar gráficos, normalización de datos y estimaciones de índices de diversidad alfa y beta.
