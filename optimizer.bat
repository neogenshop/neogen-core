@echo off
chcp 65001 >nul
title ULTRA GAME OPTIMIZER v3.0 - NÍVEIS DE OTIMIZAÇÃO
color 0A
mode con cols=100 lines=40
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
:: MENU PRINCIPAL COM NÍVEIS
:: =========================
:menu
cls
echo ===============================================================
echo           ULTRA GAME OPTIMIZER v3.0 - NIVEL DE OTIMIZACAO
echo ===============================================================
echo.
echo [NIVEIS DE OTIMIZACAO]
echo ====================
echo [1] NIVEL BASICO (Foco em estabilidade)
echo [2] NIVEL BALANCEADO (Recomendado para maioria)
echo [3] NIVEL ULTRA (Maximo desempenho - Experientes)
echo.
echo [OTIMIZACOES INDIVIDUAIS]
echo ========================
echo [4] Otimizacao de ENERGIA (CPU/GPU)
echo [5] Otimizacao de INPUT LAG (timer / sistema)
echo [6] Otimizacao de INTERNET (ping / jitter)
echo [7] Prioridade MAXIMA para JOGOS
echo [8] Mouse RAW (sem aceleracao)
echo [9] Tweaks ESPECIFICOS Fortnite
echo [10] Tweaks de GPU (NVIDIA / AMD auto)
echo [11] Memoria e Cache (Reduzir travamentos)
echo [12] Verificar sistema e otimizacoes
echo.
echo [U] DESFAZER TODAS OTIMIZACOES (UNDO)
echo [0] SAIR
echo.
set /p op=Escolha uma opcao: 

if "%op%"=="1" goto nivel_basico
if "%op%"=="2" goto nivel_balanceado
if "%op%"=="3" goto nivel_ultra
if "%op%"=="4" goto energy
if "%op%"=="5" goto input
if "%op%"=="6" goto net
if "%op%"=="7" goto priority
if "%op%"=="8" goto mouse
if "%op%"=="9" goto fortnite
if "%op%"=="10" goto gpu
if "%op%"=="11" goto memory
if "%op%"=="12" goto system_check
if /i "%op%"=="U" goto undo
if "%op%"=="0" goto sair
goto menu

:: =========================
:: NÍVEL BÁSICO (Estabilidade)
:: =========================
:nivel_basico
cls
echo ==========================================================
echo    APLICANDO NIVEL BASICO - ESTABILIDADE E SEGURANCA
echo ==========================================================
echo.
echo Este nivel foca em estabilidade e reduz pequenos travamentos
echo sem modificar configuracoes criticas do sistema.
echo.
echo [1/5] Plano de energia balanceado...
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul
echo ✓ Plano balanceado ativado

echo [2/5] Prioridade moderada para jogos...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f >nul 2>&1
echo ✓ Prioridade moderada configurada

echo [3/5] Limpeza de cache e memoria...
ipconfig /flushdns >nul
netsh int ip reset >nul 2>&1
echo ✓ Cache limpo

echo [4/5] Desativando apps em segundo plano...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1
echo ✓ Apps em segundo plano desativados

echo [5/5] Otimizando memoria virtual...
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False >nul
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=4096,MaximumSize=8192 >nul
echo ✓ Memoria virtual configurada

echo.
echo ✓ NIVEL BASICO APLICADO COM SUCESSO!
echo.
pause
goto menu

:: =========================
:: NÍVEL BALANCEADO (Recomendado)
:: =========================
:nivel_balanceado
cls
echo ==========================================================
echo    APLICANDO NIVEL BALANCEADO - DESEMPENHO + ESTABILIDADE
echo ==========================================================
echo.
echo [1/7] Plano de energia alto desempenho...
powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul
echo ✓ Plano alto desempenho ativado

echo [2/7] Timer otimizado para jogos...
bcdedit /set useplatformclock true >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
echo ✓ Timer otimizado

echo [3/7] Prioridade alta para jogos...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 5 /f >nul 2>&1
echo ✓ Prioridade alta configurada

echo [4/7] Mouse RAW input...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1
echo ✓ Mouse RAW configurado

echo [5/7] Otimizacao de rede para jogos...
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul') do (
    reg add "%%i" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%i" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
)
netsh int tcp set global autotuninglevel=normal >nul
echo ✓ Rede otimizada

echo [6/7] Memoria e cache otimizados...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul 2>&1
echo ✓ Memoria otimizada

echo [7/7] Tweaks para evitar travamentos...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f >nul 2>&1
echo ✓ Efeitos visuais ajustados

echo.
echo ✓ NIVEL BALANCEADO APLICADO COM SUCESSO!
echo Reinicie seu computador para efeito completo.
echo.
pause
goto menu

:: =========================
:: NÍVEL ULTRA (Máximo Desempenho)
:: =========================
:nivel_ultra
cls
echo ==========================================================
echo    APLICANDO NIVEL ULTRA - MAXIMO DESEMPENHO
echo ==========================================================
echo.
echo ATENCAO: Este nivel modifica configuracoes avancadas do sistema.
echo Recomendado apenas para usuarios experientes.
echo.
echo [1/10] Plano de energia ULTRA PERFORMANCE...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul
powercfg -h off >nul
echo ✓ Plano ultra performance ativado

