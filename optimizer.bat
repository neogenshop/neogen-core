@echo off
chcp 65001 >nul
title ULTRA GAME OPTIMIZER v2.0
color 0A
mode con cols=90 lines=35
setlocal enabledelayedexpansion

:: =========================
:: VERIFICAR ADMIN
:: =========================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [ERRO] Execute como Administrador!
    echo.
    echo Clique com botao direito no arquivo e selecione
    echo "Executar como administrador"
    echo.
    pause
    exit /b 1
)

:: =========================
:: MENU PRINCIPAL
:: =========================
:menu
cls
echo ==========================================================
echo              ULTRA GAME OPTIMIZER (ALL IN ONE)
echo ==========================================================
echo.
echo [1] APLICAR TODAS OTIMIZACOES (RECOMENDADO)
echo.
echo [2] Otimizacao de ENERGIA (CPU/GPU)
echo [3] Otimizacao de INPUT LAG (timer / sistema)
echo [4] Otimizacao de INTERNET (ping / jitter)
echo [5] Prioridade MAXIMA para JOGOS
echo [6] Mouse RAW (sem aceleracao)
echo [7] Tweaks ESPECIFICOS Fortnite
echo [8] Tweaks de GPU (NVIDIA / AMD auto)
echo [9] Verificar sistema e otimizacoes
echo.
echo [U] DESFAZER TODAS OTIMIZACOES (UNDO)
echo [0] SAIR
echo.
set /p op=Escolha uma opcao: 

if "%op%"=="1" goto all
if "%op%"=="2" goto energy
if "%op%"=="3" goto input
if "%op%"=="4" goto net
if "%op%"=="5" goto priority
if "%op%"=="6" goto mouse
if "%op%"=="7" goto fortnite
if "%op%"=="8" goto gpu
if "%op%"=="9" goto system_check
if /i "%op%"=="U" goto undo
if "%op%"=="0" goto sair
goto menu

:: =========================
:: APLICAR TUDO
:: =========================
:all
cls
echo ==========================================================
echo       APLICANDO TODAS AS OTIMIZACOES AUTOMATICAMENTE
echo ==========================================================
echo.
echo [1/7] Otimizando energia...
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg -h off >nul
echo ✓ Energia otimizada

echo [2/7] Otimizando input lag...
bcdedit /set useplatformclock true >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
bcdedit /set tscsyncpolicy Enhanced >nul 2>&1
echo ✓ Input lag otimizado

echo [3/7] Otimizando internet...
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul') do (
    reg add "%%i" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%i" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%i" /v TcpDelAckTicks /t REG_DWORD /d 0 /f >nul 2>&1
)
netsh int tcp set global autotuninglevel=normal >nul
netsh int tcp set global timestamps=disabled >nul
ipconfig /flushdns >nul
echo ✓ Internet otimizada

echo [4/7] Configurando prioridade de jogos...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 0xffffffff /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul 2>&1
echo ✓ Prioridade configurada

echo [5/7] Configurando mouse RAW...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1
echo ✓ Mouse RAW configurado

echo [6/7] Aplicando tweaks Fortnite...
reg add "HKCU\Software\Epic Games\Unreal Engine\Hardware Survey" /v DisableSurvey /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Epic Games\Unreal Engine\Performance" /v bSmoothFrameRate /t REG_DWORD /d 0 /f >nul 2>&1
echo ✓ Tweaks Fortnite aplicados

echo [7/7] Otimizando GPU...
wmic path win32_VideoController get name | find /i "NVIDIA" >nul
if !errorlevel!==0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v DisablePreemption /t REG_DWORD /d 1 /f >nul 2>&1
    echo ✓ NVIDIA otimizada
) else (
    wmic path win32_VideoController get name | find /i "AMD" >nul
    if !errorlevel!==0 (
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v DisableDMACopy /t REG_DWORD /d 1 /f >nul 2>&1
        echo ✓ AMD otimizada
    ) else (
        echo ⓘ GPU nao detectada ou drivers nao instalados
    )
)

