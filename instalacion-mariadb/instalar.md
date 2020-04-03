# Instalación de MariaDB
En este documento se muestran los pasos básicos para tener una instalación local funcional de MariaDB, utilizare en una distribución Ubuntu 18.04 LTS (bajo WSL), los pasos son replicables tanto en un equipo físico, maquina virtual o sistema WSL con Ubuntu 18.04 LTS.

#### Links utiles
👉 [Activar la virtualización por hardware](../APUNTES_conf.md#activar-la-virtualizaci%C3%B3n-por-hardware) para WSL y maquinas virtuales.

👉 [Instalar WSL y Ubuntu 18.04 LTS](../APUNTES_conf.md#activar-windows-subsystem-for-linux) en Windows 10 (*documentado para la versión 1909*).

## Indice
- [Preparando el Sistema](#preparando-el-sistema)
- [Instalando MariaDB](#instalando-mariadb)
- [Arrancando el servidor por primera vez](#arrancando-el-servidor-por-primera-vez)

## Preparando el Sistema

![Consola con el comando 'sudo apt-get update'](./attachments/1.PNG?raw=true)

Ejecutamos el comando `sudo apt-get update` con la finalidad de tener actualizados los repositorios de nuestra instalación de Ubuntu.

![Consola con el comando 'sudo apt-get upgrade'](./attachments/2.PNG?raw=true)

Lo siguiente sera ejecutar `sudo apt-get upgrade` para actualizar todos los paquetes instalados en el sistema.

> Si contamos con una mala conexión a Internet podemos obviar este paso, pero es mejor hacerlo de ser posible 😠.

![Consola con el comando 'sudo apt-get upgrade', solicitando permiso para actualizar](./attachments/3.PNG?raw=true)

APT _(Advanced Packaging Tool)_ nos mostrara que paquetes se actualizaran a una versión más reciente, nos avisara del cambio en el espacio del disco duro y nos preguntara si queremos continuar.

__Pulsamos `Y`__ _(Yes -- Sí)_ __para iniciar el proceso de actualización.__

![Consola con el comando 'sudo apt-get upgrade', en proceso de actualizar, solicitando permiso para reiniciar servicios](./attachments/4.PNG?raw=true)

Dependiendo de los paquetes a actualizar __es posible que aparezca un mensaje como el siguiente__, preguntando sobre el reinicio automático de servicios que han sido actualizados, le __concederemos permiso seleccionado `<Yes>`__.

## Instalando MariaDB

![Consola con el comando 'sudo apt install mariadb-server'](./attachments/5.PNG?raw=true)

La instalación de MariaDB en Ubuntu es un proceso sencillo ya que tenemos disponible un paquete con una versión estable del software en los repositorios de Canonical, simplemente ejecutamos `sudo apt install mariadb-server`.

![Consola con el comando 'sudo apt install mariadb-server', solicitando permiso para continuar](./attachments/6.PNG?raw=true)

Similar al proceso de actualizar los paquetes del sistema, APT nos listara los paquetes adicionales que necesita MariaDB Server para funcionar correctamente y del requerimiento de espacio que eso conlleva.

__Pulsamos `Y`__ _(Yes -- Sí)_ __para que comience la descarga e instalación.__

## Arrancando el servidor por primera vez

![Consola con el comando 'sudo /etc/init.d/mysql start'](./attachments/10.PNG?raw=true)

Ejecutaremos `sudo /etc/init.d/mysql start` para arrancar el servidor MariaDB que acabamos de instalar en la máquina.

![Consola con el comando 'sudo mysql -u root -p'](./attachments/11.PNG?raw=true)

Lo siguiente sera configurar un usuario en el servidor, para ello ejecutamos `sudo mysql -u root -p`, proporcionamos la contraseña de root de nuestro sistema y deberíamos haber entrado en el shell de MariaDB.

![Consola con la sentencia SQL 'CREATE USER 'iago' IDENTIFIED BY 'averysecurepswd', en el shell de MariaDB](./attachments/13.PNG?raw=true)

Ahora, ejecutamos la siguiente sentencia SQL:

```sql
CREATE USER 'username' IDENTIFIED BY 'averysecurepswd';
```
> Cambiamos _username_ por nuestro nombre de usuario en Ubuntu si queremos iniciar el cliente SQL sin proporcionar un nombre de usuario concreto.

> Seria recomendable cambiar _averysecurepaswd_ por una contraseña segura.

![Consola mostrando el shell de MariaDB, tras haber ejecutado 'mysql -p'](./attachments/20.PNG?raw=true)

__Ahora ya deberíamos poder concertarnos al servidor sin permisos de superusuario__ (obviando el `sudo`):

1. Escribimos `\q` y pulsamos `ENTER` para salir del *shell* de MariaDB
2. Ejecutamos `su <nuestro-usuario>` para volver a nuestra cuenta habitual en Ubuntu.
3. Ejecutamos `mysql -p`, y, tras proporcionar la contraseña estaríamos en el shell de MariaDB.

> Si no usamos el nombre de usuario de Ubuntu como nombre de usuario en la base de datos tendremos que ejecutar `mysql -u nombredeusuario -p`

> Podemos proporcionar directamente la contraseña de usuario en el servidor haciendo `mysql -p averysecurepswd` pero, de esta manera, __la contraseña se almacenaría en el historial de comandos__, reduciendo la seguridad.

Tras esto, el servidor ya se encuentra listo para ser usado, recordar que **cualquier usuario que creemos de esta manera tiene permiso absoluto sobre toda la información contenida en el servidor** salvo que ejecutemos consultas SQL que le cambien los permisos.

> Si en futuro intentamos conectanos y se nos devuelve el error:
> ```
> ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2 "No such file or directory")
> ```
> Tan solo volvemos a ejecutar el comando: `sudo /etc/init.d/mysql start` y el problema deberia haberse solucionado.