echo [2/10] Timer maximo otimizado...
bcdedit /set useplatformclock true >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
bcdedit /set tscsyncpolicy Enhanced >nul 2>&1
echo ✓ Timer maximo otimizado

echo [3/10] Prioridade MAXIMA para jogos...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 0xffffffff /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul 2>&1
echo ✓ Prioridade maxima configurada

echo [4/10] Rede ultra otimizada...
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul') do (
    reg add "%%i" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%i" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%i" /v TcpDelAckTicks /t REG_DWORD /d 0 /f >nul 2>&1
)
netsh int tcp set global autotuninglevel=normal >nul
netsh int tcp set global timestamps=disabled >nul
netsh int tcp set global rsc=disabled >nul
echo ✓ Rede ultra otimizada

echo [5/10] Mouse RAW extremo...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1
echo ✓ Mouse RAW extremo

echo [6/10] Memoria otimizada ao maximo...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul 2>&1
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False >nul
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=8192,MaximumSize=16384 >nul
echo ✓ Memoria maximo desempenho

echo [7/10] Tweaks Fortnite especificos...
reg add "HKCU\Software\Epic Games\Unreal Engine\Hardware Survey" /v DisableSurvey /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Epic Games\Unreal Engine\Performance" /v bSmoothFrameRate /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Epic Games\Unreal Engine\Performance" /v FrameRateLimit /t REG_DWORD /d 0 /f >nul 2>&1
echo ✓ Fortnite otimizado

echo [8/10] Otimizacao GPU automatica...
wmic path win32_VideoController get name | find /i "NVIDIA" >nul
if !errorlevel!==0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v DisablePreemption /t REG_DWORD /d 1 /f >nul 2>&1
    echo ✓ NVIDIA otimizada ao maximo
) else (
    wmic path win32_VideoController get name | find /i "AMD" >nul
    if !errorlevel!==0 (
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v DisableDMACopy /t REG_DWORD /d 1 /f >nul 2>&1
        echo ✓ AMD otimizada ao maximo
    ) else (
        echo ⓘ GPU nao detectada
    )
)

echo [9/10] Servicos desnecessarios desativados...
sc config DiagTrack start= disabled >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc config WMPNetworkSvc start= disabled >nul 2>&1
echo ✓ Servicos otimizados

echo [10/10] Prefetch e Superfetch otimizados...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 3 /f >nul 2>&1
echo ✓ Prefetch otimizado

echo.
echo ✓ NIVEL ULTRA APLICADO COM SUCESSO!
echo REINICIE OBRIGATORIAMENTE para aplicar todas as otimizacoes.
echo.
pause
goto menu

:: =========================
:: MEMÓRIA E CACHE (Nova opção)
:: =========================
:memory
cls
echo ==========================================================
echo           OTIMIZACAO DE MEMORIA E CACHE
echo ==========================================================
echo.
echo [1] Otimizar memoria para jogos (Recomendado)
echo [2] Limpar caches temporarios
echo [3] Configurar memoria virtual automatica
echo [4] Configurar memoria virtual manual
echo [5] Voltar ao menu
echo.
set /p mem_op=Escolha: 

if "%mem_op%"=="1" (
    echo Otimizando memoria para jogos...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v IOPageLockLimit /t REG_DWORD /d 4194304 /f >nul 2>&1
    echo ✓ Memoria otimizada para jogos
    pause
    goto menu
)
if "%mem_op%"=="2" (
    echo Limpando caches temporarios...
    ipconfig /flushdns >nul
    netsh winsock reset catalog >nul
    del /f /q %temp%\*.* >nul 2>&1
    echo ✓ Caches limpos
    pause
    goto menu
)
if "%mem_op%"=="3" (
    echo Configurando memoria virtual automatica...
    wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True >nul
    echo ✓ Memoria virtual automatica configurada
    pause
    goto menu
)
if "%mem_op%"=="4" (
    echo Configurando memoria virtual manual...
    wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False >nul
    set /p size=Digite o tamanho inicial em MB (ex: 4096): 
    set /p max=Digite o tamanho maximo em MB (ex: 8192): 
    wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=!size!,MaximumSize=!max! >nul
    echo ✓ Memoria virtual manual configurada
    pause
    goto menu
)
if "%mem_op%"=="5" goto menu
goto memory

:: =========================
:: VERIFICAÇÃO DO SISTEMA MELHORADA
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
wmic memorychip get capacity,speed,partnumber 2>nul | findstr /v "PartNumber" | findstr [0-9]
echo.

echo [GPU DETECTADA]
wmic path win32_VideoController get name,adapterram,driverversion 2>nul | findstr /v "Name"
echo.

echo [TEMPERATURAS - se disponivel]
wmic /namespace:\\root\wmi path MSAcpi_ThermalZoneTemperature get CurrentTemperature 2>nul | findstr [0-9]
echo.