echo.
echo ==========================================================
echo          TODAS AS OTIMIZACOES FORAM APLICADAS!
echo ==========================================================
echo.
echo REINICIE SEU COMPUTADOR para que todas as otimizacoes
echo tenham efeito completo.
echo.
pause
goto menu

:: =========================
:: ENERGIA
:: =========================
:energy
cls
echo ==========================================================
echo                OTIMIZACAO DE ENERGIA
echo ==========================================================
echo.
echo [1] Plano ULTRA PERFORMANCE (Maximo)
echo [2] Plano BALANCEADO (Recomendado)
echo [3] Desativar hibernacao
echo [4] Reativar hibernacao
echo [5] Voltar ao menu
echo.
set /p energy_op=Escolha: 

if "%energy_op%"=="1" (
    echo Aplicando plano de energia maximo...
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>nul
    powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
    echo ✓ Plano maximo aplicado
    pause
    goto menu
)
if "%energy_op%"=="2" (
    echo Aplicando plano balanceado...
    powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
    echo ✓ Plano balanceado aplicado
    pause
    goto menu
)
if "%energy_op%"=="3" (
    echo Desativando hibernacao...
    powercfg -h off
    echo ✓ Hibernacao desativada
    pause
    goto menu
)
if "%energy_op%"=="4" (
    echo Reativando hibernacao...
    powercfg -h on
    echo ✓ Hibernacao reativada
    pause
    goto menu
)
if "%energy_op%"=="5" goto menu
goto energy

:: =========================
:: INPUT LAG / TIMER
:: =========================
:input
cls
echo ==========================================================
echo             OTIMIZACAO DE INPUT LAG
echo ==========================================================
echo.
echo [1] Aplicar tweaks de timer (Recomendado)
echo [2] Reverter tweaks de timer
echo [3] Ver configuracoes atuais
echo [4] Voltar ao menu
echo.
set /p input_op=Escolha: 

if "%input_op%"=="1" (
    echo Aplicando tweaks de input lag...
    bcdedit /set useplatformclock true >nul
    bcdedit /set disabledynamictick yes >nul
    bcdedit /set tscsyncpolicy Enhanced >nul
    echo ✓ Tweaks aplicados - Reinicie o PC
    pause
    goto menu
)
if "%input_op%"=="2" (
    echo Revertendo tweaks...
    bcdedit /deletevalue useplatformclock >nul
    bcdedit /deletevalue disabledynamictick >nul
    bcdedit /deletevalue tscsyncpolicy >nul
    echo ✓ Tweaks revertidos - Reinicie o PC
    pause
    goto menu
)
if "%input_op%"=="3" (
    echo Configuracoes atuais:
    bcdedit | findstr "useplatformclock disabledynamictick tscsyncpolicy"
    pause
    goto input
)
if "%input_op%"=="4" goto menu
goto input

:: =========================
:: INTERNET
:: =========================
:net
cls
echo ==========================================================
echo              OTIMIZACAO DE INTERNET
echo ==========================================================
echo.
echo [1] Otimizar rede para jogos (Recomendado)
echo [2] Otimizar para streaming
echo [3] Resetar configuracoes de rede
echo [4] Ver configuracoes atuais
echo [5] Voltar ao menu
echo.
set /p net_op=Escolha: 

