# Apuntes de Server Query Language
SQL es un lenguaje de programación declarativo, lanzado en 1986, ha sido regulado por la ANSI, la ultima revisión data de 2016, aunque cada sistema gestor hace la implementación de diferentes maneras. Estos apuntes están preparados para funcionar con Postgres.

## Indice
- [Sintaxis](#sintaxis)
   - [Enteros](#enteros)
   - [Cadenas de texto](#cadenas-de-texto)
   - [Colecciones (IN)](#colecciones-in)
   - [Comentarios](#comentarios)
   - [Operadores](#operadores)
      - [Operadores matemáticos](#operadores-matemáticos)
      - [Operadores lógicos](#operadores-lógicos)
   - [Patrones (LIKE)](#patrones-like)
   - [Expresiones regulares (SIMILAR TO)](##expresiones-regulares-similar-to)
   - [Subconsultas](#subconsultas)
   - [Condiciones (CONSTRAINT)](#condiciones-constraint)
   - [Fin de la consulta](#fin-de-la-consulta)
- [SQL - *Data Manipulation Language*](#sql---data-manipulation-language)
   - [SELECT](#select)
     - [FROM](#from)
     - [WHERE](#where)
     - [GROUP BY](#group-by)
     - [HAVING](#having)
     - [ORDER BY](#order-by)
     - [LIMIT](#limit)
   - [INSERT](#insert)
   - [UPDATE](#update)
   - [DELETE FROM](#delete-from)
   - [TRUNCATE](#truncate)
- [SQL - *Data Definition Language*](#sql---data-definition-language)
   - [DATABASE](#database)
   - [SCHEMA](#schema)
   - [USER](#user)
   - [DOMAIN](#domain)
   - [TABLE](#table)


## Sintaxis
### Enteros
Los números enteros se representan sin utilizar ningún carácter en especial.

```sql
SELECT country
FROM world
WHERE population = 1000000;
```

---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---
*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*
---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---

### Cadenas de texto
Para pasar al gestor de base de datos una cadena de texto usamos la comillas simple ( `'cadena de texto'`) o las comillas dobles ( `"cadena de texto"`), dependiendo de la situación, **normalmente la comilla a usar es la simple**, pero en algunas situaciones PostgreSQL requiere que se use la comillas doble ya que de lo contrario se devuelve error en la consulta.

***Situación por defecto, la comilla simple funciona:***
```sql
SELECT country
FROM world
WHERE country='Spain';
```
***Situación donde la comilla simple se devolvería como error:***

```sql
SELECT 'hola mundo';
```

---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---

### Colecciones (IN)
Las colecciones son conjuntos de cadenas de texto independientes, su sintaxis es ```('elemento1','elemento2', 'elemento3', ...)```.
```sql
SELECT country
FROM world
WHERE country IN ('Spain', 'France', 'Portugal');
```
En este ejemplo, usamos la colección *(Spain, France, Portugal)* para que la consulta solo nos devuelva estos de una lista de países.

---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---

### Comentarios
Los comentarios son utiles para dejar escritas lineas que seran ignoradas por el sistema gestor.

Para escribir los comentarios, se utilizan dos guiones:

```sql
-- Lorem Ipsum (esta linea se ignora completamente)
SELECT algo --(a partir aquí, la linea se ignora) FROM algunaparte
FROM algunaotraparte;
```
Además, podemos usar los comentarios para hacer copia de seguridad de un código que sabemos que funciona, pero que queremos perfeccionar o desactivar por algún determinado motivo. Y claro, también puede usarse para explicar como funciona el código.

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
---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---

### Operadores
SQL soporta el uso de operadores lógicos y de operadores matemáticos para tratar datos.

#### Operadores matemáticos
Estos son los operadores matemáticos soportados por SQL:

 Operador | Uso
 ---------|------
 \+       | Suma
 \-       | Resta
 =        | Comparación
 <        | Menor que...
 <=       | Menor o igual que
 \>       | Mayor
 \>=      | Mayor o igual que
 /        | División
 ^        | Potencia

#### Operadores lógicos
SQL soporta los siguiente operadores lógicos:

##### OR
```OR``` devuelve la información cuando **alguno** de los elementos dados al *OR* es True.

Podemos usar ```OR``` para devolver todos los países de Africa y, además, añadir a España.

```sql
SELECT country
FROM world
WHERE continent='Africa' OR country='Spain';
```

##### AND
```AND``` devuelve la información cuando **todos** de los elementos dados al ```AND``` son ```True```.


Podemos devolver asi todos los países de Europa cuyo nombre es España.

```sql
SELECT country
FROM world
WHERE continent='Europe' AND country='Spain';
```

##### NOT
```NOT``` devuelve la información cuando el/los elementos dados al ```NOT``` son ```False```.

Podemos usar ```NOT``` para devolver todos los países cuyo nombre no sea España.

```sql
SELECT country
FROM world
WHERE NOT country='Spain';
```

##### OR, AND y NOT
Podemos usar todos los operadores lógicos a la vez, y si lo quisiésemos, construir otros operadores lógicos como ```XOR```, ```NAND```, etc...

*En este ejemplo se listan todos los países de Africa y Europa que no sean Francia.*

```sql
SELECT country
FROM world
WHERE continent='Africa' OR continent='Europe' AND NOT country='France';
```
---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---

#### Patrones (LIKE)
SQL cuenta con la posibilidad de comprar valores con patrones, para ello se utiliza la instrucción ```LIKE```.

##### Patron escricto
El patron ```_``` sirve para filtrar cadenas de texto en las que exista un caracter en la misma  posición en la que se encuentra el patron y que tengan la misma longitud, es un patron escrito.

```sql
SELECT country
FROM world
WHERE country LIKE 'S____';
```
Esta consulta devuelve todos los países que se contengan una *S* al principio y da libertad a los siguientes cuatro caracteres, pero requiere que estos existan.

country |
-|
Samoa |
Spain |
Sudan |
Syria |

##### Patron permisivo
El comodín ```%``` filtra cadenas de texto en las que da igual que exista o no un carácter o caracteres en la misma posición, es un comodín no estricto.

```sql
SELECT country
FROM world
WHERE country LIKE 'F%';
```
Esta consulta devuelve todos los países que se contengan F de primer carácter, pero da libertad a la longitud de la cadena de texto, por lo tanto se listan todos los países que tengan una F al principio de su nombre

country |
-|
Fiji |
Finland |
France |

##### Uso combinado
Los dos patrones se pueden usar a la vez sin ningún tipo de problema.

```sql
SELECT country
FROM world
WHERE country LIKE '_c_%';
```
Esta consulta devuelve todos los países que se contengan una *p* de segundo carácter, requiere que exista un tercer carácter, y luego, da libertad a la longitud de la cadena.

country |
-|
Iceland |
Ecuador |
---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---

### Expresiones regulares (SIMILAR TO)
Los patrones funcionan de forma similar a los patrones, pero nos permiten hacer una criba más concreta.

Para comprobar un dato con una expresión regular se utiliza ```SIMILAR TO <expresion-regular>```.

Expresión | Significado
----------|------------
   Pleca  | Opción entre alternativas
   %      | Uno o ningún elemento
   \*     | Repetición del elemento anterior **cero o más veces**
   \+     | Repetición del elemento anterior **una o más veces**
   ?      | Repetición del elemento anterior **una o ninguna vez**
   {n}    | Repetición del elemento anterior ***n* veces**
   {n,}   | Repetición del elemento anterior ***n* o más veces**
   {n,m}  | Repetición del elemento anterior ***n* y no más de *m* veces**
   (...)  | Un elemento, definido dentro de los paréntesis.
 \[...\]  | [Expresión POSIX](https://en.wikipedia.org/wiki/Regular_expression#Character_classes), definida dentro de los corchetes.
---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---
### Subconsultas
En SQL en determinadas situaciones es posible o necesario realizar consultas dentro de consultas, para ello se hace uso de los paréntesis `(` `)`, la finalidad es tener un mayor control sobre la información.

```sql
SELECT country, population
FROM world
WHERE population > (
             SELECT population 
             FROM world 
             WHERE country="India"
);
```
La parte de la consulta que se encuentra dentro del paréntesis, en este ejemplo, permite obtener la población de la India, y, luego, lista los países del mundo con más población que la India, esto no seria posible sin hacer uso de la subconsulta.

country | population
-| -
China | 1365370000
---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---
### Condiciones (CONSTRAINT)
Un ```CONSTRAINT``` es una condición que debe cumplir la entrada de datos para poder ser aceptada por la base de datos.

#### CHECK
El ```CONSTRAINT``` ```CHECK``` nos permite definir un ```CONSTRAINT``` que cumpla los valores que nosotros deseemos.

```sql
<columna> <tipo-de-datos> CHECK (condiciones para VALUE)
```

Dentro del ```CHECK``` usamos la *variable* ```VALUE``` para leer el valor que se esta intentando asignar al elemento sobre el que estamos realizando el ```CHECK```.

> No se pueden hacer subconsultas dentro del ```CHECK```.

#### UNIQUE
El ```CONSTRAINT``` ```UNIQUE``` tiene la función de garantizar la no repetición de un determinado valor dentro de la misma columna de la tabla.

```sql
<columna> <tipo-de-datos> UNIQUE
```

#### NOT NULL
Este ```CONSTRAINT``` impide que los valores introducidas puedan tener el valor ```NULL```

```sql
<columna> <tipo-de-datos> NOT NULL
```

#### PRIMARY KEY
El ```CONSTRAINT``` ```PRIMARY KEY``` permite definir la entrada de datos como clave primaria, es decir, se le concede a una clave las restricciones de ```UNIQUE``` y ```NOT NULL``` a la vez.

```sql
<columna> <tipo-de-datos> PRIMARY KEY
```

Este ```CONSTRAINT``` tiene la peculiaridad de que puede hacer que la clave primaria no sea solo una si no varias columnas, las columnas involucradas pasan automáticamente a tener asignadas el ```CONSTRAINT``` ```NOT NULL``` y la combinación de los valores de *columna1* y *columna2* deben ser ```UNIQUE```.

```sql
columna1 CHAR(8),
columna2 CHAR(8),
PRIMARY KEY(columna1, columna2)
```

#### FOREIGN KEY
Con el ```CONSTRAINT``` ```FOREIGN KEY``` comprobamos que los datos introducidos ya existan en otra columna en otra tabla de la base de datos.

```sql
<columna> <tipo-de-datos> FOREIGN KEY <otra-tabla(otra-columna)>
```

#### EXCLUDE
El ```CONSTRAINT``` ```EXCLUDE``` permite comparar los valores introducidos con los ya existentes en la tabla, de darse una coincidencia, ```EXCLUDE``` impide la inserción de la nueva tupla.

```sql
EXCLUDE USING gist (<condición>)
```

---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---
### Fin de la consulta
En SQL es necesario declarar donde acaba nuestra consulta, para ello se usa el punto y coma.

> Aunque algunos sofwares como SQLzoo pueden ser permisivos y no necesitar el `;` para realizar la consulta, es un buena practica hacer uso del punto y coma igualmente.

```sql
SELECT country
FROM world;
```
---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---
## SQL - Data Manipulation Language
Las instrucciones DML se utilizan para devolver, añadir, actualizar o modificar y/o eliminar la información contenida en la base de datos sobre la que estamos trabajando.

Las instrucciones DML son: ```SELECT```, ```INSERT```, ```UPDATE```, ```DELETE FROM```, ```TRUNCATE```.

---

### SELECT
`SELECT` junto a las clausulas documentadas a continuación podemos devolver la información que tenemos contenida en la base de datos.

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
Como mínimo, tendremos que especificar una columna y una tabla para que la consulta funcione, para ayudarnos a entender nuestro propio código, y para facilitar su lectura a terceros, también podemos especificar ya en el propio ```SELECT``` el nombre de la tabla a la que estamos solicitando la información de cada columna.

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
> ```bash
> psql -f ./ejemplos/from.sql
> ```

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
> ```bash
> psql -f ./ejemplos/from2.sql
> ```
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
> WHERE country IN ('España', 'Portugal', 'Francia');
> ```
> Países     | 
> -----------|
> España     |
> Francia    |
> Portugal   |
>
> ```bash
> psql -f ./ejemplos/where.sql
> ```

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
> ```bash
> psql -f ./ejemplos/groupby.sql
> ```

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
> ```bash
> psql -f ./ejemplos/having.sql
> ```

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
> ```bash
> psql -f ./ejemplos/orderby.sql
> ```

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
> ```sql
> SELECT world.country AS "Países"
> FROM world
> ORDER BY world.country DESC
> LIMIT 5
> OFFSET 5;
> ```
> Países         | 
> ---------------|
> Vanuatu        |
> Uzbekistan     |
> Uruguay        |
> United States  |
> United Kingdom |
>
> ```bash
> psql -f ./ejemplos/limitandoffset.sql
> ```

### INSERT
Con ```INSERT``` podemos añadir información a una tabla de base de datos, esta información debe ser acorde a los criterios de validación establecidos en la configuración de la tabla.

```sql
INSERT INTO world (columna1, columna2, ...) VALUES
 (valor1c1, valor1c2,...,
  valor2c1, valor2c2,...
 );
```
> Podemos añadir tantas futuras tuplas tras ```VALUES``` como queramos.

> En PostgreSQL declarar las columnas es opcional si vamos añadir las nuevas tuplas siguiendo la estructura por defecto de la tabla, pero es buena practica hacer la declaración de columnas igualmente.

> **Ejemplo**
> *Añadiendo países a nuestra base de datos*.
>
> ```sql
> INSERT INTO world (country, continent, area, population, gdp, capital) VALUES
> ('Oceania','Oceania','63000000','10000000','11281191','London'),
> ('Eurasia','Asia','22000000','5120000','9128119','Moscow'),
> ('Eastasia','Asia','14000000','5510000','8158149','Tokyo');
> ```
> ```sql
> INSERT 0 3
> ```
> ```bash
> psql -f ./ejemplos/insertinto.sql
> ```


### UPDATE
Usado ```UPDATE``` podemos cambiar la información contenida en las tuplas de las bases de datos. La información actualizada deberá seguir cumpliendo los criterios de validación previamente establecidos.

```sql
UPDATE <nombre-tabla>
SET <expresion>
WHERE <condicion>
[RETURNING <columna1, columna2,...>];
```
> **Ejemplo**
> *Cambiando la capital de un país cuyo nombre coincida con su continente a New York*.
>
> ```sql
> UPDATE world
> SET capital='New York'
> WHERE country=continent
> RETURNING country, capital;
> ```
>
> country | capital
> --------|----------
> Oceania | New York
>
> ```sql
> INSERT 1
> ```
> ```bash
> psql -f ./ejemplos/update.sql
> ```


### DELETE FROM
Mediante ```DELETE FROM``` eliminamos tuplas contenidas en una tabla de la base de datos.

```sql
DELETE FROM <nombre-tabla>
WHERE <condición>
[RETURNING <columna1, columna2,...>];
```

> Si lo que buscamos es dejar la tabla sin ningún tipo de contenido, los desarrolladores de Postgres recomiendan usar ```TRUNCATE``` en lugar de ```DELETE FROM```.

> **Ejemplo**
> *Eliminando los paises con un nombre similar al continente asiático*.
>
> ```sql
> DELETE FROM world
> WHERE country LIKE '%asia%'
> RETURNING country, capital;
> ```
> country  | capital
> ---------|---------
> Eurasia  | Moscow
> Eastasia | Tokyo
>
> ```sql
> DELETE 2
> ```
> ```bash
> psql -f ./ejemplos/deletefrom.sql
> ```

### TRUNCATE
```TRUNCATE``` es una instrucción similar a ```DELETE FROM```, pero su finalidad es diferente, en lugar de borrar tuplas especificas que cumplán las condiciones de borrado, borra todas las tuplas de una tabla.

```sql
TRUNCATE <nombre-tabla> [CASCADE | RESTRICT];
```

---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---

## SQL - Data Definition Language
Las instrucciones DDL tienen la finalidad de definir las estructuras que se utilizaran en la base de datos.

DLL esta compuesto por ```CREATE```, ```DROP``` y ```ALTER```, estas tres instrucciones se utilizan para crear, eliminar y modificar los elementos ```DATABASE```, ```SCHEMA```, ```USER``` y ```TABLE```.

---

### DATABASE
Usando el conjunto de instrucciones DDL podemos crear, cambiar y/o eliminar una base de datos dentro del servidor Postgres.

#### CREATE
Con la instrucción ```CREATE DATABASE``` podemos crear una nueva base de datos.

```sql
CREATE DATABASE <nombre-bd> 
(OWNER <current-user>);
```

> En PostgreSQL la habilidad para crear una base de datos esta restringida a usuarios con el permiso concedido y al usuario *root* `postgres`. 

> Por defecto, un usuario creado en PostgreSQL con los parámetros predeterminados no puede ejecutar esta consulta.

###### OWNER
```OWNER``` se trata se una sentencia opcional que permite dar la propiedad de la nueva base de datos a un usuario especifico. Por defecto, se toma al usuario que ejecuta la consulta como propietario por defecto de la base de datos recién creada.

#### ALTER
Con la sentencia ```ALTER DATABASE``` podemos realizar cambios a una base de datos ya existente.

```sql
ALTER DATABASE <nombre-bd> 
RENAME TO <nuevo-nombre>
OWNER TO <nuevo-propietario>;
```
##### RENAME TO
Con ```RENAME TO``` podemos cambiar el nombre tiene actualmente la base de datos, el nuevo nombre no puede estar ocupado ya por otra base de datos.

##### OWNER TO
Usando ```OWNER TO``` cambiamos el propietario de la base de datos a otro usuario del servidor.

#### DROP
Usando ```DROP DATABASE``` eliminamos la base de datos objetivo de la sentencia.

```sql
DROP DATABASE <nombre-bd>;
```
> No podemos ejecutar la instrucción ```DROP DATABASE``` si estamos conectados a la misma base de datos sobre la que queremos ejecutar la sentencia.

---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---
### SCHEMA
Los esquemas son elementos que se utilizan para organizar la base de datos, por defecto, existe *public* al que se escribe toda la información si no se indica lo contrario.

#### CREATE
La sentencia ```CREATE SCHEMA``` creara un nuevo esquema en la base de datos sobre la que estamos trabajando.

```sql
CREATE SCHEMA <nombre-esquema> 
(AUTHORIZATION <current-user>);
```
###### AUTHORIZATION
Con esta sentencia adicional podemos cambiar el propietario del nuevo esquema, por defecto el nuevo propietario sera el usuario que ejecute la sentencia SQL de ```CREATE SCHEMA``` de no proporcionar esta instrucción.

#### ALTER
Con ```ALTER SCHEMA``` modificaremos la configuración de un esquema ya existente.

```sql
ALTER SCHEMA <nombre-esquema> 
RENAME TO <nuevo-nombre>
OWNER TO <nuevo-propietario>;
```

##### RENAME TO
Con ```RENAME TO``` podemos cambiar el nombre tiene actualmente el esquema, el nuevo nombre no puede estar ocupado ya por otro esquema existente.

##### OWNER TO
Usando ```OWNER TO``` cambiamos el propietario del esquema a otro usuario del servidor.

#### DROP
Usando ```DROP SCHEMA``` podemos eliminar el esquema, junto con toda la información que contiene.

```sql
DROP SCHEMA <nombre-esquema> [CASCADE | RESTRICT];
```

###### CASCADE
Este parámetro permite eliminar el esquema, junto a todos los contenidos referidos fuera del esquema.

###### RESTRICT
Este parámetro no permite eliminar el esquema de haber contenidos referenciados, **es el parámetro por defecto**.

---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---
### USER
Los usuarios son las diferentes identidades con las que se puede interaccionar con el servidor, cada usuario tiene unos determinados permisos, que le restringen que actividades puede realizar o no en el servidor.

#### CREATE
Con ```CREATE USER``` podemos definir nuevos usuarios.

```sql
CREATE USER <user-country>;
```

#### ALTER
Usando ```ALTER USER``` cambiamos los parámetros relativos a un usuario del servidor.

```sql
ALTER USER <user-country>
RENAME TO <nuevo-nombre>;
```
##### RENAME TO
Usando ```RENAME TO``` podemos renombrar un usuario existente.

#### DROP
Usando ```DROP USER``` eliminamos un usuario existente en el servidor.

```sql
DROP USER <user-country>;
```
---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---
### DOMAIN
Un ```DOMAIN``` nos permite establecer un *preset* para la entrada de datos que se esta haciendo en la base de datos.

#### CREATE
Con ```CREATE DOMAIN``` creamos un nuevo dominio.

```sql
CREATE DOMAIN <domain-country> <tipo-de-datos>
 [(CONSTRAINT <nombre-condición>)
 <condición>];
```
Dentro de los dominios no se pueden utilizar los ```CONSTRAINT``` de tipo ```UNIQUE```, ```PRIMARY KEY``` ni ```EXCLUDE```.

Nombrar el ```CONSTRAINT``` es opcional, si no lo hacemos, Postgres le dará un nombre por defecto, pero si luego necesitamos editar el ```CONSTRAINT``` no darle un nombre propio nos entorpecerá el trabajo.

> **Ejemplo**
> Queremos impedir que se introduzcan en nuestra base de datos de paises nombres no coherentes, crearemos un ```DOMAIN``` con un ```CONSTRAINT``` que obligue a los datos introducidos a ser letras, puntos, comas, guion y/o espacios.
>
> ```sql
> CREATE DOMAIN valid_country VARCHAR(128) 
>  CONSTRAINT valid_charset
>   CHECK (
>	 VALUE SIMILAR TO '[A-Za-zÑñ .,-]{1,}'
>   );
> ```
> ```sql
> CREATE DOMAIN
> ```
> ```bash
> psql -f ./ejemplos/createdomain.sql
> ```

#### ALTER
Con ```ALTER DOMAIN``` podemos modificar la configuración dada a un dominio existente.

```sql
ALTER DOMAIN <nombre-del-dominio>
 RENAME TO <nuevo-nombre>
 OWNER <nombre-de-usuario>
 SET SCHEMA <nombre-del-esquema>
 DROP CONSTRAINT <nombre-del-constraint>
 ADD (CONSTRAINT <nombre-del-constraint>) CONSTRAINT
```

> **Ejemplo**
> Decidimos usar el ```DOMAIN``` `valid_country` también para las capitales de país, y queremos rectificar su nombre.
>
> ```sql
> ALTER DOMAIN valid_country
>  RENAME valid_name;
> ```
> ```sql
> ALTER DOMAIN
> ```
> ```bash
> psql -f ./ejemplos/alterdomain.sql
> ```

##### RENAME
Con ```RENAME``` podemos cambiar el nombre que posee el dominio, el nuevo nombre no puede estar siendo usado por otro dominio ya existente.

##### OWNER
Con ```OWNER``` modificamos el usuario al que pertenece el dominio.
##### SET SCHEMA
Con ```SET SCHEMA``` cambiamos el esquema al que pertenece el dominio.
##### DROP CONSTRAINT
```DROP CONSTRAINT``` elimina un determinado ```CONSTRAINT``` que se encuentre configurado en el dominio.
##### ADD
Usando ```ADD``` podemos añadir un nuevo ```CONSTRAINT``` a un dominio ya existente, siguiendo la misma sintaxis que en ```CREATE DOMAIN```.

---

*Volver a: [Indice](#indice) -- [Sintaxis](#sintaxis) -- [DML](##sql---data-manipulation-language) -- [DDL](#sql---data-definition-language)*

---
### TABLE
Un ```TABLE``` es una estructura que se usa para almacenar la información de la base de datos.

#### CREATE
Usando ```CREATE TABLE``` añadimos una tabla a nuestra base de datos, en una tabla definimos columnas y sus criterios de integridad, más tarde, las tablas serán cubiertas con información usando instrucciones de SQL-DML.

```sql
CREATE TABLE <nombre-tabla> {
   <nombre-de-columna> [<tipo-de-datos> | <nombre-de-dominio>] (CONSTRAINT), ...
}
```
**Como mínimo, es necesario definir una columna**.

> **Ejemplo**
> Creamos una nueva tabla que albergara una lista de paises, su capital, continente, PIB, población y superficie.
>
> ```sql
> CREATE TABLE world(
>	country valid_name PRIMARY KEY,
>	capital valid_name UNIQUE NOT NULL,
>	continent VARCHAR 
>		CONSTRAINT valid_continents 
>		CHECK (
>			continent IN ('Africa', 'America', 'Asia', 'Europe', 'Oceania')
>		),
>	area BIGINT
>		CONSTRAINT valid_area
>		CHECK (
>			area >= 0
>		),
>	population INTEGER
>		CONSTRAINT valid_population
>		CHECK (
>			population >= 0
>		),
>	gdp INTEGER
>		CONSTRAINT valid_gdp NOT NULL
>);
> ```
> ```sql
> CREATE TABLE
> ```
> ```bash
> psql -f ./ejemplos/createtable.sql
> ```

###### CONSTRAINT
Opcionalmente podemos definir una o más ```CONSTRAINT```, incluso habiendo definido anteriormente condiciones en el dominio. En este caso, se pueden usar todos los tipos de ```CONSTRAINT```.

#### ALTER
Mediante ```ALTER TABLE``` podemos modificar una tabla previamente existente en la base de datos.

```sql
ALTER TABLE <nombre-tabla>
ADD <nombre-columna> <tipo-de-datos>
RENAME <nombre-columna> TO <nuevo-nombre-columna>
DROP <nombre-columna> [RESTRICT | CASCADE]
ALTER <nombre-columna> TYPE <tipo-de-datos>
ADD CONSTRAINT <condición>
DROP CONSTRAINT <nombre-condición> [RESTRICT | CASCADE]
OWNER TO <nombre-usuario>
RENAME CONSTRAINT <nombre-condición> TO <nuevo-nombre-condición>
RENAME TO <nuevo-nombre-tabla>
SET SCHEMA <nombre-esquema>
```

##### ADD
```ADD```os permite añadir una nueva columna a la tabla referenciada.

##### RENAME
Utilizando ```RENAME``` podemos cambiar el nombre de una columna ya existente en la base de datos.

##### DROP
Con ```DROP``` podemos eliminar una columna existente en la tabla.

##### ALTER
Usando ```ALTER <nombre-columna> TYPE``` podemos cambiar el dominio o tipo de datos que se aplica a la columna.

##### ADD CONSTRAINT
Mediante ```ADD CONSTRAINT``` podemos añadir una nueva condición a una columna existente.

##### DROP CONSTRAINT
```ADD CONSTRAINT``` permite eliminar una condición existente sobre la columna referenciada.

##### OWNER TO
Con ```ONWER TO``` podemos cambiar que usuario tiene la propiedad de la tabla.

##### RENAME CONSTRAINT
Utilizando ```RENAME CONSTRAINT``` podemos cambiar el nombre de una condición existente en la tabla.

##### RENAME TO
```RENAME TO``` nos permite cambiar el nombre que tiene la tabla internamente en la base de datos.

##### SET SCHEMA
Mediante ```SET SCHEMA``` podemos cambiar el esquema al que pertenece la tabla.

#### DROP
Con ```DROP TABLE``` podemos eliminar una tabla de la base de datos.

```sql
DROP TABLE <nombre-tabla> [CASCADE | (RESTRICT)]
```

###### CASCADE
Este parámetro permite eliminar el esquema, junto a todos los contenidos referidos en otras tablas.

###### RESTRICT
Este parámetro no permite eliminar el esquema de haber contenidos referenciados, **es el parámetro por defecto**.