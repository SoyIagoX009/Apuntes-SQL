# Apuntes de Server Query Language
SQL es un lenguaje de programación declarativo, lanzado en 1986, ha sido regulado por la ANSI, la ultima revisión data de 2016, aunque cada sistema gestor hace la implementación de diferentes maneras. Estos apuntes estan preparados para funcionar con PostgresSQL.

## Indice
- Sintaxis 
   - Enteros
   - Cadenas de texto
   - Colecciones de cadenas
   - Comentarios
   - Operadores de comparación
      - Mayor que...
	  - Menor que...
	  - Igual que...
	  - Distinto de...
   - Operadores logicos
      - XOR
	  - AND
	  - NOT
	  - Uso combinado
   - Comodines
     - Estrictos
	 - Permisivos
	 - Uso combinado
   - Subconsultas
   - Fin de la consulta
- Data Query Language
   - SELECT y FROM
       - Seleccionado varias columnas
       - Renonbrando columnas
   - WHERE
   - SORT BY


## Sintaxis
### Enteros
Los numeros enteros se representan sin utilizar ningun caracter en especial, es importante recordar que no se permite la separación del numero.

```sql
SELECT name
FROM world
WHERE population = 1000000; -- Correcto
-- WHERE population = 1 000 000 (Facilitaria la lectura, pero da error)
```

### Cadenas de texto
Para pasarle al gestor de base de datos una cadena de texto, es necesario, siempre, pasarle la información entre comillas simples:

```sql
SELECT name
FROM world
WHERE name='Spain';
```
En este ejemplo, usamos la cadena *Spain*, que la consulta solo nos devuelva a España de una lista de paises.

### Colecciones
Las colecciones son conjuntos de cadenas de texto independientes, su sintaxis es la siguiente:

```sql
SELECT name
FROM world
WHERE name IN ('Spain', 'France', 'Portugal');
```
En este ejemplo, usamos la colección *(Spain, France, Portugal)* para que la consulta solo nos devuelva estos de una lista de paises.

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
SELECT algo; --(a partir aquí, la linea se ignora) FROM algunaparte
```

**No contamos con la posibilidad de:**

- Hacer, directamente, parrafos:

```sql
--
Es imposible hacer funcionar los comentarios como el <!-- --> de HTML,
almenos en mySQL y tampoco en ANSI SQL, este codigo dara error.
--
SELECT algo
FROM algunaparte;
-- Esta seria
-- La forma correcta
-- de hacer parrafos
```

- Hacer comentarios en medio de la linea:

```sql
SELECT -- este codigo -- algo
FROM -- no funcionara -- algunaparte
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
WHERE population  < 1000;
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
WHERE name LIKE 'S____'
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
WHERE name LIKE 'F%'
```
Esta consulta devuelve todos los paises que se contengan F de primer caracter, pero da libertad a la longitud de la cadena de texto, por lo tanto se listan todos los paises que tengan una F al principio de su nombre

name |
-|
Fiji |
Finland |
France |

##### Uso combinado
Los dos comodines se pueden usar a la vez sin ningun tipo de problema.

```sql
SELECT name
FROM world
WHERE name LIKE '_c_%'
```
Esta consulta devuelve todos los paises que se contengan una *p* de segundo caracter, requiere que exista un tercer caracter, y luego, da libertad a la longitud de la cadena.

name |
-|
Iceland |
Ecuador |

### Subconsultas
En SQL el parentesis actua de la misma manera que lo haria en una operación matematica, la parte de la consulta declarada dentro del parentesis se realiza primero y permite, por ejemplo, hacer filtros con *SELECT* más complejos.

```sql
SELECT name, population
FROM world
WHERE population > (
             SELECT population 
             FROM world 
             WHERE name="India"
)
```
La parte de la consulta que se encuentra dentro del parentesis en este ejemplo permite obtener la población de la India, y, luego, lista los paises del mundo con más población que la India.

name | population
-| -
China | 1365370000

### Fin de la consulta
En SQL es necesario declarar donde acaba nuestra consulta, para ello se usa el punto y coma.

> Aunque algunos gestores pueden ser permisivos y no necesitar el ; para realizar la consulta, es un buena practica hacer uso del punto y coma igualmente.

```sql
SELECT name
FROM world;
```

## SQL - Data Query Language
Las instrucciones DQL se utilizan para leer información contenida en la base de datos sobre la que estamos trabajando.

### SELECT y FROM
`SELECT` y `FROM` **se utilizan juntos** en una sentencia SQL para devolver la información almacenada en una tabla.


```sql
SELECT name 
FROM world;
```

Este sencillo codigo devuelve una tabla con todos los nombres de los paises existentes, controversias a parte, en la actualidad:

name |
-|
Algeria |
Angola |
Benin |
***etc...***|


##### Seleccionando varias columnas
`SELECT` permite tambien seleccionar a la vez varias columnas, para hacerlo, basta para separar los nombres de las diferentes columnas con una coma (`,`).

```sql
SELECT name, continent
FROM world;
```
name | continent
-|-
Algeria | Africa
Angola | Africa
Benin | Africa
***etc...***|

##### Renonbrando columnas
La instrucción `AS` se utiliza tras el nombre de una tabla que queremos listar con un `SELECT` y nos pemite darle un alias a la hora de recuperar la información.

```sql
SELECT name AS "Paises"
FROM world
```
En lugar de aparecer *name* como nombre de la columna, ahora aparecera *Paises*.

Paises |
-|
Algeria |
Angola |
Benin |
***etc...***|

### WHERE
La instrucción `WHERE` se utiliza para filtrar los resultados devueltos tas un` SELECT <columna> FROM <tabla>`, de esta manera se nos devuelve la información que necesitamos segun los criterios que escribamos tras el `WHERE`, en lugar de toda la información de la tabla.


