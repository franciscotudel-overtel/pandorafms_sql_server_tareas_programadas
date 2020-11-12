@echo off
@setlocal

@SET DEBUG=0

@set BBDD_HOST=
@set BBDD_USER=
@set BBDD_PASS=
@set HOST=

@set cpath=%~dp0 
@set cpath=%cpath:~0,-1%

@SET INIREAD=%cpath%ini.cmd
@SET INIFILE=%cpath%SQLSERVER.ini

@if NOT exist %INIREAD% ( @echo %INIREAD%_NOT_FOUND & @GOTO FIN )
@if NOT exist %INIFILE% ( @echo %INIFILE%_NOT_FOUND & @GOTO FIN )
@if "%~1"=="" @goto FIN
@IF "%~1"=="HELP" @call :AYUDA
@set HOST=%~1

:: Leer fichero ini
for /f "delims=" %%a in ('call %INIREAD% %INIFILE% /s %HOST% /i BBDD_HOST') do (
    @set BBDD_HOST=%%a
)

for /f "delims=" %%a in ('call %INIREAD% %INIFILE% /s %HOST% /i BBDD_USER') do (
    @set BBDD_USER=%%a
)

for /f "delims=" %%a in ('call %INIREAD% %INIFILE% /s %HOST% /i BBDD_PASS') do (
    @set BBDD_PASS=%%a
)

@if %DEBUG% EQU 1 (
  @echo HOST=%HOST%
  @echo BBDD_HOST=%BBDD_HOST%
  @echo BBDD_USER=%BBDD_USER%
  @echo BBDD_PASS=%BBDD_PASS%
  @echo INIREAD=%INIREAD%
  @echo INIFILE=%INIFILE%
)


@set COMANDO_SQL=sqlcmd -S %BBDD_HOST% -U %BBDD_USER% -P %BBDD_PASS% -d MSDB -v TAREA=^"%2 %3 %4 %5^" -i ^"%cpath%MaintenancePlansList.sql^" -W -s ^";^" -h-1
@FOR /F "tokens=* USEBACKQ" %%F IN (`%%COMANDO_SQL%%`) DO (
	@echo %%F 
)
@set COMANDO_SQL=

@GOTO FIN

:FIN
@set cpath=
@set BBDD_HOST=
@set BBDD_USER=
@set BBDD_PASS=
exit /b

:AYUDA
@echo Los datos de la conexion a SQL Server se guardan en un fichero llamado SQLSERVER.INI en la carpeta del script
@echo [Host1]
@echo BBDD_HOST=a.b.c.d
@echo BBDD_USER=bla
@echo BBDD_PASS=ble
@echo El script se llama con dos parametros nombre.cmd Host1 Plan de mantenimiento x
@echo Donde Host1 es el bloque de datos en el fichero ini en donde se leen la ip, user y pass del servidor sql 
@echo y Plan de mantenimiento es el nombre del plan de mantenimiento.
@echo Ojo! si el nombre tiene espacios, solo se admiten 3 bloques separados por 2 espacios
@exit /b 0




