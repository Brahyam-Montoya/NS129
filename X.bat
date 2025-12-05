@echo off
setlocal

REM Carpeta donde Bat To Exe extrae los embebidos
set "EXTRACT_PATH=%APPDATA%"

REM (Opción A) Nombre fijo del MSI que embebes
set "INSTALLER_NAME=NSClient_123.0.16.2462_Windows.msi"
set "INSTALLER_PATH=%EXTRACT_PATH%\%INSTALLER_NAME%"

REM Si no está con nombre fijo, buscar por comodín dentro de %APPDATA%
if not exist "%INSTALLER_PATH%" (
  for /f "delims=" %%F in ('dir /b /s "%EXTRACT_PATH%\NSClient*.msi" 2^>nul') do (
    set "INSTALLER_PATH=%%~fF"
    goto :found
  )
)

:found
REM Verificar y ejecutar
if exist "%INSTALLER_PATH%" (
  echo Instalando desde "%INSTALLER_PATH%" ...
  msiexec /I "%INSTALLER_PATH%" host=addon-porvenir.goskope.com token=KcDx4xyOaaw8VMs1Mj mode=peruserconfig /norestart /qn /l*v %PUBLIC%\nscintall.log enrollauthtoken=a437f926621105380aa7a299ebeb645c
  set "RC=%ERRORLEVEL%"
  endlocal & exit /b %RC%
) else (
  echo ERROR: No se encontro el instalador en %EXTRACT_PATH%.
  endlocal & exit /b 1
)
