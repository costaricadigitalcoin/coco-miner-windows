@echo Bienvenido al configurador del minado de Costa Rica Digital Coin
@echo.
@echo Requisitos:
@echo 1) Direccion de billetera de COCO (puedes obtenerla al registrarse en https://wallet.costaricadigitalcoin.com/)
@echo.
@echo 2) Algunos antivirus pueden detectar como Programa no deseado al programada de minado, en caso de que esto ocurra, por favor excluya al archivo minerd.exe de su antivirus
@echo.
@echo 3) Algunos firewall pueden bloquear la comunicacion entre su computadora y nuestro servidor, por favor permita las conexiones salientes a cpuminer-gw64-core2.exe
@echo.

@echo Por favor ingrese la direccion de su billetera para recibir los COCO minados
@echo off
set /p BILLETERA=
@echo.
if not "%BILLETERA:~34%" == "" (
    echo "La direccion ingresada es incorrecta, su direccion es la que se encuentra en el tablero de su wallet en el boton de recibir"
    pause 
    exit /b
)
if "%BILLETERA:~33%" == "" (
    echo "La direccion ingresada es incorrecta, su direccion es la que se encuentra en el tablero de su wallet en el boton de recibir"
    pause
    exit /b
)
@echo cpuminer-gw64-core2.exe -a x11 -o stratum+tcp://costaricadigitalcoin.com:3008 -u %BILLETERA% -p anything  > mine_pool.bat
SET ENTORNO=%PROCESSOR_ARCHITECTURE% 
if %ENTORNO% ==AMD64 powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.costaricadigitalcoin.com/wp-content/uploads/2020/12/cpuminer-windows.zip', 'cpuminer-windows.zip')"
if %ENTORNO% ==x86 powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.costaricadigitalcoin.com/wp-content/uploads/2020/12/cpuminer-windows.zip', 'cpuminer-windows.zip')"
@echo off
set mypath=%cd%
setlocal
cd /d %~dp0
Call :UnZipFile "%mypath%" "cpuminer-windows.zip"
exit /b

:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs% 
@echo off
@echo Billetera configurada correctamente
@echo.
@echo Nota: se ejecutara el archivo mine_pool.bat (ejecutar este archivo para futuros minados)
@echo.
@echo El minado  empezara en este momento
call mine_pool.bat
