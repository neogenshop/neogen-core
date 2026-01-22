@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
title Neo Generation - Windows 11 Optimizer
color 0A

:: ===============================
:: VERIFICAR ADMIN
:: ===============================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Reabrindo como Administrador...
    powershell -command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:: ===============================
:: LOADING (10s)
:: ===============================
cls
set load=□□□□□□□□□□
for /L %%i in (1,1,10) do (
    cls
    echo Neo Generation Optimizer
    echo Inicializando sistema...
    set load=!load:□=■!
    echo [!load!]
    timeout /t 1 >nul
)

:: ===============================
:: MENU PRINCIPAL
:: ===============================
:MENU
cls
echo ================================
echo   NEO GENERATION OPTIMIZER
echo ================================
echo.
echo [1] Criar ponto de restauracao
echo [2] Otimizacao de alto desempenho
echo [3] Tweaks de Internet e Latencia
echo [4] Remover Apps Inuteis
echo [5] Otimizacao de Servicos
echo [6] Limpeza de Sistema
echo [7] Otimizacao de Input Lag
echo [0] Sair
echo.
set /p opt=Escolha uma opcao:

if "%opt%"=="1" goto RESTORE
if "%opt%"=="2" goto PERFORMANCE
if "%opt%"=="3" goto INTERNET
if "%opt%"=="4" goto APPS
if "%opt%"=="5" goto SERVICES
if "%opt%"=="6" goto CLEAN
if "%opt%"=="7" goto INPUTMENU
if "%opt%"=="0" exit
goto MENU

:: ===============================
:: RESTORE POINT
:: ===============================
:RESTORE
cls
echo Criando ponto de restauracao...
powershell -command "Checkpoint-Computer -Description 'NeoGenerationOptimizer' -RestorePointType MODIFY_SETTINGS"
echo Concluido.
pause
goto MENU

:: ===============================
:: PERFORMANCE
:: ===============================
:PERFORMANCE
cls
echo === ALTO DESEMPENHO ===
powercfg -setactive SCHEME_MIN
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v GPU Priority /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
echo OK.
pause
goto MENU

:: ===============================
:: INTERNET
:: ===============================
:INTERNET
cls
echo === INTERNET / LATENCIA ===
ipconfig /flushdns
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global ecncapability=disabled
netsh int tcp set global timestamps=disabled
echo OK.
pause
goto MENU

:: ===============================
:: APPS
:: ===============================
:APPS
cls
echo [1] Xbox
echo [2] Bing
echo [3] Weather / News
echo [4] Widgets
echo [5] Clipchamp
echo [6] TODOS
echo [0] Voltar
set /p a=Opcao:

if "%a%"=="1" powershell -command "Get-AppxPackage *xbox* | Remove-AppxPackage"
if "%a%"=="2" powershell -command "Get-AppxPackage *bing* | Remove-AppxPackage"
if "%a%"=="3" powershell -command "Get-AppxPackage *weather* | Remove-AppxPackage; Get-AppxPackage *news* | Remove-AppxPackage"
if "%a%"=="4" powershell -command "Get-AppxPackage *widgets* | Remove-AppxPackage"
if "%a%"=="5" powershell -command "Get-AppxPackage *clipchamp* | Remove-AppxPackage"
if "%a%"=="6" (
 powershell -command "Get-AppxPackage *xbox* | Remove-AppxPackage"
 powershell -command "Get-AppxPackage *bing* | Remove-AppxPackage"
 powershell -command "Get-AppxPackage *weather* | Remove-AppxPackage"
 powershell -command "Get-AppxPackage *news* | Remove-AppxPackage"
 powershell -command "Get-AppxPackage *widgets* | Remove-AppxPackage"
 powershell -command "Get-AppxPackage *clipchamp* | Remove-AppxPackage"
)
pause
goto MENU

:: ===============================
:: SERVICES
:: ===============================
:SERVICES
cls
sc stop Fax >nul & sc config Fax start=disabled
sc stop MapsBroker >nul & sc config MapsBroker start=disabled
sc stop RetailDemo >nul & sc config RetailDemo start=disabled
echo Servicos otimizados.
pause
goto MENU

:: ===============================
:: CLEAN
:: ===============================
:CLEAN
cls
del /s /q %temp%\* >nul 2>&1
del /s /q C:\Windows\Temp\* >nul 2>&1
echo Limpeza feita.
pause
goto MENU

:: ===============================
:: INPUT LAG MENU
:: ===============================
:INPUTMENU
cls
echo === INPUT LAG ===
echo [1] Basico (Seguro)
echo [2] Competitivo (Recomendado)
echo [3] Extreme (Aviso)
echo [0] Voltar
set /p il=Opcao:

if "%il%"=="1" goto IL_BASIC
if "%il%"=="2" goto IL_COMP
if "%il%"=="3" goto IL_EXTREME
if "%il%"=="0" goto MENU
goto INPUTMENU

:IL_BASIC
cls
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d 0 /f
echo Input Lag Basico aplicado.
pause
goto MENU

:IL_COMP
cls
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_SZ /d 31 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f
echo Input Lag Competitivo aplicado.
pause
goto MENU

:IL_EXTREME
cls
echo AVISO: Pode impactar uso diario.
pause
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Scheduling Category /t REG_SZ /d High /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v SFIO Priority /t REG_SZ /d High /f
echo Input Lag EXTREME aplicado.
pause
goto MENU
@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
title Neo Generation - Windows 11 Optimizer
color 0A

