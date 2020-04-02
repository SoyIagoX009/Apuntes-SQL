# Apuntes de Server Query Language
SQL es un lenguaje de programación declarativo, lanzado en 1986, ha sido regulado por la ANSI, la ultima revisión data de 2016, aunque cada sistema gestor hace la implementación de diferentes maneras. Estos apuntes estan preparados para funcionar con PostgresSQL.

## Indice
- Sintaxis 
   - Enteros
   - Cadenas de texto
   - Colecciones
   - Comentarios
   - Operadores de comparación
      - Mayor que...
	   - Menor que...
	   - Igual que...
	   - Distinto de...
   - Operadores lógicos
      - OR
	   - AND
	   - NOT
	   - Uso combinado
   - Comodines
      - Estrictos
	   - Permisivos
	   - Uso combinado
   - Patrones
   - Subconsultas
   - Fin de la consulta
- DQL - *Data Query Language*
   - SELECT
     - FROM
     - WHERE
     - GROUP BY
     - HAVING
     - ORDER BY
     - LIMIT


## Sintaxis
### Enteros
Los numeros enteros se representan sin utilizar ningun caracter en especial.

```sql
SELECT country
FROM world
WHERE population = 1000000;
```

### Cadenas de texto
Para pasarle al gestor de base de datos una cadena de texto usamos la comilla simple ( `'cadena de texto'`) o las comillas dobles ( `"cadena de texto"`), dependiendo de la situación, **normalmente la comilla a usar es la simple**, pero en algunas situaciones PostgreSQL requiere que se use la comilla doble ya que de lo contrario se devuelve error en la consulta.

***Situación por defecto, la comilla simple funciona:***
```sql
SELECT country
FROM world
WHERE name='Spain';
```
***Situación donde la comilla simple se devolveria como error:***

```sql
SELECT 'hola mundo';
```


### Colecciones
Las colecciones son conjuntos de cadenas de texto independientes, su sintaxis es ```('elemento1','elemento2', 'elemento3', ...)```.
```sql
SELECT country
FROM world
WHERE country IN ('Spain', 'France', 'Portugal');
```
En este ejemplo, usamos la colección *(Spain, France, Portugal)* para que la consulta solo nos devuelva estos de una lista de países.

### Comentarios
Los comentarios son utiles para dejar escritas lineas que seran ignoradas por el sistema gestor.

Para escribir los comentarios, se utilizan dos guiones:

```sql
-- Lorem Ipsum (esta linea se ignora completamente)
SELECT algo --(a partir aquí, la linea se ignora) FROM algunaparte
FROM algunaotraparte;
```
Además, podemos usar los comentarios para hacer copia de seguridad de un codigo que sabemos que funciona, pero que queremos perfeccionar o desactivar por algun determinado motivo. Y claro, tambien puede usarse para explicar como funciona el codigo.

**En SQL, contamos solo con la posibilidad de:**

- Comentar lineas enteras:

```sql
-- Lorem Ipsum (esta linea se ignora)
```

- Comentar a partir de cierta parte de la linea:

```sql
SELECT algo --(a partir aquí, la linea se ignora)
FROM algunaparte;
```

**No contamos con la posibilidad de:**

- Hacer, directamente, párrafos:

```sql
--
Es imposible hacer comentarios al estilo del <!-- -->
que encontramos en HTML, este código dará error.
--
SELECT algo
FROM algunaparte;
-- Esta seria
-- La forma correcta
-- de hacer párrafos
;
```

- Hacer comentarios en medio de la linea:

```sql
SELECT -- este código -- algo
FROM -- no funcionara -- algunaparte;
```

### Operadores de comparación
Estos operadores se utilizan para comparar valores.

#### Operador de Igualdad
En SQL el operador de igualdad es el simbolo de igual *=*

```sql
SELECT name
FROM world
WHERE name='Spain';
```
El operador de igualdad compara un valor al dado y lo devuelve si se cumple la igualdad escricta, en el ejemplo anterior, cuando el valor de name es igual al de la cadena de texto que proporcionamos, se lista el elemento.

#### Operador "menor que"
En SQL el operador de menor que es el simbolo de menor que (*<* ):

```sql
SELECT name
FROM world
WHERE population < 1000;
```

El operador de mayor que compara el un valor al dado, y lo de vuelve si esta en el rango proporcionado. El ejemplo anterior devuelve todos los paises con una población inferior a 1000 habitantes.

