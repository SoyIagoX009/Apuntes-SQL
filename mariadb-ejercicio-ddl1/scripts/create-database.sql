-- Este script tiene que ser ejecutado como root, crea toda la base de datos y le cede permisos a todos los usuarios del serividor.
CREATE DATABASE DDL1;
USE DDL1;
GRANT ALL PRIVILEGES ON DDL1.* TO '%'@'%'
source ./create-tables.sql
source ./create-constraints.sql
source ./create-primary-keys.sql
source ./create-references.sql