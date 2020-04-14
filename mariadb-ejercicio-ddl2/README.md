# Naves espaciais

Faremos uso do exercicio resolto *Naves espaciais* para crear unha base de datos nun servidor que executa MariaDB.

#### Links utiles
- [📕 Enunciado do exercicio](https://github.com/davidgchaves/first-steps-with-git-and-github-wirtz-asir1-and-dam1/tree/master/exercicios-ddl/2-naves-espaciais)
- [🐱‍💻 Instalar MariaDB en Ubuntu](../instalacion-mariadb/instalar.md)
- [📙 Apuntes de DLL -- *Data Definition Language*](../APUNTES.md#sql---data-definition-language)

## Indice

- [Crear a base de datos](#crear-a-base-de-datos)
- [Creas as taboas](#crear-as-taboas)
- [Definindo restricións](#definindo-restricións)
    - [Claves e códigos](#claves-e-códigos)
    - [Nomes](#nomes)
    - [Medidas](#medidas)
    - [Claves primarias](#claves-primarias)
- [Relacións](#relacións)

## Crear a base de datos

Por defecto, os usuarios de MariaDB carecen dos permisos necesarios para crear unha base de datos, iniciamos sesión no servidor utilizando a conta de usuario *root* de Ubuntu (facendo uso de `sudo`).

1. Abrimos unha ventana do Terminal de comandos e executamos `sudo mysql -u root -p`.

![Terminal mostrando 'sudo mysql -u root -p'](./imgs/1.PNG)

> Se e necesario, iniciamos o servidor usando o comando `sudo /etc/init.d/mysql start`.

2. Unha vez dentro, executamos unha sentenza para crear a nova base de datos, neste caso usaremos o nome `DDL2`:

![Terminal coa consulta 'CREATE DATABASE DDL2;'](./imgs/2.PNG)

```sql
CREATE DATABASE DDL2;
```

3. Agora, poñemonos sobre a base de datos recen creada.

![Terminal con 'USE DDL2;' en pantalla](./imgs/3.PNG)

```sql
USE DDL2;
```

4. E damos todo-los permisos da base de datos ao noso usuario de MariaDB:

![Terminal mostrando 'GRANT ALL PRIVILEGES ON DDL2.* TO 'iago'@'%''](./imgs/4.PNG)

> Se non temos usuario creado no servidor, seguimos antes [estes pasos](../instalacion-mariadb/instalar.md#arrancando-el-servidor-por-primera-vez).

```sql
GRANT ALL PRIVILEGES ON DDL2.* TO 'iago'@'%'
```

5. Pechamos a sesión do usuario *root* escribindo `\q` no shell de MariaDB e pulsando `INTRO` e lanzamos novamente o cliente `mysql -p` co noso usuario normal e poñemonos sobre a base de datos.

![Terminal mostrando \q](./imgs/5.PNG)
```sql
USE DDL2;
```
![Terminal mostrando 'USE DDL2;'](./imgs/6.PNG)

```bash
mysql -p
```

---

<p align="center"><a  href="#indice"><i>Volver ó indice</i></a></p>

---

## Crear as taboas

A partir do esquema deseñamos as seguintes consultas, que crearan a estructura da base de datos, **introduciremos as distintas relacións e restriccions mais tarde**.

Para as claves e códigos utilizaremos o tipo de datos `CHAR(8)`, para datas o tipo `DATE`, `INT` e `SMALLINT` para as entradas numéricas con posible interese matemático, e segun o tamaño dos datos esperados.

###### Táboa *servizo*
![](./imgs/7.PNG)
```sql
CREATE TABLE servizo (
    clave_servizo CHAR(8) NOT NULL,
    nome_servizo VARCHAR(128) NOT NULL
);
```
###### Táboa *dependencia*
![](./imgs/8.PNG)
```sql
CREATE TABLE dependencia (
    cod_dependencia CHAR(8) NOT NULL,
    nome_dependencia VARCHAR(128) NOT NULL,sdw
    clave_servizo CHAR(8) NOT NULL,
    nome_servizo VARCHAR(128) NOT NULL,
    funcion VARCHAR(128) NOT NULL,
    localizacion VARCHAR(128) NOT NULL
);
```
###### Táboa *camara*
![](./imgs/9.PNG)
```sql
CREATE TABLE camara (
    cod_dependencia CHAR(8) NOT NULL,
    categoria VARCHAR(128) NOT NULL,
    capacidade SMALLINT NOT NULL
);
```
###### Táboa *tripulacion*
![](./imgs/10.PNG)
```sql
CREATE TABLE tripulacion (
    cod_tripulacion CHAR(8) NOT NULL,
    nome_tripulacion VARCHAR(128) NOT NULL,
    cod_camara  CHAR(8) NOT NULL,
    cod_dependencia  CHAR(8) NOT NULL,
    categoria  VARCHAR(128) NOT NULL,
    antiguidade INT,
    procedencia  VARCHAR(128) NOT NULL,
    admision DATE
);
```
###### Táboa *visita*
![](./imgs/11.PNG)
```sql
CREATE TABLE visita (
    cod_tripulacion CHAR(8) NOT NULL,
    cod_planeta CHAR(8) NOT NULL,
    data_visita DATE,
    tempo INT
);
```
###### Táboa *planeta*
![](./imgs/12.PNG)
```sql
CREATE TABLE planeta (
    cod_planeta CHAR(8) NOT NULL,
    nome_planeta CHAR(8) NOT NULL,
    galaxia VARCHAR(128) NOT NULL,
    coordenadas VARCHAR(128) NOT NULL
);
```

###### Táboa *habita*
![](./imgs/13.PNG)
```sql
CREATE TABLE habita (
    cod_planeta CHAR(8) NOT NULL,
    nome_raza VARCHAR(128) NOT NULL,
    pob_parcial INT
);
```


###### Táboa *raza*
![](./imgs/14.PNG)
```sql
CREATE TABLE raza (
    nome_raza VARCHAR(128) NOT NULL,
    altura SMALLINT,
    anchura SMALLINT,
    peso SMALLINT,
    pob_total SMALLINT
);
```

---

<p align="center"><a  href="#indice"><i>Volver ó indice</i></a></p>

---

## Definindo restricións
Para garantir que na nosa base de datos gardase información coherente, teremos que definir as restricións necesarias para cada elemento.

### Claves e códigos
Deseñaremos unha restrición para que as claves e os códigos teñan una restrición que so permita facer uso de numéración hexadecimal (0-F), como estes datos, a pesares de ser numérico non teñen interese matemático, faremos uso do tipo de datos ``CHAR(8)`` (xa previamente establecido).

###### Táboa *servizo*
![](./imgs/15.PNG)
```sql
ALTER TABLE servizo
 ADD CONSTRAINT co_code_mask
    CHECK (
        clave_servizo REGEXP '[0-9ABCDEF]{8}'
    );
```

###### Táboa *dependencia*
![](./imgs/16.PNG)
```sql
ALTER TABLE dependencia
 ADD CONSTRAINT ca_code_mask
    CHECK (
        cod_depedencia REGEXP '[0-9ABCDEF]{8}'
    ),
 ADD CONSTRAINT co_code_mask
    CHECK (
        clave_servizo REGEXP '[0-9ABCDEF]{8}'
    );
```

###### Táboa *camara*
![](./imgs/17.PNG)
```sql
ALTER TABLE camara
 ADD CONSTRAINT ca_code_mask
    CHECK (
        cod_depedencia REGEXP '[0-9ABCDEF]{8}'
    );
```

###### Táboa *tripulacion*
![](./imgs/18.PNG)
```sql
ALTER TABLE tripulacion
 ADD CONSTRAINT ctri_code_mask
    CHECK (
        cod_tripulacion REGEXP '[0-9ABCDEF]{8}'
    ),
 ADD CONSTRAINT ccam_code_mask
    CHECK (
        cod_camara REGEXP '[0-9ABCDEF]{8}'
    ),
 ADD CONSTRAINT cdep_code_mask
    CHECK (
        cod_depedencia REGEXP '[0-9ABCDEF]{8}'
    );
```

###### Táboa *planeta*
![](./imgs/19.PNG)
```sql
ALTER TABLE planeta
 ADD CONSTRAINT cpla_code_mask
    CHECK (
        cod_planeta REGEXP '[0-9ABCDEF]{8}'
    );
```

###### Táboa *habita*
![](./imgs/20.PNG)
```sql
ALTER TABLE habita
 ADD CONSTRAINT cpla_code_mask
    CHECK (
        cod_planeta REGEXP '[0-9ABCDEF]{8}'
    );
```

### Nomes
Deseñamos unha restrición para gardar a integridade dos valores da base de datos que deberían ser nomes, para iso eliminamos a posibilidade de introducires ningún carácter que non sexa pertencente os alfabetos da península ibérica, o carácter de espazo e o punto e a coma.

###### Táboa *servizo*
![](./imgs/21.PNG)
```sql
ALTER TABLE servizo
 ADD CONSTRAINT ser_name_mask
    CHECK (
        nome_servizo REGEXP '%[A-Za-zÑñÇç .,]%'
    );
```

###### Táboa *dependencia*
![](./imgs/22.PNG)
```sql
ALTER TABLE dependencia
 ADD CONSTRAINT ndep_name_mask
    CHECK (
        nome_dependencia REGEXP '%[A-Za-zÑñÇç .,]%'
    ),
 ADD CONSTRAINT nser_name_mask
    CHECK (
        nome_servizo REGEXP '%[A-Za-zÑñÇç .,]%'
    ),
 ADD CONSTRAINT fun_name_mask
    CHECK (
        funcion REGEXP '%[A-Za-zÑñÇç .,]%'
    ),
 ADD CONSTRAINT loc_name_mask
    CHECK (
        localizacion REGEXP '%[A-Za-zÑñÇç .,]%'
 );
```
###### Táboa *camara*
![](./imgs/23.PNG)
```sql
ALTER TABLE camara
 ADD CONSTRAINT cat_name_mask
    CHECK (
        categoria REGEXP '%[A-Za-zÑñÇç .,]%'
    );
```
###### Táboa *tripulacion*
![](./imgs/24.PNG)
```sql
ALTER TABLE tripulacion
 ADD CONSTRAINT ntrip_name_mask
    CHECK (
        nome_tripulacion REGEXP '%[A-Za-zÑñÇç .,]%'
    ),
 ADD CONSTRAINT cat_name_mask
    CHECK (
        categoria REGEXP '%[A-Za-zÑñÇç .,]%'
    ),
 ADD CONSTRAINT pro_name_mask
    CHECK (
        procedencia REGEXP '%[A-Za-zÑñÇç .,]%'
    );
```

###### Táboa *planeta*
![](./imgs/25.PNG)
```sql
ALTER TABLE planeta
 ADD CONSTRAINT gal_name_mask
    CHECK (
        galaxia REGEXP '%[A-Za-zÑñÇç .,]%'
    );
```

###### Táboa *habita*
![](./imgs/26.PNG)
```sql
ALTER TABLE habita
 ADD CONSTRAINT nra_name_mask
    CHECK (
        nome_raza REGEXP '%[A-Za-zÑñÇç .,]%'
    );
```

###### Táboa *raza*
![](./imgs/27.PNG)
```sql
ALTER TABLE raza
 ADD CONSTRAINT nra_name_mask
    CHECK (
        nome_raza REGEXP '%[A-Za-zÑñÇç .,]%'
    );
```

### Medidas
Por pura loxica, un peso ou a altura non poden ser negativos, asi que, eliminaremos esa posibilidade facendo uso destas restriccions.

###### Táboa *tripulacion*
![](./imgs/28.PNG)
```sql
ALTER TABLE tripulacion
 ADD CONSTRAINT ant_valid_value
    CHECK (
        antiguedad <= 0
    );
```
###### Táboa *visita*
![](./imgs/29.PNG)

```sql
ALTER TABLE visita
 ADD CONSTRAINT tempo_valid_value
    CHECK (
        tempo < 0
    );
```
###### Táboa *habita*
![](./imgs/30.PNG)
```sql
ALTER TABLE habita
 ADD CONSTRAINT pob_valid_value
    CHECK (
        pob_parcial <= 0
    );
```

###### Táboa *raza*
![](./imgs/31.PNG)
```sql
ALTER TABLE raza
 ADD CONSTRAINT alt_valid_value
    CHECK (
        altura < 0
    ),
 ADD CONSTRAINT anc_valid_value
    CHECK (
        anchura < 0
    ),
 ADD CONSTRAINT pes_valid_value
    CHECK (
        peso < 0
    ),
 ADD CONSTRAINT pob_valid_value
    CHECK (
        pob_total < 0
    );
```
### Claves primarias
Agora, editamos toda-las taboas para engadir as restricións de clave primaria, e, ademais engadimos al claves alernativas, de habelas.

###### Táboa *servizo*
Nesta táboa utilziaremos o conxunto de *clave_servizo* e *nome_servizo* como clave primaria.
![](./imgs/32.PNG)
```sql
ALTER TABLE servizo
 ADD CONSTRAINT servizo_pk
    PRIMARY KEY (clave_servizo, nome_servizo);
```

###### Táboa *dependencia*
En *dependencia* o *cod_dependencia* fara de clave primaria, ademaís, marcamos *nome_dependencia* como clave alternativa (`UNIQUE` + `NOT NULL`).

![](./imgs/33.PNG)
```sql
ALTER TABLE dependencia
 ADD CONSTRAINT depedencia_pk
    PRIMARY KEY (cod_dependencia),
 ADD CONSTRAINT dependencia_ak
    UNIQUE (nome_dependencia);
```

###### Táboa *camara*
Na táboa camara o *cod_dependencia* sera a clave primaria.

![](./imgs/34.PNG)

```sql
ALTER TABLE camara
 ADD CONSTRAINT camara_pk
    PRIMARY KEY (cod_dependencia);
```

###### Táboa *tripulacion*
Para a táboa *tripulacion* *cod_tripulacion* sera a clave primaria.

![](./imgs/35.PNG)

```sql
ALTER TABLE tripulacion
 ADD CONSTRAINT tripulacion_pk
    PRIMARY KEY (cod_tripulacion);
```

###### Táboa *visita*
En *visita* o conxunto de *cod_tripulacion*, *cod_planeta* e *data_visita* formaran a clave primaria.

![](./imgs/36.PNG)

```sql
ALTER TABLE visita
 ADD CONSTRAINT visita_pk
    PRIMARY KEY (cod_tripulacion, cod_planeta, data_visita);
```

###### Táboa *planeta*
Para a táboa *planeta* teremos ao *cod_planeta* como clave priamria, xunto as claves alternativas *nome_planeta* e *coordenadas*.

![](./imgs/37.PNG)

```sql
ALTER TABLE planeta
 ADD CONSTRAINT planeta_pk
    PRIMARY KEY (cod_planeta),
 ADD CONSTRAINT na_planeta_ak
    UNIQUE (nome_planeta),
 ADD CONSTRAINT cs_planeta_ak
    UNIQUE (coordenadas);
```

###### Táboa *habita*
Nesta táboa o conxunto de *cod_planeta* e *nome_raza* conformaran a clave primaria.

![](./imgs/38.PNG)

```sql
ALTER TABLE habita
 ADD CONSTRAINT habita_pk
    PRIMARY KEY (cod_planeta, nome_raza);
```

###### Táboa *raza*
Para rematar, na táboa *raza*, a clave primaria sera *nome_raza*.

![](./imgs/39.PNG)

```sql
ALTER TABLE raza
 ADD CONSTRAINT raza_pk
    PRIMARY KEY (nome_raza);
```

---

<p align="center"><a  href="#indice"><i>Volver ó indice</i></a></p>

---

## Relacions
Por ultimo, relacionaremos as distintas taboas. Neste caso marcamos sempre os valores para actualizarse e borrarse en cascada en todas as relacións.

###### Táboa *dependencia*
Referenciaremos os valores da *clave_servizo* e *nome_servizo* os da *clave_servizo* e *nome_servizo* da táboa *servizo*.

![](./imgs/40.PNG)

```sql
ALTER TABLE dependencia
 ADD CONSTRAINT servizo_fk
    FOREIGN KEY (clave_servizo, nome_servizo) 
    REFERENCES servizo (clave_servizo, nome_servizo)
    ON UPDATE CASCADE
    ON DELETE CASCADE;
```

###### Táboa *camara*
Para a táboa camara referenciamos o *cod_dependencia* a os *cod_dependencia* da táboa *dependencia*.

![](./imgs/41.PNG)

```sql
ALTER TABLE camara
 ADD CONSTRAINT cod_dependencia_fk
    FOREIGN KEY (cod_dependencia) 
    REFERENCES dependencia (cod_dependencia)
    ON UPDATE CASCADE
    ON DELETE CASCADE;
```

###### Táboa *visita*
Para a *visita* vinculamos os valores de *cod_tripulación* aos da táboa *tripulacion* e o *cod_planeta* a táboa *planeta*.

![](./imgs/42.PNG)

```sql
ALTER TABLE visita
 ADD CONSTRAINT cod_tripulacion_fk
    FOREIGN KEY (cod_tripulacion) 
    REFERENCES tripulacion (cod_tripulacion)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
 ADD CONSTRAINT cod_planeta_fk
    FOREIGN KEY (cod_planeta) 
    REFERENCES planeta (cod_planeta)
    ON UPDATE CASCADE
    ON DELETE CASCADE;
```

###### Táboa *habita*
Por ultimo, na táboa *habita* ligamos *cod_planeta* a táboa *planeta* e o *nome_raza* a táboa *raza*.

![](./imgs/43.PNG)

```sql
ALTER TABLE habita
 ADD CONSTRAINT hcod_planeta_fk
    FOREIGN KEY (cod_planeta) 
    REFERENCES planeta (cod_planeta)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
 ADD CONSTRAINT nome_raza_fk
    FOREIGN KEY (nome_raza) 
    REFERENCES raza (nome_raza)
    ON UPDATE CASCADE
    ON DELETE CASCADE;
```