##### Menor o igual que

El operador *<* no nos devolveria la población de un pais cuyo valor fuese 1000, para ello tendriamos que usar *<=*, menor o igual que.

Es importante recordar que *<=* es la unica forma de correcta de expresar menor o igual que, usando un solo operador.

#### Operador "mayor que"
En SQL el operador de menor que es simbolo de mayor que (*>* ):

```sql
SELECT name
FROM world
WHERE population > 1000;
```

El operador de mayor que compara el un valor al dado, y lo de vuelve si esta en el rango proporcionado. El ejemplo anterior devuelve todos los paises con una población superior a 1000 habitantes.

##### Mayor o igual que

El operador *>* no nos devolveria la población de un pais cuyo valor fuese 1000, para ello tendriamos que usar *>=*, mayor o igual que.

Igual que ocurre con menor o igual que, *>=* es la unica forma de correcta de expresar mayor o igual que, usando un solo operador.

### Operadores logicos
SQL dispone de los siguientes operadores logicos.

#### OR
*OR* devuelve la información cuando **alguno** de los elementos dados al *OR* es True.

Podemos usar OR para devolver todos los paises de Africa y, además, añadir a España.

```sql
SELECT name
FROM world
WHERE continent='Africa' OR name='Spain';
```
#### AND
*AND* devuelve la información cuando **todos** de los elementos dados al *AND* son True.

Podemos devolver asi todos los paises de Europa cuyo nombre es España.

```sql
SELECT name
FROM world
WHERE continent='Europe' AND name='Spain';
```
#### NOT
*NOT* devulve la información cuando el/los elementos dados al *NOT* son False.

Podemos usar *NOT* para devolver todos los paises cuyo nombre no sea España.

```sql
SELECT name
FROM world
WHERE NOT name='Spain';
```

#### OR, AND y NOT
Podemos usar todos los operadores logicos a la vez, y si lo quisiesemos, construir otros operadores logicos como XOR, NAND, etc...

En este ejemplo se listan todos los paises de Africa y Europa que no sean Francia.

```sql
SELECT name
FROM world
WHERE continent='Africa' OR continent='Europe' AND NOT name='France';
```

#### Comodines
SQL cuenta con dos comodines para cadenas de texto:

##### Comodin escricto
El comodin "_" sirve para filtrar cadenas de texto en las que exista un caracter en la misma  posición en la que se encuentra el comodin y que tengan la misma longitud, es un comodin escrito.

```sql
SELECT name
FROM world
WHERE name LIKE 'S____';
```
Esta consulta devuelve todos los paises que se contengan una *S* al principio y da libertad a los siguientes cuatro caracteres, pero requiere que estos existan.

name |
-|
Samoa |
Spain |
Sudan |
Syria |

##### Comodin permisivo
El comodin "%" filtra cadenas de texto en las que da igual que exista o no un caracter o caracteres en la misma posición, es un comodin no estricto.

```sql
SELECT name
FROM world
WHERE name LIKE 'F%';
```
Esta consulta devuelve todos los paises que se contengan F de primer caracter, pero da libertad a la longitud de la cadena de texto, por lo tanto se listan todos los paises que tengan una F al principio de su nombre

name |
-|
Fiji |
Finland |
France |

##### Uso combinado
Los dos comodines se pueden usar a la vez sin ningún tipo de problema.

```sql
SELECT name
FROM world
WHERE name LIKE '_c_%';
```
Esta consulta devuelve todos los paises que se contengan una *p* de segundo caracter, requiere que exista un tercer caracter, y luego, da libertad a la longitud de la cadena.

name |
-|
Iceland |
Ecuador |

### Patrones
Los patrones funcionan de forma similar a los comodines, pero nos permiten hacer una criba más concreta.


### Subconsultas
En SQL es posible realizar consultas dentro de consultas, para ello se hace uso de los paréntesis `(` `)`, la finalidad es tener un mayor control sobre la información.

```sql
SELECT name, population
FROM world
WHERE population > (
             SELECT population 
             FROM world 
             WHERE name="India"
);
```
La parte de la consulta que se encuentra dentro del paréntesis, en este ejemplo, permite obtener la población de la India, y, luego, lista los paises del mundo con más población que la India, esto no seria posible sin hacer uso de la subconsulta.

