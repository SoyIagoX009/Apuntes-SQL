# Apuntes de SQL
Apuntes de SQL para el curso 2019/2020.

Los apuntes estan disponibles en el archivo `APUNTES.md`, de este mismo repositorio.

## Poner en marcha el entorno de trabajo
Estos apuntes usan como sistema gestor *PostgreSQL*, nos conectamos a una base de datos en el servicio *ElephantSQL*, nos registarmos con el plan gratuito, para conectarnos a la base de datos usamos el paquete `postgresql` en una instalación de `Ubuntu 18.04 LTS` bajo `Windows Subsystem for Linux (WSL)` en `Windows 10`.

### Activar la virtualización por hardware
La virtualización por hardware es necesaria para ejecutar `WSL`; para activarla --si no la tenemos ya-- hacemos lo siguiente:

Nos dirigimos al menu inicio, pulsamos sobre Inicio/Apagado y, pulsando la tecla `Shift` o `Mayus` (situada bajo `Caps Lock` o `Bloc. Mayus`) hacemos clic sobre `Reiniciar`.

Windows deberia abrirnos el cargador de arranque, pulsamos sobre `Solucionar problemas`, luego, `Opciones Avanzadas`, y por ultimo `Configuración del Firmware UEFI`. El ordenador deberia reiniciarse y arrancar en la BIOS, ahora toca rebuscar para encontrar la opción de virtualización por hardware, segun el ordenador que estemos usando el como llegar sera diferente, leer el manual o buscar en Google seguramente agilice el proceso; tras hacer el cambio, buscamos la opción de Guardar y Salir, y deberiamos estar de vuelta en Windows.

NOTA: **En equipos con BIOS heredada** para acceder a esta configuración hay que pulsar una tecla nada más el equipo da imagen, en lugar de los pasos anteriores [💩](https://www.google.com/search?q=uefi+memes&tbm=isch), dicha tecla habitualmente suele ser `F2`, `F12`, o `Suprimir`.

### Activar Windows Subsystem for Linux
Para activar WSL, podriamos darnos un viaje por toda la Interfaz de Usuario, pero, para agilizar, abrimos `PowerShell` como Administrador y ejecutamos este comando:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

Una vez la instalación finalice, si es necesario, reiniciamos, luego instalamos [Ubuntu 18.04 desde la Tienda de Microsoft](https://www.microsoft.com/store/apps/9N9TNGVNDL3Q), opcionalmente, para mayor comodidad, tambien podemos instalar [Windows Terminal](https://aka.ms/windowsterminal).

--- TBC ---

## Cargar y restaurar la base de datos
En la carpeta `scripts` de este repositiorio esta disponible un archivo `gentable.sql`, este script permite generar una base de datos identica a la usada en estos apuntes con el fin de tener la misma referencia a la hora de ejecutar ejemplos.

Para esto, podemos ejecutar en el Terminal de Ubuntu: `psql <postgress:\\url-de-nuestra-base-de-datos> -f gentable.sql`
Si además queremos cargar las tuplas de cada país, usamos el archivo `genrows.sql`, escribimos en el Terminal: `psql <postgress:\\url-de-nuestra-base-de-datos> -f genrows.sql`