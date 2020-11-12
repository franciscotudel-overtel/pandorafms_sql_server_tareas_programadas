@echo off
@setlocal EnableDelayedExpansion

@set BBDD_HOST=localhost
@set BBDD_USER=sa
@set BBDD_PASS=mipass

@set cpath=%~dp0 
@set cpath=%cpath:~0,-1%

@set COMANDO_SQLCMD=sqlcmd -S %BBDD_HOST% -U %BBDD_USER% -P %BBDD_PASS% -d MSDB -v TAREA=^"%*^" -i ^"%cpath%MaintenancePlansList.sql^" -W -s ^";^" -h-1
@FOR /F "tokens=* USEBACKQ" %%F IN (`%%COMANDO_SQLCMD%%`) DO (
  @echo %%F 
)

@set COMANDO_SQLCMD=
@set cpath=
@set BBDD_HOST=
@set BBDD_USER=
@set BBDD_PASS=
@set CONSULTA=