name | population
-| -
China | 1365370000

### Fin de la consulta
En SQL es necesario declarar donde acaba nuestra consulta, para ello se usa el punto y coma.

> Aunque algunos sofwares como SQL pueden ser permisivos y no necesitar el `;` para realizar la consulta, es un buena practica hacer uso del punto y coma igualmente.

```sql
SELECT name
FROM world;
```

## SQL - Data Query Language
Las instrucciones DQL se utilizan para devolver la información contenida en la base de datos sobre la que estamos trabajando.

### SELECT
`SELECT` se trata de la instrucción de la que depende todo SQL-DQL, usando `SELECT` junto a las clausulas documentadas a continuación podemos devolver la información que tenemos contenida en la base de datos.

```sql
SELECT 'hola mundo'
;
```

Si no usamos ninguna clausula adicional, `SELECT` no puede hacer mucho más que mostrar la misma información que le pasamos:

```sql
SELECT * | <[<tabla>.]columna1> [AS <string>], <[<tabla>.]columna2> [AS <string>], <[<tabla>.]columna3> [AS <string>], ...
   FROM <tabla1>, <tabla2>, <tabla3>, ...
   WHERE (condición)
   GROUP BY <[<tabla>.]columna>
   HAVING (condicion)
   ORDER BY <[<tabla>.]columna> [(ASC) | DESC]
   LIMIT <integer>
   OFFSET <integer>
;
```

?column?  |
----------| 
hola mundo|


...o resolver operaciones matemáticas:

```sql
SELECT 9*9;
```

?column?|
--------| 
81      |

#### FROM
`FROM` es una clausula que nos permite especificar las columnas de las que `SELECT` tiene que leer información.

```sql
SELECT * | <[<tabla>.]columna1> [AS <string>], <[<tabla>.]columna2> [AS <string>], <[<tabla>.]columna3> [AS <string>], ...
FROM <tabla1>, <tabla2>, <tabla3>, ...
;
```
Como mínimo, tendremos que especificar una columna y una tabla para que la consulta funcione.

```sql
SELECT tabla
FROM columna;
```

Para ayudarnos a entender nuestro propio codigo, y para facilitar su lectura a terceros, también podemos especificar ya en el propio ```SELECT``` el nombre de la tabla a la que estamos solicitando la información de cada columna.

```sql
SELECT tabla.columna
FROM tabla;
```

> En esta situación, de por si, se hace obvio que queremos la *columna* de la *tabla*, ya que solo estamos consultando dicha tabla en el ```FROM```, es en consultas más complejas donde se ve la utilidad de esta función.

Podemos además cambiar el nombre de las columnas en el resultado de la consulta usando la clausula ```AS``` seguida del valor de cadena (*string*), que queramos.

```sql
SELECT tabla.columna AS "Un nombre personalizado"
FROM tabla;
```

>
> **Ejemplo**
> ***Listando todos los paises del mundo***.
>
> *Podemos usar `FROM` para que `SELECT` devuelva la lista de todos los paises del mundo*.
>
> ```sql
> SELECT world.country AS "Países"
> FROM world;
> ```
> Países     | 
> -----------|
> Afganistan |
> Albania    |
> Algeria    |
>

También tenemos la posibilidad de devolver todos los elementos de la tabla sin tener conocimiento previo de ninguno de ellos, esto es util, principalmente, para saber que es lo que tenemos en la tabla y poder hacer un codigo más complejo, si en alguna situación hacemos uso de `SELECT *` y luego se implementa en la base de datos una nueva columna, esta comenzaría a aparecer, si hacemos uso de un SELECT `SELECT` con columnas concretas eso no ocurriría.

```sql
SELECT *
FROM tabla;
```
>
> **Ejemplo**
> ***Mostrando toda la tabla world***.
>
> *Usaremos `SELECT *` para listar todas las columnas y contenido de la tabla mundo*.
>
> ```sql
> SELECT *
> FROM world
> ```
> country    | capital | continent | area     | population  | gdp
> -----------|---------|-----------|----------|-------------|-------
> Afganistan | Kabul   | Asia      | 31056997 | 647500      | 21740
> Albania    | Tirana  | Europe    | 3581655  | 28748       | 16117
> Algeria    | Argel   | Africa    | 32930091 | 2381740     | 197581
> ...        |
>

#### WHERE