if "%net_op%"=="1" (
    echo Aplicando tweaks de internet para jogos...
    
    for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul') do (
        reg add "%%i" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
        reg add "%%i" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
        reg add "%%i" /v TcpDelAckTicks /t REG_DWORD /d 0 /f >nul 2>&1
    )
    
    netsh int tcp set global autotuninglevel=normal >nul
    netsh int tcp set global ecncapability=disabled >nul
    netsh int tcp set global timestamps=disabled >nul
    netsh int tcp set global rsc=disabled >nul
    netsh int tcp set global rss=enabled >nul
    netsh int tcp set global fastopen=enabled >nul
    
    ipconfig /flushdns >nul
    netsh winsock reset >nul
    
    echo ✓ Rede otimizada para jogos
    echo Reinicie o PC para efeito completo
    pause
    goto menu
)
if "%net_op%"=="2" (
    echo Otimizando para streaming...
    netsh int tcp set global autotuninglevel=restricted >nul
    netsh int tcp set global ecncapability=enabled >nul
    echo ✓ Otimizado para streaming
    pause
    goto menu
)
if "%net_op%"=="3" (
    echo Resetando configuracoes de rede...
    netsh int ip reset >nul
    netsh winsock reset >nul
    ipconfig /flushdns >nul
    echo ✓ Rede resetada - Reinicie o PC
    pause
    goto menu
)
if "%net_op%"=="4" (
    echo Configuracoes TCP atuais:
    netsh int tcp show global
    pause
    goto net
)
if "%net_op%"=="5" goto menu
goto net

:: =========================
:: PRIORIDADE DE JOGOS
:: =========================
:priority
cls
echo ==========================================================
echo            PRIORIDADE MAXIMA PARA JOGOS
echo ==========================================================
echo.
echo [1] Ativar prioridade maxima (Recomendado)
echo [2] Desativar prioridade
echo [3] Ver configuracoes atuais
echo [4] Voltar ao menu
echo.
set /p pri_op=Escolha: 

if "%pri_op%"=="1" (
    echo Ajustando prioridade maxima para jogos...
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 0xffffffff /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >nul
    echo ✓ Prioridade maxima ativada
    pause
    goto menu
)
if "%pri_op%"=="2" (
    echo Desativando prioridade...
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /f >nul
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /f >nul
    echo ✓ Prioridade desativada
    pause
    goto menu
)
if "%pri_op%"=="3" (
    echo Verificando configuracoes...
    reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex 2>nul && echo ✓ Prioridade ativa
    reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness 2>nul && echo ✓ Responsividade configurada
    pause
    goto priority
)
if "%pri_op%"=="4" goto menu
goto priority

:: =========================
:: MOUSE RAW
:: =========================
:mouse
cls
echo ==========================================================
echo             CONFIGURACAO DE MOUSE RAW
echo ==========================================================
echo.
echo [1] Desativar aceleracao do mouse (Recomendado)
echo [2] Reativar aceleracao padrao
echo [3] Ver configuracoes atuais
echo [4] Voltar ao menu
echo.
set /p mouse_op=Escolha: 

if "%mouse_op%"=="1" (
    echo Ajustando mouse para RAW INPUT...
    reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul
    echo ✓ Aceleracao desativada - Reinicie os jogos
    pause
    goto menu
)
if "%mouse_op%"=="2" (
    echo Reativando aceleracao padrao...
    reg delete "HKCU\Control Panel\Mouse" /v MouseSpeed /f >nul
    reg delete "HKCU\Control Panel\Mouse" /v MouseThreshold1 /f >nul
    reg delete "HKCU\Control Panel\Mouse" /v MouseThreshold2 /f >nul
    echo ✓ Configuracoes padrao restauradas
    pause
    goto menu
)
if "%mouse_op%"=="3" (
    echo Configuracoes atuais do mouse:
    reg query "HKCU\Control Panel\Mouse" /v MouseSpeed 2>nul || echo MouseSpeed: Nao configurado
    reg query "HKCU\Control Panel\Mouse" /v MouseThreshold1 2>nul || echo MouseThreshold1: Nao configurado
    reg query "HKCU\Control Panel\Mouse" /v MouseThreshold2 2>nul || echo MouseThreshold2: Nao configurado
    pause
    goto mouse
)
if "%mouse_op%"=="4" goto menu
goto mouse

