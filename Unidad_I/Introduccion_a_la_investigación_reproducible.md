
# 1. Introducción a la investigación reproducible

## 1.1. Biología y computadoras:

__Biología Computacional:__ estudio de la biología utilizando cómputo. Su objetivo es generar conocimiento biológico, utilizando herramientas computacionales y código generado por alguien más para contestar tus preguntas.

__Bioinformática:__ creación de herramientas (algoritmos, software) para solucionar problemas puntuales con datos biológicos. Uno puede generar sus propias herramientas para contestar preguntas específicas de interés. Lo ideal es hacer disponible el código para que otra persona pueda contestar esa misma pregunta con sus datos.

__Investigación:__ La mayoría de la investigación que se publica recientemente utilizó una mezcla de los programas de alguien más (sobretodo en los primeros pasos del procesamiento de datos) y funciones propias para realizar análisis más específicos. Aunque la Biología Computacional y la Bioinformática no son lo mismo, tienen mucho en común y se apreden juntas.

Para realizar "análisis bioinformáticos" se necesitan, implícitamente, ambas de disciplinas. En realidad, la bioinformática implica la unión de varias disciplinas (no sólo la biología y la computación, sino también a las matemáticas y la estadística).

![alt_text](https://github.com/Mariette-VJ/Introduccion_a_la_Bioinformatica/blob/master/Unidad_I/images/boinformatics_tools_needed.png)

_Figura 1. Interdisciplinas de la bioinformática._

---
#### __Desafíos de la bioinformática__

• Grandes volúmenes de información.

• Bases de datos heterogéneas y dispersas.

• Diferentes estándares tecnológicos.

• Búsquedas extendidas y complejas.

• Gráficas avanzadas en 2D y 3D.

• Colaboración de equipos de investigadores interdisciplinarios.

• Formación de código nuevo (formación de bioinformáticos que aporten a la resolución de problemas).

---

#### __Mayor ventaja de la bioinformática: Investigación reproducible__

Que dos personas hagan el mismo experimiento y obtengan el mismo resultado es parte del corazón mismo de la ciencia. La reproducibilidad valida el reservorio de conocimiento nuevo y permite usar las conclusiones como punto de partida para preguntas nuevas.

Hacer investigación reproducible es poder repetir y obtener los mismos resultados de un trabajo científico. Para esto es necesario que el producto de la investigación incluya:

 1. Artículo científico o tesis
 2. Descripción de materiales y métodos
 3. Datos utilizados
 4. Código de cómputo utilizado
 5. Versión del software utilizado
 6. Cualquier otra información necesaria para repetir los experimentos y análisis

---

Al trabajar con código libre para todos y fácilmente descargable del internet a tu ordenador personal para uso particular, repetir los pasos de procesamiento vuelve a la biología computacional en algo bastante accesible para la mayoría de las personas (simplemente se necesita de una computadora y datos para empezar a trabajar) _pero ¿por qué eso es tan impresionante?_

Tener un protocolo de pasos a seguir que te permitan llegar siempre al mismo resultado no es algo tan común en la ciencia hoy en día:

## 1.2.1. La crisis de reproducibilidad

__El enemigo más grande:__ Muchos autores no quieren hacer público sus códigos y/o sus datos después de la primera publicación por miedo a que otro investigador les gane el crédito en las siguientes publicaciones con los mismos datos o datos muy similares (quieren mayor crédito).

__El origen del problema:__ En el ámbito científico, la cantidad de artículos publicados es una prioridad sobre la calidad de los mismos. El famoso "cuchareo" de los datos o "elegir voluntariamente" ignorar ciertos datos se veía incentivado por los reconocimientos otorgados a quien publique más artículos en un año.

---
Lecturas recomentadas al respecto:

[When quality beats quantity](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0147215)
[Is there a reproducibility crisis?](http://go.galegroup.com/ps/anonymous?id=GALE%7CA454730385&sid=googleScholar&v=2.1&it=r&linkaccess=abs&issn=00280836&p=AONE&sw=w)
[Tackling reproducibility in academic preclinical drug discovery](https://www.nature.com/articles/nrd4737)
[The reproducibility crisis in science: A statistical counterattack](https://rss.onlinelibrary.wiley.com/doi/full/10.1111/j.1740-9713.2015.00827.x)
[The science reproducibility crisis and what can be done about it](https://theconversation.com/the-science-reproducibility-crisis-and-what-can-be-done-about-it-74198)

La crisis de resultados no reproducibles en la ciencia no sólo representan una pérdida de esfuerzo de investigación y dinero, sino que puede llevar a "perseguir" explicaciones erroneas e incluso desarrolar tratamientos médicos que no funcionan. Por ejemplo el [Reproducibility Project: Cancer Biology](https://elifesciences.org/collections/9b1e83d1/reproducibility-project-cancer-biology) ha encontrado que artículos claves para el desarrollo de nuevos tratamientos contra el cáncer no son reproducibles.

---

__Las medidas de prevención de las revistas:__ Dado a lo antes mencionado, las revistas científicas han tomado cartas en el asunto y hoy en día es casi un requisito indispensable que, junto con tus resultados, incluyas como información suplementaria una liga de descarga de tus datos originales, junto con el pipeline y hasta el código con el que procesaste la información.

Quotes de revistas científicas:

>_"The __editors at Science have adjusted practices based on these policies and have gained experience with many of these issues__. We fully support the principles behind these guidelines, including the centrality and benefits of transparency, as captured in our editorial principle that “all data and materials necessary to understand, assess, and extend the conclusions of the manuscript must be available to any reader”_

>_"Over the past year, we have __retracted three papers__ previously published in __Science__. The circumstances of these retractions __highlight some of the challenges connected to reproducibility policies__. In one case, the authors failed to comply with an agreement to post the data underlying their study. Subsequent investigations concluded that __one of the authors did not conduct the experiments as described and fabricated data.__"_


## 1.2.3 La reproducibilidad en la bioinformática

Empezando desde dónde descargar los datos biológicos

#### __Repositorios de datos especializados en datos genéticos:__


• [NCBI Gene Bank](www.ncbi.nlm.nih.gov/genbank/). Banco de datos genéticos desde la secuenciación Sanger.

• [NCBI Sequence Read Archive (SRA)](www.ncbi.nlm.nih.gov/sra). Rama de NCBI dedicada a datos de secuenciación masiva.

• [UCSC Genome Browser](https://genome.ucsc.edu/). Repositorio de genomas.

• [BOLD](www.boldsystems.org). Dedicado a datos del "barcode de la vida".

• [MG-RAST](https://www.mg-rast.org/). Datos metagenómicos.

• Y varios más


Siguiendo por dónde encontrar los protocolos de procesamiento de los datos


#### Código de procesamiento de datos

1. El código es el conjunto de comandos que ejecutamos, en el órden exacto: _Lo mismo que escribiríamos en la Terminal para hacer un análisis, pero guardado en un archivo de texto (NO WORD!) ejecutable (también llamado script) que tiene todos los comandos juntos y que podemos abrir para repetir o compartir el análisis con amigos y que también lo puedan ejecutar_.

2. Los códigos deben tener comentarios escritos en un lenguaje de humano que explique a los comandos por pasos concretos. _Comentar en un archivo de texto que puede ser ejecutado siempre se realiza con "#" y permite al lector entender sin necesidad de hablar lenguaje computadora, qué es lo que hacen los comandos_

Ejemplo:

``# Con este comando haré que mi terminal salude al mundo``

``echo "Hello World!"``

Un código abierto al público es de gran utilidad para acelerar y mejorar el procesamiento de datos, ya que gente experimentada en todo el mundo puede mejorar tu código y a la vez, puede ser usado por gente no experimentada en todo el mundo. [Openness makes software better sooner](https://www.nature.com/news/2003/030623/full/news030623-6.html)

__Excusas comunes para no compartir nuestro código__

* Me da pena que vean mi código
* No quiero que otros saquen provecho de mi código
* Me da flojera pulir mi código para publicarlo
* Si publico mi código le van a encontrar errores y demandar correcciones o ayuda

Si cualquiera de estas respuestas te parecen razones válidas, checa esta lectura recomendada: [Publish your computer code: it is good enough](https://www.nature.com/news/2010/101013/full/467753a.html).

__¿Cómo compartir código?__

• En scripts comentados y con un README
• En un repositorio de código como:

__Dryad__ (como parte del repositorio de datos)  y  __GitHub__ (mejor para funciones, programas y proyectos que continuarán actualizándose).


#### Dryad

[Dryad Digital Repository](http://datadryad.org/) es un repositorio de datos digitales de cualquier tipo siempre y cuando sean parte de una publicación científica (biología, medicina, física, química, etc).

Acepta cualquier archivo digital que sea necesario para repetir una investigación: _archivos excel, scripts, alineamientos de secuencias de ADN, datos semi-crudos, etc_.  Muchas revistas científicas piden como requisito que los datos estén en Dryad además de en NCBI o símil.


Checa otros repositorios de datos [aquí](http://ropensci.github.io/reproducibility-guide/sections/dataStorage/).

#### GitHub

Es un repositorio de código que utiliza git para llevar un sistema de control de versiones, tiene una interfase Web pública, permite escribir/revisar código en equipo (también a través de git) y su símbolo es un gatopulpo (muy hermoso):

![alt text](https://github.com/Mariette-VJ/Introduccion_a_la_Bioinformatica/blob/master/Unidad_I/images/Octocat.png)


#### Artículos de datos

Son artículos enfocados en describir un _set de datos_, incluyendo todos los aspectos técnicos y formatos para que puedan ser fácilmente reutilizados.

Ejemplos:

[Scientific data](https://www.nature.com/sdata/about/principles)

[Data Report en Frontiers](https://www.frontiersin.org/journals/genetics#article-types)

[Genomics Data](https://www.journals.elsevier.com/genomics-data/)


En teoría, con estos libros abiertos a las bitácoras de trabajo, uno fácilmente podría llegar a los mismos resultados que los autores de todos los artículos.

¿Y si tú eres quien debe publicar ahora?

#### __Manual de buena conducta:__

>_" __Good practices:__ _
>
>_1. Data should be archived in an appropriate public archive, such as __GenBank, Gene Expression Omnibus, TreeBASE, Dryad, FigShare, the Knowledge Network for Biocomplexity, your own institutional or funder repository, or as Supporting Information on the Molecular Ecology web site__._
>
>_2. The utility of archived data is greatly enhanced when the scripts and input files used in the analyses are also made available._
>
>_3. Given that scripts may be a mix of proprietary and freely available code, their deposition is not compulsory, but __we__ nonetheless __strongly encourage authors to make these scripts available whenever possible__._
>
>_4. __Software and documentation may be made accessible from a long-term server (github), however, at least a snapshot of these resources must be posted on Dryad, CRAN__ (or similar academic/publishing archiving sites) with a link to a long-term server where software development and future releases can be found such that continued access to these resources is ensured."_


### 1.3. Contenedores

__Retos al reproducir pipelines de trabajos con tus propios datos:__ Los pipelines (_la secuencia de pasos generales para llegar a un resultado final_) de trabajo bioinformáticos ocupan muchos programas distintos que constantemente están renovándose y actualizándose. La probabilidad de que tengamos una versión de de programa distinta a la que corrieron los autores originales de un  artículo es muy alta, por lo que también es importante documentar la versión de los programas al usarlos.

Para poder utilizar estos programas de _código abierto_, se necesita de un software especializado como el de GNU/Linux, lo cuál puede no ser algo trivial de instalar (_tal vez ustedes ya puedan compartirse anécdotas chistosas al respecto_). Además, al instalar un programa bioinformático es común "romper" las dependencias de otro programa o incluso tu sistema operativo.

![alt_text](images/no_bugs.png)

_Ver más sobre cómo funciona el sistema de jerarquía de carpetas en Linux [aquí](https://www.linux.com/blog/learn/intro-to-linux/2018/4/linux-filesystem-explained)_

Por eso, tener que hacer una actualización o reinstalación representa estrés en los alumnos. Una solución a esto puede ser el uso de __contenedores de software__. Un contenedor de software es una versión de un software (por ejemplo Linux) reducida a sus componentes más básicos y disponible para ser almacenada en un servidor público al cuál tienes acceso desde tu terminal.

Ejemplos de contenedores:

[Docker](https://docs.docker.com/)

![alt_text](https://github.com/Mariette-VJ/Introduccion_a_la_Bioinformatica/blob/master/Unidad_I/images/docker.png)


[Kubernetes](https://kubernetes.io/)

La documentación de Kubernetes menciona [las ventajas de usar contenedores](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/#why-containers)



### 1.4. ¿Cómo buscar ayuda?

El objetivo de esta clase no es darte un manual completo para resolver cualquier cuestión bioinformática, sino darte las _habilidades y herramientas_ para que llegues por tí mismo a las soluciones. Para esto hay una habilidad indispensable: buscar ayuda en internet. La enorme mayoría de las preguntas que te hagas sobre bioinformática y programación en general, sobre todo al principio, son las mismas dudas que tuvieron otros antes y, casi seguro las respuestas ya están en algún lugar del internet. Y si nadie ha tenido la misma duda, puedes preguntar.

Aprender a buscar soluciones en internet está perfectamente bien y es muy distinto a "copiar en un examen". Saber buscar ayuda e información en interent es una habilidad básica del siglo XXI.

![alt_text](https://github.com/Mariette-VJ/Introduccion_a_la_Bioinformatica/blob/master/Unidad_I/images/ask4help.jpg)


Sitios de ayuda especializada:

__[Stacksoverflow](https://stackoverflow.com/):__ es un foro de ayuda para programación en general, viene dividido por lenguajes. La gente hace preguntas y contesta. Es como un yahoo answers super pro, lxs programadorxs con muchas preguntas respondidas ganan puntos que son algo muy visible para un CV con ese perfil. Este foro es mejor para dudas de bash, R, python y no de programas genéticos.

__[Biostars](https://www.biostars.org/)__ es parecido a Stacksoverflow un foro de ayuda especializado en Bioinformática. Aquí sí puedes hacer preguntas enfocadas en datos y software genético, por ejemplo cómo mover de un formato de genomas a otro.

__Grupos de usuarios de un software.__ Por ejemplo [este de Stacks](https://groups.google.com/forum/#!forum/stacks-users). Son ideales para aclarar detalles específicos y mensajes de error de ese software (una recomendación al preguntar sería copiar el mensaje de error que aparezca en la terminal y agregarlo a tu pregunta, tras haber especificado el tipo de datos que estás procesando).

La comunidad de usuarios y creadores de programas son, en general, muy accesibles y muchas veces hasta el autor del programa es el que te contacta y te contesta a detalle.



__Tips sobre cómo pedir/buscar ayuda__

1. Busca en inglés

2. Piensa bien cuáles son las palabras clave de tu pregunta y cómo generalizar tu caso a algo que cualquiera en cualquier lado del mundo entendería. O sea que es mejor evitar preguntar de problemas muy particulares a tus datos o incluso tu computadora, por ejemplo: _"__How to list files in a directory using bash?__"_ es mucho mejor mejor que _"__How to see all files in Playita__"_ (tu y yo sabemos que Playita es un directorio en tu computadora que hiciste para guardar las fotos de tus vacaciones en la playa, pero el resto del mundo no lo sabrá).

3. Si vas a pedir ayuda en un foro, lee las reglas y tipo de preguntas atentidas por el foro antes de preguntar.

4. Sigue estas recomendaciones de Stacksoverflow sobre [cómo redactar una buena pregunta]( https://stackoverflow.com/help/how-to-ask)

5. Si recibes un mensaje de error en la Terminal, R, etc usando un comando o un programa basal o muy conocido, copia y pega el mensaje a tu motor de búsqueda favorito (tal vez seguido del nombre del programa, en caso de ser un error de programa).