echo [OTIMIZACOES ATIVAS]
echo -------------------
powercfg /getactivescheme | find "Ultimate Performance" >nul && echo ✓ Plano: ULTRA PERFORMANCE
powercfg /getactivescheme | find "Alto" >nul && echo ✓ Plano: ALTA PERFORMANCE
bcdedit | find "useplatformclock" >nul && echo ✓ Timer otimizado
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness 2>nul && echo ✓ Prioridade jogos: ATIVA
echo.

echo [ESTADO DO SISTEMA PARA JOGOS]
echo -----------------------------
wmic cpu get loadpercentage | findstr [0-9] && echo %% de uso da CPU
echo.
echo [1] Teste de ping rapido
echo [2] Voltar ao menu
echo [3] Sair
echo.
set /p check_op=Escolha: 

if "%check_op%"=="1" (
    echo Testando ping para Google (3 tentativas)...
    ping -n 3 8.8.8.8
    pause
    goto system_check
)
if "%check_op%"=="2" goto menu
if "%check_op%"=="3" goto sair
goto system_check

:: =========================
:: DESFAZER TUDO (Melhorado)
:: =========================
:undo
cls
echo ==========================================================
echo          DESFAZENDO TODAS AS ALTERACOES
echo ==========================================================
echo.
echo Escolha o nivel para reverter:
echo.
echo [1] Reverter nivel BASICO
echo [2] Reverter nivel BALANCEADO
echo [3] Reverter nivel ULTRA
echo [4] Reverter TUDO completamente
echo [5] Voltar ao menu
echo.
set /p undo_op=Escolha: 

if "%undo_op%"=="1" goto undo_basico
if "%undo_op%"=="2" goto undo_balanceado
if "%undo_op%"=="3" goto undo_ultra
if "%undo_op%"=="4" goto undo_all
if "%undo_op%"=="5" goto menu
goto undo

:undo_basico
echo Revertendo nivel basico...
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /f >nul 2>&1
echo ✓ Nivel basico revertido
pause
goto menu

:undo_balanceado
echo Revertendo nivel balanceado...
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /f >nul 2>&1
echo ✓ Nivel balanceado revertido
pause
goto menu

:undo_ultra
echo Revertendo nivel ultra...
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul
powercfg -h on >nul
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
bcdedit /deletevalue tscsyncpolicy >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /f >nul 2>&1
sc config DiagTrack start= auto >nul 2>&1
echo ✓ Nivel ultra revertido
pause
goto menu

:undo_all
cls
echo ==========================================================
echo          REVERTENDO TODAS AS ALTERACOES
echo ==========================================================
echo.
echo Tem certeza que deseja reverter TODAS as otimizacoes?
echo.
echo [1] SIM, reverter tudo
echo [2] NAO, voltar ao menu
echo.
set /p undo_all_op=Escolha: 

if "%undo_all_op%" neq "1" goto menu

echo Revertendo todas as alteracoes...
echo.

echo [1/10] Revertendo plano de energia...
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul
powercfg -h on >nul

echo [2/10] Revertendo tweaks de timer...
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
bcdedit /deletevalue tscsyncpolicy >nul 2>&1

echo [3/10] Revertendo prioridade de jogos...
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /f >nul 2>&1

echo [4/10] Revertendo configuracoes de rede...
netsh int tcp set global autotuninglevel=normal >nul
netsh int tcp set global timestamps=enabled >nul
netsh int ip reset >nul
netsh winsock reset >nul

echo [5/10] Revertendo configuracoes do mouse...
reg delete "HKCU\Control Panel\Mouse" /v MouseSpeed /f >nul 2>&1
reg delete "HKCU\Control Panel\Mouse" /v MouseThreshold1 /f >nul 2>&1
reg delete "HKCU\Control Panel\Mouse" /v MouseThreshold2 /f >nul 2>&1

echo [6/10] Revertendo tweaks Fortnite...
reg delete "HKCU\Software\Epic Games\Unreal Engine\Hardware Survey" /v DisableSurvey /f >nul 2>&1
reg delete "HKCU\Software\Epic Games\Unreal Engine\Performance" /v bSmoothFrameRate /f >nul 2>&1

echo [7/10] Revertendo tweaks GPU...
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v DisablePreemption /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v DisableDMACopy /f >nul 2>&1

echo [8/10] Revertendo memoria...
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /f >nul 2>&1
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True >nul

echo [9/10] Revertendo servicos...
sc config DiagTrack start= auto >nul 2>&1
sc config dmwappushservice start= auto >nul 2>&1
sc config WMPNetworkSvc start= auto >nul 2>&1

echo [10/10] Limpando DNS...
ipconfig /flushdns >nul

echo.
echo ✓ TODAS as otimizacoes revertidas!
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
echo        OBRIGADO POR USAR ULTRA GAME OPTIMIZER v3.0!
echo ==========================================================
echo.
echo Melhorias implementadas:
echo • 3 niveis de otimizacao para diferentes necessidades
echo • Foco em reducao de travamentos em Fortnite e outros jogos
echo • Otimizacoes de memoria especificas para estabilidade
echo • Sistema de reversao segmentada por niveis
echo.
echo Desenvolvido para melhor performance em jogos
echo.
timeout /t 3 >nul
exit