:: =========================
:: FORTNITE
:: =========================
:fortnite
cls
echo ==========================================================
echo            TWEAKS ESPECIFICOS FORTNITE
echo ==========================================================
echo.
echo [1] Aplicar tweaks Fortnite (Recomendado)
echo [2] Remover tweaks Fortnite
echo [3] Voltar ao menu
echo.
set /p fn_op=Escolha: 

if "%fn_op%"=="1" (
    echo Aplicando tweaks especificos do Fortnite...
    reg add "HKCU\Software\Epic Games\Unreal Engine\Hardware Survey" /v DisableSurvey /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKCU\Software\Epic Games\Unreal Engine\Performance" /v bSmoothFrameRate /t REG_DWORD /d 0 /f >nul 2>&1
    echo ✓ Tweaks aplicados para Fortnite
    pause
    goto menu
)
if "%fn_op%"=="2" (
    echo Removendo tweaks...
    reg delete "HKCU\Software\Epic Games\Unreal Engine\Hardware Survey" /v DisableSurvey /f >nul 2>&1
    reg delete "HKCU\Software\Epic Games\Unreal Engine\Performance" /v bSmoothFrameRate /f >nul 2>&1
    echo ✓ Tweaks removidos
    pause
    goto menu
)
if "%fn_op%"=="3" goto menu
goto fortnite

:: =========================
:: GPU (AUTO)
:: =========================
:gpu
cls
echo ==========================================================
echo                 OTIMIZACAO DE GPU
echo ==========================================================
echo.
echo Detectando GPU...
echo.

wmic path win32_VideoController get name | find /i "NVIDIA" >nul
if !errorlevel!==0 (
    echo [✓] NVIDIA detectada
    echo.
    echo [1] Otimizar NVIDIA para jogos
    echo [2] Reverter otimizacoes NVIDIA
    echo [3] Voltar ao menu
    echo.
    set /p nvidia_op=Escolha: 
    
    if "%nvidia_op%"=="1" (
        echo Aplicando tweaks NVIDIA...
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v DisablePreemption /t REG_DWORD /d 1 /f >nul 2>&1
        echo ✓ NVIDIA otimizada - Reinicie o PC
        pause
        goto menu
    )
    if "%nvidia_op%"=="2" (
        echo Revertendo tweaks NVIDIA...
        reg delete "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v DisablePreemption /f >nul 2>&1
        echo ✓ Configuracoes revertidas
        pause
        goto menu
    )
    if "%nvidia_op%"=="3" goto menu
    goto gpu
)

wmic path win32_VideoController get name | find /i "AMD" >nul
if !errorlevel!==0 (
    echo [✓] AMD detectada
    echo.
    echo [1] Otimizar AMD para jogos
    echo [2] Reverter otimizacoes AMD
    echo [3] Voltar ao menu
    echo.
    set /p amd_op=Escolha: 
    
    if "%amd_op%"=="1" (
        echo Aplicando tweaks AMD...
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v DisableDMACopy /t REG_DWORD /d 1 /f >nul 2>&1
        echo ✓ AMD otimizada - Reinicie o PC
        pause
        goto menu
    )
    if "%amd_op%"=="2" (
        echo Revertendo tweaks AMD...
        reg delete "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v DisableDMACopy /f >nul 2>&1
        echo ✓ Configuracoes revertidas
        pause
        goto menu
    )
    if "%amd_op%"=="3" goto menu
    goto gpu
)

echo [i] Nenhuma GPU NVIDIA/AMD detectada ou drivers nao instalados
echo.
pause
goto menu

:: =========================
:: VERIFICAÇÃO DO SISTEMA
:: =========================
:system_check
cls
echo ==========================================================
echo                VERIFICACAO DO SISTEMA
echo ==========================================================
echo.
echo [INFORMACOES DO SISTEMA]
echo.
for /f "tokens=1,* delims=:" %%a in ('systeminfo ^| findstr /C:"Nome" /C:"Sistema" /C:"Processador"') do (
    echo %%a: %%b
)
echo.

