## Poner en marcha el entorno de trabajo
Estos apuntes usan como sistema gestor *PostgreSQL*, nos conectamos a una base de datos en el servicio *ElephantSQL*, nos registarmos con el plan gratuito, para conectarnos a la base de datos usamos el paquete `postgresql` en una instalación de `Ubuntu 18.04 LTS` bajo `Windows Subsystem for Linux (WSL)` en `Windows 10`.

Todos los comandos usados en `WSL` son identicos a los que responderia un sistema `Ubuntu 18.04 LTS` con el mismo software. Si prefieres usar Ubuntu puro, ya sea en una maquina virtual o instalado propiamente en el PC, evita los dos primeros puntos y empieza en [`Instalar el cliente PostgreSQL`](#instalar-el-cliente-postgresql).


### Activar la virtualización por hardware
La virtualización por hardware es necesaria para ejecutar `WSL`; para activarla --si no la tenemos ya-- hacemos lo siguiente:

![Menu Inicio -> Inicio/Apagado -> (Shift) + Reiniciar](./README_imgs/1_1.png?raw=true)
Nos dirigimos al *Menu inicio*, pulsamos sobre `⏻ Inicio/Apagado` y, pulsando la tecla `Shift` o `Mayus` (situada bajo `Caps Lock` o `Bloc. Mayus`), hacemos clic sobre `↺ Reiniciar`.

![Solucionar Problemas, como el Sr. Lobo](./README_imgs/1_2.png?raw=true)
Windows deberia abrirnos el cargador de arranque, pulsamos sobre `Solucionar problemas`. 

![Opciones Avanzadas](./README_imgs/1_3.png?raw=true)
Luego, `Opciones Avanzadas`.

![Configuración del Firmware UEFI](./README_imgs/1_4.png?raw=true)
Y por ultimo `Configuración del Firmware UEFI`. 

![Reiniciar](./README_imgs/1_5.png?raw=true)
Pulsamos sobre `Reiniciar` y el PC deberia arrancar en la BIOS, ahora toca rebuscar para encontrar la opción de virtualización por hardware, segun el ordenador que estemos usando el como llegar sera diferente, leer el manual o buscar en Google seguramente agilice el proceso; tras hacer el cambio, buscamos la opción de Guardar y Salir, y deberiamos estar de vuelta en Windows.

NOTA: **En equipos con BIOS heredada** para acceder a esta configuración hay que pulsar una tecla nada más el equipo da imagen, en lugar de los pasos anteriores [💩](https://www.google.com/search?q=uefi+memes&tbm=isch), dicha tecla habitualmente suele ser `F2`, `F12`, o `Suprimir`.

### Activar Windows Subsystem for Linux
Para activar WSL, podriamos darnos un viaje por toda la Interfaz de Usuario, pero, para agilizar, abrimos `PowerShell` como Administrador y ejecutamos este comando:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

Una vez la instalación finalice, si es necesario, reiniciamos, luego instalamos [Ubuntu 18.04 desde la Tienda de Microsoft](https://www.microsoft.com/store/apps/9N9TNGVNDL3Q), opcionalmente, para mayor comodidad, tambien podemos instalar [Windows Terminal](https://aka.ms/windowsterminal).

### Instalar el cliente PostgreSQL
Abrimos Windows Terminal y una pestaña de Ubuntu o en su defecto la consola de WSL (más fea 👨‍💻), seguimos los pasos para configurar un usuario UNIX si no lo hemos hecho ya. 
![Windows Terminal en Linux mostrando sudo apt-get update](./README_imgs/2_0.png?raw=true)
Ejecutamos ```sudo apt-get update``` para actualizar la lista de repositorios.

![Windows Terminal en Linux mostrando sudo apt-get upgrade](./README_imgs/2_1.png?raw=true)
Luego ```sudo apt-get upgrade``` para actualizar los paquetes del sistema.

![Windows Terminal en Linux mostrando sudo apt-get install postgresql](./README_imgs/2_2.png?raw=true)
Ya con el sistema actualizado, lanzamos ```sudo apt-get install postgresql``` para instalar el servidor PostgreSQL.

### Inicializar el servidor PostgreSQL
![Windows Terminal en Linux mostrando sudo apt-get install postgresql](./README_imgs/2_3.png?raw=true)
En el Terminal ejecutamos `sudo service postgresql start`, si se nos devuelve un mensaje como la imagen el servidor ya estará listo para operar.

> En WSL, es posible que nos salte una alerta del Firewall de Windows en el PostgreSQL solicita permiso de acceso a red, para evitar cualquier fallo, aceptamos conceder acceso.

Ahora iniciaremos sesión un momento con el usuario `postgres`, para ello hacemos `sudo -u postgres -i`.

![Windows Terminal en Linux mostrando sudo apt-get install postgresql](./README_imgs/2_5.png?raw=true)
Ejecutamos el comando `createuser <neustro-usuario-unix>`.

![Windows Terminal en Linux mostrando sudo apt-get install postgresql](./README_imgs/2_6.png?raw=true)
Abrimos el cliente PostgreSQL, `psql` y ejecutamos la consulta ```CREATE DATABASE <nuestro-usuario-unix>;```, ya hemos acabado la inicialización; salimos del shell psql escribiendo `\q` y pulsando `ENTER`, volvemos a nuestro usuario UNIX usando `su <usuario-unix>`.

### Iniciar el servidor PostgreSQL
![Windows Terminal en Linux mostrando sudo apt-get install postgresql](./README_imgs/2_7.png?raw=true)

Abrimos el cliente PostgreSQL usando el comando `psql`, ya deberiamos estar dentro de nuestra base de datos.

Si por cualquier motivo `psql` devuelve un error, refierate al primer paso de Inicializar el servidor PostgreSQL y vuelve a ejecutar `psql` tras haberlo hecho de nuevo (**solo ese paso**, no la sección entera, salvo que lo hayas hecho todo mal 😡🔫).

## Cargar y restaurar la base de datos
En la carpeta `scripts` de este repositorio esta disponible un archivo `gentable.sql`, este script permite generar una base de datos idéntica a la usada en estos apuntes con el fin de tener la misma referencia a la hora de ejecutar ejemplos.

Para esto, podemos ejecutar en el Terminal de Ubuntu: 

- Si estamos usando una base de datos de ElephantSQL 👉 `psql <postgress:\\url-de-nuestra-base-de-datos> -f ./Apuntes-SQL/Scripts/gentable.sql`.
- Si estamos usando una base de local 👉 `psql -f ./Apuntes-SQL/Scripts/gentable.sql`.

Si además queremos cargar las tuplas de cada país, usamos el archivo `genrows.sql`:

- Si estamos usando una base de datos de ElephantSQL 👉 `psql <postgress:\\url-de-nuestra-base-de-datos> -f ./Apuntes-SQL/Scripts/genrows.sql`.
- Si estamos usando una base de local 👉 `psql -f ./Apuntes-SQL/Scripts/genrows.sql`.

En `./Apuntes-SQL/Scripts/genrows` esta disponible una lista de tuplas en formato CSV por si por cualquier motivo a alguien se le da por arreglar la base de datos, que cuenta con errores y posee además de países algunos territorios no autónomos. 

**En un SO Windows**, el archivo `genrows.bat` compila un script SQL acorde a cualquier cambio al CSV, lo unico que hay que hacer en ese script una vez compilado es eliminar la coma que queda junto al `;` (cierre de consulta) por limitaciones de batch.