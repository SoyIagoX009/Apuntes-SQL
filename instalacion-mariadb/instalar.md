# Instalación de MariaDB
En este documento se muestran los pasos básicos para tener una instalación local funcional de MariaDB, utilizare en una distribución Ubuntu 18.04 LTS (bajo WSL), los pasos son replicables tanto en un equipo físico, maquina virtual o sistema WSL con Ubuntu 18.04 LTS.

## Preparando el Sistema

![Consola con el comando 'sudo apt-get update'](https://raw.githubusercontent.com/SoyIagoX009/Apuntes-SQL/master/instalacion-mariadb/attachments/1.png)
Ejecutamos el comando <sudo apt-get update> con la finalidad de tener actualizados los repositorios de nuestra instalación de Ubuntu.

![Consola con el comando 'sudo apt-get upgrade'](https://raw.githubusercontent.com/SoyIagoX009/Apuntes-SQL/master/instalacion-mariadb/attachments/2.png)
Lo siguiente sera ejecutar <sudo apt-get upgrade> para actualizar todos los paquetes instalados en el sistema.

> Si contamos con una mala conexión a Internet podemos obviar este paso, pero es mejor hacerlo de ser posible 😠.

![Consola con el comando 'sudo apt-get upgrade', solicitando permiso para actualizar](https://raw.githubusercontent.com/SoyIagoX009/Apuntes-SQL/master/instalacion-mariadb/attachments/3.png)
APT (Advanced Packaging Tool) nos mostrara que paquetes se actualizaran a una versión más reciente, nos avisara del cambio en el espacio del disco duro y nos preguntara si queremos continuar, Pulsamos <Y> (Yes -- Sí) para iniciar el proceso de actualización.

![Consola con el comando 'sudo apt-get upgrade', en proceso de actualizar, solicitando permiso para reiniciar servicios](https://raw.githubusercontent.com/SoyIagoX009/Apuntes-SQL/master/instalacion-mariadb/attachments/4.png)
Dependiendo de los paquetes a actualizar es posible que aparezca un mensaje como el siguiente, preguntando sobre el reinicio automático de servicios que han sido actualizados, le concederemos permiso seleccionado <Yes>.

## Instalando MariaDB

![Consola con el comando 'sudo apt install mariadb-server'](https://raw.githubusercontent.com/SoyIagoX009/Apuntes-SQL/master/instalacion-mariadb/attachments/5.png)
La instalación de MariaDB en Ubuntu es un proceso sencillo ya que tenemos disponible un paquete con una versión estable del software en los repositorios de Canonical, simplemente ejecutamos <sudo apt install mariadb-server>.

![Consola con el comando 'sudo apt install mariadb-server', solicitando permiso para continuar](https://raw.githubusercontent.com/SoyIagoX009/Apuntes-SQL/master/instalacion-mariadb/attachments/6.png)
Similar al proceso de actualizar los paquetes del sistema, APT nos listara los paquetes adicionales que necesita MariaDB Server para funcionar correctamente y del requerimiento de espacio que eso conlleva. Pulsamos <Y> (Yes -- Sí) para que comience la descarga e instalación.

## Arrancando el servidor por primera vez

![Consola con el comando 'sudo /etc/init.d/mysql start'](https://raw.githubusercontent.com/SoyIagoX009/Apuntes-SQL/master/instalacion-mariadb/attachments/10.png)
Ejecutaremos <sudo /etc/init.d/mysql start> para arrancar el servidor MariaDB que acabamos de configurar.

![Consola con el comando 'sudo mysql -u root -p'](https://raw.githubusercontent.com/SoyIagoX009/Apuntes-SQL/master/instalacion-mariadb/attachments/11.png)
Lo siguiente sera configurar un usuario en el servidor, para ello ejecutamos <sudo mysql -u root -p>, proporcionamos la contraseña de root de nuestro sistema y deberíamos haber entrado en el shell de MariaDB.

![Consola con la sentencia SQL 'CREATE USER 'iago' IDENTIFIED BY 'averysecurepswd', en el shell de MariaDB](https://raw.githubusercontent.com/SoyIagoX009/Apuntes-SQL/master/instalacion-mariadb/attachments/13.png)
Ahora, ejecutamos la siguiente sentencia SQL:

```sql
CREATE USER 'username' IDENTIFIED BY 'averysecurepswd';
```
> Cambiamos _username_ por nuestro usuario UNIX si queremos iniciar el cliente SQL sin proporcionar un nombre de usuario concreto.
> Seria recomendable cambiar _averysecurepaswd_ por una contraseña segura.

![Consola mostrando el shell de MariaDB, tras haber ejecutado 'mysql -p'](https://raw.githubusercontent.com/SoyIagoX009/Apuntes-SQL/master/instalacion-mariadb/attachments/20.png)
**Ahora ya deberíamos poder acceder al servidor sin permisos de superusuario** (obviando el <sudo>), ejecutamos <mysql -p>, y, tras proporcionar la contraseña estaríamos en el shell de MariaDB.

> Si no usamos el nombre de usuario UNIX como nombre de usuario en la base de datos tendremos que ejecutar <mysql -u nombredeusuario -p>
> Podemos proporcionar directamente la contraseña de acceso a la base de datos haciendo <mysql -p averysecurepswd> pero, de esta manera, la contarseña se almacenaría en el historial de comandos, reduciendo la seguridad.

Ahora el servidor ya se encuentra listo para ser usado, recordar que **cualquier usuario que creemos de esta manera tiene permiso absoluto sobre todos la información del servidor** salvo que ejecutemos consultas SQL que le cambien los permisos.