echo [MEMORIA RAM]
set "total_memory=0"
for /f "tokens=2 delims==" %%a in ('wmic memorychip get capacity /value ^| find "Capacity"') do (
    set /a "total_memory+=%%a"
)
set /a "total_memory_gb=total_memory/1073741824"
echo Total RAM: !total_memory_gb! GB
echo.

echo [GPU DETECTADA]
wmic path win32_VideoController get name | findstr /v "Name"
echo.

echo [OTIMIZACOES ATIVAS]
echo -------------------
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex 2>nul && echo ✓ Prioridade de Jogos: ATIVA
powercfg /getactivescheme | find "Ultimate Performance" >nul && echo ✓ Plano Energia: ULTRA PERFORMANCE
powercfg /getactivescheme | find "Alto" >nul && echo ✓ Plano Energia: ALTA PERFORMANCE
bcdedit | find "useplatformclock" >nul && echo ✓ Timer otimizado
reg query "HKCU\Control Panel\Mouse" /v MouseSpeed 2>nul | find "0x0" >nul && echo ✓ Mouse RAW: ATIVO
echo.

echo [CONEXAO DE REDE]
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "IPv4"') do (
    echo IP: %%a
)
echo.
echo [1] Voltar ao menu
echo [2] Sair
echo.
set /p check_op=Escolha: 

if "%check_op%"=="1" goto menu
if "%check_op%"=="2" goto sair
goto system_check

:: =========================
:: DESFAZER TUDO
:: =========================
:undo
cls
echo ==========================================================
echo          DESFAZENDO TODAS AS ALTERACOES
echo ==========================================================
echo.
echo Tem certeza que deseja reverter todas as otimizacoes?
echo.
echo [1] SIM, reverter tudo
echo [2] NAO, voltar ao menu
echo.
set /p undo_op=Escolha: 

if "%undo_op%" neq "1" goto menu

echo Revertendo todas as alteracoes...
echo.

echo [1/7] Revertendo plano de energia...
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul
powercfg -h on >nul

echo [2/7] Revertendo tweaks de timer...
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
bcdedit /deletevalue tscsyncpolicy >nul 2>&1

echo [3/7] Revertendo prioridade de jogos...
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /f >nul 2>&1

echo [4/7] Revertendo configuracoes de rede...
netsh int ip reset >nul
netsh winsock reset >nul

echo [5/7] Revertendo configuracoes do mouse...
reg delete "HKCU\Control Panel\Mouse" /v MouseSpeed /f >nul 2>&1
reg delete "HKCU\Control Panel\Mouse" /v MouseThreshold1 /f >nul 2>&1
reg delete "HKCU\Control Panel\Mouse" /v MouseThreshold2 /f >nul 2>&1

echo [6/7] Revertendo tweaks Fortnite...
reg delete "HKCU\Software\Epic Games\Unreal Engine\Hardware Survey" /v DisableSurvey /f >nul 2>&1
reg delete "HKCU\Software\Epic Games\Unreal Engine\Performance" /v bSmoothFrameRate /f >nul 2>&1

echo [7/7] Revertendo tweaks GPU...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v DisablePreemption /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v DisableDMACopy /f >nul 2>&1

ipconfig /flushdns >nul
echo.
echo ✓ Todas as otimizacoes revertidas!
echo Reinicie o PC para concluir.
echo.
pause
goto menu

:: =========================
:: SAIR
:: =========================
:sair
cls
echo ==========================================================
echo        OBRIGADO POR USAR ULTRA GAME OPTIMIZER!
echo ==========================================================
echo.
echo Lembre-se de reiniciar o PC para aplicar
echo todas as otimizacoes completamente.
echo.
echo Desenvolvido para melhor performance em jogos
echo.
timeout /t 3 >nul
exit
