# Apuntes de SQL
Apuntes de SQL para el curso 2019/2020.

Los apuntes estan disponibles en el archivo `APUNTES.md`, de este mismo repositorio. Este archivo contiene instrucciones para configurar un entorno de trabajo donde probar los ejemplos de dicho documento.

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
--- TBC ---

## Cargar y restaurar la base de datos
En la carpeta `scripts` de este repositiorio esta disponible un archivo `gentable.sql`, este script permite generar una base de datos identica a la usada en estos apuntes con el fin de tener la misma referencia a la hora de ejecutar ejemplos.

Para esto, podemos ejecutar en el Terminal de Ubuntu: `psql <postgress:\\url-de-nuestra-base-de-datos> -f gentable.sql`
Si además queremos cargar las tuplas de cada país, usamos el archivo `genrows.sql`, escribimos en el Terminal: `psql <postgress:\\url-de-nuestra-base-de-datos> -f genrows.sql`