<!--
*** Thanks for checking out this README Template. If you have a suggestion that would
*** make this better, please fork the repo and create a pull request or simply open
*** an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
-->





<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://www.overtel.com">
    <img src="images/logo.png" alt="Logo Overtel" width="30%" height="30%">
  </a>


  <h3 align="center">Recogida de datos de Tareas Programadas de SQL Server para su uso en PandoraFMS</h3>

  <p align="center">
    Grupo de scripts que nos permiten extraer datos de SQL Server y almacenarlos en PandoraFMS
    <br />
    <a href="https://github.com/franciscotudel-overtel/pandorafms_sql_server_tareas_programadas/issues">Reportar un Bug</a>
    ·
    <a href="https://github.com/franciscotudel-overtel/pandorafms_sql_server_tareas_programadas/issues">Requerir una nueva caracteristica</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
## Tabla de contenido

* [Acerca de nosotros](#Acerca-de-nosotros)
* [Comenzando](#Comenzando)
  * [Prerequisitos](#Prerequisitos)
  * [Instalacion](#Instalacion)
* [Ejemplos de Uso](#Ejemplos-de-uso)
  * [Listado de Tareas](#listado-de-tareas)
  * [Listado de Metricas para una tarea especifica](#Listado-de-metricas-por-cada-tarea)
* [Contribuir](#contribuir)
* [Licencia](#licencia)
* [Contacto](#contacto)
* [Agradecimientos](#agradecimientos)



<!-- Sobre el proyecto -->
## Acerca de Nosotros
*Overtel Technology Systems* está edicada al desarrollo y la implementación de Nuevas Tecnologías de la Información y Comunicaciones (TIC), aparece en el panorama nacional en mayo de 1996, abriendo su primer centro de trabajo en Cartagena (Región de Murcia) donde a día de hoy ubica su central de recursos y oficinas administrativas, siendo el epicentro de su constante expansión hacia otras provincias de España, principalmente el levante Español, Murcia, Almería, Alicante, Valencia…
Operando con un equipo de calidad humana y técnica sobresaliente, damos servicio a toda la geografía nacional.

*Pandora FMS* es un software de código abierto que sirve para monitorear (monitorizar) y medir todo tipo de elementos. Monitoriza sistemas, aplicaciones o dispositivos de red. Permite conocer el estado de cada elemento de un sistema a lo largo del tiempo ya que dispone de histórico de datos y eventos. Pandora FMS está orientado a grandes entornos, y permite gestionar con y sin agentes, varios miles de sistemas, por lo que se puede emplear en grandes clusters, centros de datos y redes de todo tipo.

Este repositorio pretende facilitar la tarea de recoger metricas de las tareas programadas de SQL Server (Duración, tamaño, ultimo inicio...).


<!-- COMENZANDO -->


### Prerequisitos

En el servidor donde se ejecutan estos módulos, debe estar instalado el ejecutable sqlcmd.


### Instalacion

1. Clonar el repositorio en la carpeta de scripts de pandorafms. Desde una linea de comandos (Tecla Win + R) ... cmd + Enter
```sh
cd c:\
cd pandorafms
mkdir scripts
cd scripts
git clone https://github.com/franciscotudel-overtel/pandorafms_sql_server_tareas_programadas
```
2. Debemos editar el fichero SQLSERVER.INI para que contanga los datos de nuestro servidor.
```
[Host1]
BBDD_HOST=localhost
BBDD_USER=sa
BBDD_PASS=misuperpass
```
Si desde aqui hacemos consultas a otros servidores, añadir debajo como se puede ver a continuación.
```
[Host1]
BBDD_HOST=localhost
BBDD_USER=sa
BBDD_PASS=misuperpass
[Host2]
BBDD_HOST=1.2.3.4
BBDD_USER=sa2
BBDD_PASS=misuperpass2
```

<!-- USAGE EXAMPLES -->
## Ejemplos de uso

1. Debemos hacernos con la lista de tareas programadas de SQL Server con el siguiente comando desde una consola de ms-dos. En el siguiente ejemplo se puede ver como obtener la lista de tareas con su nombre, necesario para las posteriores llamadas al script de las tareas.
```sh
C:\pandorafms\scripts>MaintenancePlansList.cmd Host1

ESTADISTICAS-Subplán_1
COPIAS-Subplán_1
```
Esta es una lista de ejemplo.

2. Comenzar a poner modulos al agente, Cada consulta requiere de su pareja de scripts (cmd + sql).
```
module_begin
module_name SQL Server Jobs - ESTADISTICAS-Subplán_1 - JobLastExecutionDuration
module_type generic_data
module_exec c:\pandorafms\scripts\JobLastExecutionDuration.cmd Host1
module_description SQL Server Jobs - ESTADISTICAS-Subplán_1 - Duracion de la ultima ejecucion en Segundos
module_end
```

El script CMD lee el fichero ini donde estan las credenciales de SQL Server, luego llama a la consulta sql con esas credenciales y extrae el dato como resultado.


### Listado de tareas
Obtener listados de las tareas para su posterior uso en los modulos.

#### Todas las tareas
Lista todas las tareas programadas en SQL Server, en formato CSV.

```
module_begin
module_name SQL Server Jobs - Lista de Tareas
module_type generic_data_string
module_exec c:\pandorafms\scripts\MaintenancePlansList.cmd Host1
module_description SQL Server Jobs - Lista de Tareas
module_end
```


### Listado de metricas por cada tarea

A partir de aqui detallo todos los posibles usos del script para obtener metricas concretas de una tarea

Simplemente para recordar, [aqui](https://pandorafms.com/docs/index.php?title=Pandora:Documentation_es:Configuracion_Agentes#module_type_.3Ctipo.3E) en la sección 1.6.1.3 se detalla los tipos de modulos que pueden ser usados en un agente.

- *Numérico* (generic_data): Datos numéricos sencillos, con coma flotante o enteros.
- *Incremental* (generic_data_inc): Dato numérico igual a la diferencia entre el valor actual y el valor anterior dividida por el número de segundos transcurridos. Cuando esta diferencia es negativa, se reinicia el valor, esto significa que cuando la diferencia vuelva a ser positiva de nuevo se tomará el valor anterior siempre que el incremento vuelva a dar un valor positivo.
- *Absolute incremental* (generic_data_inc_abs): Dato numérico igual a la diferencia entre el valor actual y el valor anterior, sin realizar la división entre el número de segundos transcurridos, para medir incremento total en lugar de incremento por segundo. Cuando esta diferencia es negativa, se reinicia el valor, esto significa que cuando la diferencia de nuevo vuelva a ser positiva, se empleará el último valor desde el que el actual incremento obtenido da positivo.
- *Alfanumérico* (generic_data_string): Recoge cadenas de texto alfanuméricas.
- *Booleanos* (generic_proc): Para valores que solo pueden ser correcto o afirmativo (1) o incorrecto o negativo (0). Útil para comprobar si un equipo está vivo, o un proceso o servicio está corriendo. Un valor negativo (0) trae preasignado el estado crítico, mientras que cualquier valor superior se considerará correcto.
- *Alfanumérico asíncrono* (async_string): Para cadenas de texto de tipo asíncrono. La monitorización asíncrona depende de eventos o cambios que pueden ocurrir o no, por lo que este tipo de módulos nunca están en estado desconocido.
- *Booleano asíncrono* (async_proc): Para valores booleanos de tipo asíncrono.
- *Numérico asíncrono* (async_data): Para valores numéricos de tipo asíncrono.

#### Modulo JobLastResult
Obtener el resultado de ejecución de la última vez que se ejecuto la tarea.<br>
Según Microsoft:<br>
- 0: OK
- 1: MAL<br>

*Resultado:* entero

Ejemplo de uso:
```
module_begin
module_name SQL Server Jobs - ESTADISTICAS-Subplán_1 - JobLastResult
module_type generic_data
module_exec c:\pandorafms\scripts\JobLastResult.cmd Host1 ESTADISTICAS-Subplán_1
module_description SQL Server Jobs - ESTADISTICAS-Subplán_1 - Resultado de la ultima ejecucion
module_end
```

#### Modulo JobLastExecDuration
Obtener el tiempo de ejecución de la última vez que se ejecuto la tarea.<br>

*Resultado:* entero

Ejemplo de uso:
```
module_begin
module_name SQL Server Jobs - ESTADISTICAS-Subplán_1 - JobLastExecutionDuration
module_type generic_data
module_exec c:\pandorafms\scripts\JobLastExecutionDuration.cmd Host1 ESTADISTICAS-Subplán_1
module_description SQL Server Jobs - ESTADISTICAS-Subplán_1 - Duracion de la ultima ejecucion en Segundos
module_end
```

#### Modulo JobLastExec
Obtener en un string la fecha y hora de la última ejecución de la tarea.<br>

*Resultado:* string

Ejemplo de uso:
```
module_begin
module_name SQL Server Jobs - ESTADISTICAS-Subplán_1 - JobLastExec
module_type generic_data_string
module_exec c:\pandorafms\scripts\JobLastExec.cmd Host1 ESTADISTICAS-Subplán_1
module_description SQL Server Jobs - ESTADISTICAS-Subplán_1 - Fecha y hora de la última ejecución de la tarea
module_end
```

<!-- LICENCIA -->
## Licencia

Distribuido con the GNU General Public License v3.0. Ver `LICENSE` para mas informacion.


<!-- CONTACTO -->
## Contacto

- Project Link: [https://github.com/franciscotudel-overtel/pandorafms_sql_server_tareas_programadas](https://github.com/franciscotudel-overtel/pandorafms_sql_server_tareas_programadas)
- LinkedIn: [LinkedIn][linkedin-url]

<!-- AGRADECIMIENTOS -->
## Agradecimientos
* Horas de estudio y lectura de los ejemplos provistos por la comunidad.
* Nuestros compañeros expertos en SQL Server que han aguantado nuestras preguntas.


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/franciscotudel-overtel/pandorafms_sql_server_tareas_programadas.svg?style=flat-square
[contributors-url]: https://github.com/franciscotudel-overtel/pandorafms_sql_server_tareas_programadas/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/francisco-tudel-escalona-44076069/pandorafms_sql_server_tareas_programadas.svg?style=flat-square
[forks-url]: https://github.com/franciscotudel-overtel/pandorafms_sql_server_tareas_programadas/network/members
[stars-shield]: https://img.shields.io/github/stars/francisco-tudel-escalona-44076069/pandorafms_sql_server_tareas_programadas.svg?style=flat-square
[stars-url]: https://github.com/franciscotudel-overtel/pandorafms_sql_server_tareas_programadas/stargazers
[issues-shield]: https://img.shields.io/github/issues/francisco-tudel-escalona-44076069/pandorafms_sql_server_tareas_programadas.svg?style=flat-square
[issues-url]: https://github.com/franciscotudel-overtel/pandorafms_sql_server_tareas_programadas/issues
[license-shield]: https://img.shields.io/github/license/francisco-tudel-escalona-44076069/pandorafms_sql_server_tareas_programadas.svg?style=flat-square
[license-url]: https://github.com/franciscotudel-overtel/pandorafms_sql_server_tareas_programadas/blob/main/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/francisco-tudel-escalona-44076069