:: ===============================
:: VERIFICAR ADMIN
:: ===============================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Reabrindo como Administrador...
    powershell -command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:: ===============================
:: LOADING (10s)
:: ===============================
cls
set load=□□□□□□□□□□
for /L %%i in (1,1,10) do (
    cls
    echo Neo Generation Optimizer
    echo Inicializando sistema...
    set load=!load:□=■!
    echo [!load!]
    timeout /t 1 >nul
)

:: ===============================
:: MENU PRINCIPAL
:: ===============================
:MENU
cls
echo ================================
echo   NEO GENERATION OPTIMIZER
echo ================================
echo.
echo [1] Criar ponto de restauracao
echo [2] Otimizacao de alto desempenho
echo [3] Tweaks de Internet e Latencia
echo [4] Remover Apps Inuteis
echo [5] Otimizacao de Servicos
echo [6] Limpeza de Sistema
echo [7] Otimizacao de Input Lag
echo [0] Sair
echo.
set /p opt=Escolha uma opcao:

if "%opt%"=="1" goto RESTORE
if "%opt%"=="2" goto PERFORMANCE
if "%opt%"=="3" goto INTERNET
if "%opt%"=="4" goto APPS
if "%opt%"=="5" goto SERVICES
if "%opt%"=="6" goto CLEAN
if "%opt%"=="7" goto INPUTMENU
if "%opt%"=="0" exit
goto MENU

:: ===============================
:: RESTORE POINT
:: ===============================
:RESTORE
cls
echo Criando ponto de restauracao...
powershell -command "Checkpoint-Computer -Description 'NeoGenerationOptimizer' -RestorePointType MODIFY_SETTINGS"
echo Concluido.
pause
goto MENU

:: ===============================
:: PERFORMANCE
:: ===============================
:PERFORMANCE
cls
echo === ALTO DESEMPENHO ===
powercfg -setactive SCHEME_MIN
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v GPU Priority /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
echo OK.
pause
goto MENU

:: ===============================
:: INTERNET
:: ===============================
:INTERNET
cls
echo === INTERNET / LATENCIA ===
ipconfig /flushdns
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global ecncapability=disabled
netsh int tcp set global timestamps=disabled
echo OK.
pause
goto MENU

:: ===============================
:: APPS
:: ===============================
:APPS
cls
echo [1] Xbox
echo [2] Bing
echo [3] Weather / News
echo [4] Widgets
echo [5] Clipchamp
echo [6] TODOS
echo [0] Voltar
set /p a=Opcao:

if "%a%"=="1" powershell -command "Get-AppxPackage *xbox* | Remove-AppxPackage"
if "%a%"=="2" powershell -command "Get-AppxPackage *bing* | Remove-AppxPackage"
if "%a%"=="3" powershell -command "Get-AppxPackage *weather* | Remove-AppxPackage; Get-AppxPackage *news* | Remove-AppxPackage"
if "%a%"=="4" powershell -command "Get-AppxPackage *widgets* | Remove-AppxPackage"
if "%a%"=="5" powershell -command "Get-AppxPackage *clipchamp* | Remove-AppxPackage"
if "%a%"=="6" (
 powershell -command "Get-AppxPackage *xbox* | Remove-AppxPackage"
 powershell -command "Get-AppxPackage *bing* | Remove-AppxPackage"
 powershell -command "Get-AppxPackage *weather* | Remove-AppxPackage"
 powershell -command "Get-AppxPackage *news* | Remove-AppxPackage"
 powershell -command "Get-AppxPackage *widgets* | Remove-AppxPackage"
 powershell -command "Get-AppxPackage *clipchamp* | Remove-AppxPackage"
)
pause
goto MENU

:: ===============================
:: SERVICES
:: ===============================
:SERVICES
cls
sc stop Fax >nul & sc config Fax start=disabled
sc stop MapsBroker >nul & sc config MapsBroker start=disabled
sc stop RetailDemo >nul & sc config RetailDemo start=disabled
echo Servicos otimizados.
pause
goto MENU

:: ===============================
:: CLEAN
:: ===============================
:CLEAN
cls
del /s /q %temp%\* >nul 2>&1
del /s /q C:\Windows\Temp\* >nul 2>&1
echo Limpeza feita.
pause
goto MENU

:: ===============================
:: INPUT LAG MENU
:: ===============================
:INPUTMENU
cls
echo === INPUT LAG ===
echo [1] Basico (Seguro)
echo [2] Competitivo (Recomendado)
echo [3] Extreme (Aviso)
echo [0] Voltar
set /p il=Opcao:

if "%il%"=="1" goto IL_BASIC
if "%il%"=="2" goto IL_COMP
if "%il%"=="3" goto IL_EXTREME
if "%il%"=="0" goto MENU
goto INPUTMENU

:IL_BASIC
cls
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d 0 /f
echo Input Lag Basico aplicado.
pause
goto MENU

:IL_COMP
cls
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_SZ /d 31 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f
echo Input Lag Competitivo aplicado.
pause
goto MENU

:IL_EXTREME
cls
echo AVISO: Pode impactar uso diario.
pause
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Scheduling Category /t REG_SZ /d High /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v SFIO Priority /t REG_SZ /d High /f
echo Input Lag EXTREME aplicado.
pause
goto MENU
