# Análisis de genoma core y accesorio: clase práctica

Entren al servidor ``ssh`` hasta llegar a la siguiente dirección:

~/Desktop/CURSO_BIOINFO/GENOMICA/6_corepan/get_homologues-x86_64-20190102/

---

Dentro de la carpeta:

``mkdir NOMBRE_gbks``

``cp gbks/* NOMBRE_gbks``

``cd NOMBRE_gbks``

``cp ../../../4_anotacion/NOMBRE_prokka/PROKKA_*.gbf .``

``ls``

---

#### Corramos get_homologues

Corramos el programa con su genoma + referencias como inputs

``./get_homologues.pl -d NOMBRE_gbks -t 0 -G -e``

``./get_homologues.pl -d NOMBRE_gbks -t 0 -M -e``


Entren a su carpeta de outputs recién generada

``cd NOMBRE_gbks_homologues/``


Saquen el pangenoma (genoma core + genoma accesorio)

``./../compare_clusters.pl -o PANGENOMA/ -m -d PROKKA01162019_f0_0taxa_algCOG_e1_,PROKKA01162019_f0_0taxa_algOMCL_e1_ -n``


Entren a carpeta PANGENOMA

``cd PANGENOMA/``

``ls``


Hagan matriz de pangenoma

``./../../parse_pangenome_matrix.pl -m pangenome_matrix_t0.tab -s``

#### Visualización de gráficas y resultados

Abran una terminal en sus computadoras para hacer un scp del pangenoma que generamos

```
scp SERVIDOR:/home/ohta/Desktop/CURSO_BIOINFO/GENOMICA/6_corepan/get_homologues-x86_64-20190102/NOMBRE_gbks_homologues/PANGENOMA/*.pdf .
```

__Veamos los pdfs__

Por último, desde el servidor: Veamos los nombres de genes core (soft-core?) y accesorio (cloud, shell)

``less pangenome_matrix_t0__core_list.txt``