La clausula `WHERE` nos permite cribar la información que lee `SELECT` para que la consulta solo devuelva una serie de elementos que sean acordes al criterio establecido; para esto podemos apoyarnos en toda la sintaxis de SQL (tratada con anterioridad en este documento).

```sql
WHERE (condicion)
```
>
> **Ejemplo**
> ***Listando los paises que coincidan con Spain, Portugal y France***.
>
> *Podemos usar `GROUP BY` para mostrar una lista de los continentes junto al numero de paises que estos contienen*.
>
> ```sql
> SELECT world.country AS "Países"
> FROM world
> WHERE name IN ('España', 'Portugal', 'Francia');
> ```
> Países     | 
> -----------|
> España     |
> Francia    |
> Portugal   |
>

#### GROUP BY

Con `GROUP BY` podemos agrupar todas las tuplas que se nos devuelve en la consulta en referencia a una determinada columna, que, por pura lógica, sabemos que tiene el mismo valor en varias tuplas.

```sql
GROUP BY <[<tabla>.]columna>
```

>
> **Ejemplo**
> ***Listando cuantos paises hay por continente***.
>
> *Podemos usar `GROUP BY` para mostrar una lista de los continentes junto al numero de paises que estos contienen*.
>
> ```sql
> SELECT COUNT(world.country) AS "Nº Países", world.continent AS "Continente"
> FROM world
> GROUP BY world.continent;
> ```
> Nº Paises | Continente
> ----------|------------
> 55        | Africa
> 54        | Asia
> 45        | America
> 43        | Europe
>

#### HAVING
`HAVING` funciona de forma similar a `WHERE`, pero, mientras que **`WHERE` actuá individualmente sobre cada tupla, `HAVING` actuá sobre grupos de tuplas**, aplicando condiciones sobre estos grupos, usando toda la sintaxis de SQL.

```sql
HAVING (condicion)
```
>
> **Ejemplo**
> ***Listando los continentes con más de 40 paises***
> 
> *Podemos usar `GROUP BY` junto a un `HAVING` para sacar una lista de todos los continentes con más de 40 paises (eliminando así de la lista a Oceania).*
>
> ```sql
> SELECT COUNT(world.country) AS "Nº Países", world.continent AS "Continente"
> FROM world
> GROUP BY world.continent
> HAVING COUNT(world.continent) > 40;
> ```
> Nº Paises | Continente
> ----------|------------
> 55        | Africa
> 54        | Asia
> 45        | America
> 43        | Europe
>

#### ORDER BY

Con `ORDER BY` podemos ordenar todos los elementos devueltos por la consulta en base a un criterio de ascendente (por defecto) o descendente.

```sql
ORDER BY <[<tabla>.]columna> [(ASC) | DESC]
```
>
> **Ejemplo**
> ***Listando los paises que coincidan con Spain, Portugal y France, en orden alfabético inverso***.
>
> *Podemos usar `ORDER BY <columna> DESC` para mostrar los resultados en orden alfabético inverso*.
>
> ```sql
> SELECT world.country AS "Países"
> FROM world
> WHERE world.country IN ('Spain', 'Portugal', 'France')
> ORDER BY world.country DESC;
> ```
> Países     | 
> -----------|
> Spain      |
> Portugal   |
> France     |
>

#### LIMIT y OFFSET

Usando `LIMIT` podemos controlar cuantas tuplas se devuelven como resultado de una consulta.

`OFFSET` nos permitirá saltarnos una cantidad de elementos de la consulta, empezando a contar desde lo que debería ser la primera tupla.

Tanto `OFFSET` como `LIMIT` tienen la misma sintaxis, pueden usarse independientemente o en conjunto.

```sql
LIMIT <integer>
OFFSET <integer>
```
> **Ejemplo**
> ***Listando cinco paises en orden alfabético inverso, saltándose los cinco primeros.***
> 
> *Podemos usar `GROUP BY` junto a un `HAVING` para sacar una lista de todos los continentes con más de 40 paises (eliminando así de la lista a Oceania).*
>```sql
>SELECT world.country AS "Países"
>FROM world
>ORDER BY world.country DESC
>LIMIT 5
>OFFSET 5;
> ```
> Países         | 
> ---------------|
> Vanuatu        |
> Uzbekistan     |
> Uruguay        |
> United States  |
> United Kingdom |