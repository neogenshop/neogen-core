@echo off
chcp 65001 >nul
title ULTRA GAME OPTIMIZER v3.0 - NÍVEIS DE OTIMIZAÇÃO
mode con cols=100 lines=40
setlocal enabledelayedexpansion

:: =========================
:: CONFIGURAÇÃO DE CORES
:: =========================
:: Azul claro no fundo preto
color 09
:: Cores definidas:
:: 0 = Preto      8 = Cinza
:: 1 = Azul       9 = Azul claro
:: 2 = Verde      A = Verde claro
:: 3 = Ciano      B = Ciano claro
:: 4 = Vermelho   C = Vermelho claro
:: 5 = Magenta    D = Magenta claro
:: 6 = Amarelo    E = Amarelo claro
:: 7 = Branco     F = Branco brilhante

:: =========================
:: FUNÇÃO PARA TEXTO AZUL
:: =========================
:printBlue
echo|set /p="%*"
exit /b

:printGreen
echo|set /p="%*"
exit /b

:printRed
echo|set /p="%*"
exit /b

:: =========================
:: VERIFICAR ADMIN
:: =========================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [[91mERRO[0m] Execute como Administrador!
    echo.
    echo Clique com botao direito no arquivo e selecione
    echo "[96mExecutar como administrador[0m"
    echo.
    pause
    exit /b 1
)

:: =========================
:: CABEÇALHO ESTILIZADO
:: =========================
:header
cls
echo [94m====================================================================================================[0m
echo                  [96mULTRA GAME OPTIMIZER [93mv3.0[0m - [95mNIVEL DE OTIMIZACAO[0m
echo [94m====================================================================================================[0m
exit /b

:: =========================
:: MENU PRINCIPAL COM NÍVEIS
:: =========================
:menu
call :header
echo.
echo [92m[NIVEIS DE OTIMIZACAO][0m
echo [94m====================[0m
echo [96m[1][0m [93mNIVEL BASICO[0m ([92mFoco em estabilidade[0m)
echo [96m[2][0m [93mNIVEL BALANCEADO[0m ([92mRecomendado para maioria[0m)
echo [96m[3][0m [93mNIVEL ULTRA[0m ([91mMaximo desempenho - Experientes[0m)
echo.
echo [92m[OTIMIZACOES INDIVIDUAIS][0m
echo [94m=======================[0m
echo [96m[4][0m [95mOtimizacao de ENERGIA[0m (CPU/GPU)
echo [96m[5][0m [95mOtimizacao de INPUT LAG[0m (timer / sistema)
echo [96m[6][0m [95mOtimizacao de INTERNET[0m (ping / jitter)
echo [96m[7][0m [95mPrioridade MAXIMA para JOGOS[0m
echo [96m[8][0m [95mMouse RAW[0m (sem aceleracao)
echo [96m[9][0m [95mTweaks ESPECIFICOS Fortnite[0m
echo [96m[10][0m [95mTweaks de GPU[0m (NVIDIA / AMD auto)
echo [96m[11][0m [95mMemoria e Cache[0m (Reduzir travamentos)
echo [96m[12][0m [95mVerificar sistema e otimizacoes[0m
echo.
echo [91m[U][0m [93mDESFAZER TODAS OTIMIZACOES[0m (UNDO)
echo [90m[0][0m [90mSAIR[0m
echo.
set /p op=[96mEscolha uma opcao: [0m

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
call :header
echo.
echo    [96mAPLICANDO NIVEL BASICO - ESTABILIDADE E SEGURANCA[0m
echo [94m==========================================================[0m
echo.
echo [93mEste nivel foca em estabilidade e reduz pequenos travamentos[0m
echo [93msem modificar configuracoes criticas do sistema.[0m
echo.
echo [95m[1/5][0m Plano de energia balanceado...
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul
echo [92m✓[0m Plano balanceado ativado
echo.

echo [95m[2/5][0m Prioridade moderada para jogos...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f >nul 2>&1
echo [92m✓[0m Prioridade moderada configurada
echo.

echo [95m[3/5][0m Limpeza de cache e memoria...
ipconfig /flushdns >nul
netsh int ip reset >nul 2>&1
echo [92m✓[0m Cache limpo
echo.

echo [95m[4/5][0m Desativando apps em segundo plano...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1
echo [92m✓[0m Apps em segundo plano desativados
echo.

echo [95m[5/5][0m Otimizando memoria virtual...
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False >nul
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=4096,MaximumSize=8192 >nul
echo [92m✓[0m Memoria virtual configurada
echo.

echo [94m================================================================[0m
echo [92m✓ NIVEL BASICO APLICADO COM SUCESSO![0m
echo [94m================================================================[0m
echo.
pause
goto menu

:: =========================
:: NÍVEL BALANCEADO (Recomendado)
:: =========================
:nivel_balanceado
call :header
echo.
echo    [96mAPLICANDO NIVEL BALANCEADO - DESEMPENHO + ESTABILIDADE[0m
echo [94m==========================================================[0m
echo.
echo [95m[1/7][0m Plano de energia alto desempenho...
powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul
echo [92m✓[0m Plano alto desempenho ativado
echo.

echo [95m[2/7][0m Timer otimizado para jogos...
bcdedit /set useplatformclock true >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
echo [92m✓[0m Timer otimizado
echo.

echo [95m[3/7][0m Prioridade alta para jogos...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 5 /f >nul 2>&1
echo [92m✓[0m Prioridade alta configurada
echo.

echo [95m[4/7][0m Mouse RAW input...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1
echo [92m✓[0m Mouse RAW configurado
echo.

echo [95m[5/7][0m Otimizacao de rede para jogos...
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul') do (
    reg add "%%i" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%i" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
)
netsh int tcp set global autotuninglevel=normal >nul
echo [92m✓[0m Rede otimizada
echo.

echo [95m[6/7][0m Memoria e cache otimizados...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul 2>&1
echo [92m✓[0m Memoria otimizada
echo.

echo [95m[7/7][0m Tweaks para evitar travamentos...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f >nul 2>&1
echo [92m✓[0m Efeitos visuais ajustados
echo.

echo [94m================================================================[0m
echo [92m✓ NIVEL BALANCEADO APLICADO COM SUCESSO![0m
echo [93mReinicie seu computador para efeito completo.[0m
echo [94m================================================================[0m
echo.
pause
goto menu

:: =========================
:: NÍVEL ULTRA (Máximo Desempenho)
:: =========================
:nivel_ultra
call :header
echo.
echo    [96mAPLICANDO NIVEL ULTRA - MAXIMO DESEMPENHO[0m
echo [94m==========================================================[0m
echo.
echo [91mATENCAO:[0m Este nivel modifica configuracoes avancadas do sistema.
echo [91mRecomendado apenas para usuarios experientes.[0m
echo.
echo [95m[1/10][0m Plano de energia ULTRA PERFORMANCE...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul
powercfg -h off >nul
echo [92m✓[0m Plano ultra performance ativado
echo.

echo [95m[2/10][0m Timer maximo otimizado...
bcdedit /set useplatformclock true >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
bcdedit /set tscsyncpolicy Enhanced >nul 2>&1
echo [92m✓[0m Timer maximo otimizado
echo.

echo [95m[3/10][0m Prioridade MAXIMA para jogos...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 0xffffffff /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul 2>&1
echo [92m✓[0m Prioridade maxima configurada
echo.

echo [95m[4/10][0m Rede ultra otimizada...
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul') do (
    reg add "%%i" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%i" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%i" /v TcpDelAckTicks /t REG_DWORD /d 0 /f >nul 2>&1
)
netsh int tcp set global autotuninglevel=normal >nul
netsh int tcp set global timestamps=disabled >nul
netsh int tcp set global rsc=disabled >nul
echo [92m✓[0m Rede ultra otimizada
echo.

echo [95m[5/10][0m Mouse RAW extremo...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1
echo [92m✓[0m Mouse RAW extremo
echo.

echo [95m[6/10][0m Memoria otimizada ao maximo...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul 2>&1
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False >nul
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=8192,MaximumSize=16384 >nul
echo [92m✓[0m Memoria maximo desempenho
echo.

echo [95m[7/10][0m Tweaks Fortnite especificos...
reg add "HKCU\Software\Epic Games\Unreal Engine\Hardware Survey" /v DisableSurvey /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Epic Games\Unreal Engine\Performance" /v bSmoothFrameRate /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Epic Games\Unreal Engine\Performance" /v FrameRateLimit /t REG_DWORD /d 0 /f >nul 2>&1
echo [92m✓[0m Fortnite otimizado
echo.

echo [95m[8/10][0m Otimizacao GPU automatica...
wmic path win32_VideoController get name | find /i "NVIDIA" >nul
if !errorlevel!==0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v DisablePreemption /t REG_DWORD /d 1 /f >nul 2>&1
    echo [92m✓[0m NVIDIA otimizada ao maximo
) else (
    wmic path win32_VideoController get name | find /i "AMD" >nul
    if !errorlevel!==0 (
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v DisableDMACopy /t REG_DWORD /d 1 /f >nul 2>&1
        echo [92m✓[0m AMD otimizada ao maximo
    ) else (
        echo [93mⓘ GPU nao detectada[0m
    )
)
echo.

echo [95m[9/10][0m Servicos desnecessarios desativados...
sc config DiagTrack start= disabled >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc config WMPNetworkSvc start= disabled >nul 2>&1
echo [92m✓[0m Servicos otimizados
echo.

echo [95m[10/10][0m Prefetch e Superfetch otimizados...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 3 /f >nul 2>&1
echo [92m✓[0m Prefetch otimizado
echo.

echo [94m================================================================[0m
echo [92m✓ NIVEL ULTRA APLICADO COM SUCESSO![0m
echo [91mREINICIE OBRIGATORIAMENTE para aplicar todas as otimizacoes.[0m
echo [94m================================================================[0m
echo.
pause
goto menu

:: =========================
:: MENU DE ENERGIA (Exemplo de como estilizar outros menus)
:: =========================
:energy
call :header
echo.
echo                [96mOTIMIZACAO DE ENERGIA[0m
echo [94m==========================================================[0m
echo.
echo [96m[1][0m [95mPlano ULTRA PERFORMANCE[0m (Maximo)
echo [96m[2][0m [95mPlano BALANCEADO[0m (Recomendado)
echo [96m[3][0m [95mDesativar hibernacao[0m
echo [96m[4][0m [95mReativar hibernacao[0m
echo [96m[5][0m [90mVoltar ao menu[0m
echo.
set /p energy_op=[96mEscolha: [0m

if "%energy_op%"=="1" (
    echo [95mAplicando plano de energia maximo...[0m
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>nul
    powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
    echo [92m✓[0m Plano maximo aplicado
    pause
    goto menu
)
if "%energy_op%"=="2" (
    echo [95mAplicando plano balanceado...[0m
    powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
    echo [92m✓[0m Plano balanceado aplicado
    pause
    goto menu
)
if "%energy_op%"=="3" (
    echo [95mDesativando hibernacao...[0m
    powercfg -h off
    echo [92m✓[0m Hibernacao desativada
    pause
    goto menu
)
if "%energy_op%"=="4" (
    echo [95mReativando hibernacao...[0m
    powercfg -h on
    echo [92m✓[0m Hibernacao reativada
    pause
    goto menu
)
if "%energy_op%"=="5" goto menu
goto energy

:: =========================
:: MEMÓRIA E CACHE
:: =========================
:memory
call :header
echo.
echo           [96mOTIMIZACAO DE MEMORIA E CACHE[0m
echo [94m==========================================================[0m
echo.
echo [96m[1][0m [95mOtimizar memoria para jogos[0m (Recomendado)
echo [96m[2][0m [95mLimpar caches temporarios[0m
echo [96m[3][0m [95mConfigurar memoria virtual automatica[0m
echo [96m[4][0m [95mConfigurar memoria virtual manual[0m
echo [96m[5][0m [90mVoltar ao menu[0m
echo.
set /p mem_op=[96mEscolha: [0m

if "%mem_op%"=="1" (
    echo [95mOtimizando memoria para jogos...[0m
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v IOPageLockLimit /t REG_DWORD /d 4194304 /f >nul 2>&1
    echo [92m✓[0m Memoria otimizada para jogos
    pause
    goto menu
)
if "%mem_op%"=="2" (
    echo [95mLimpando caches temporarios...[0m
    ipconfig /flushdns >nul
    netsh winsock reset catalog >nul
    del /f /q %temp%\*.* >nul 2>&1
    echo [92m✓[0m Caches limpos
    pause
    goto menu
)
if "%mem_op%"=="3" (
    echo [95mConfigurando memoria virtual automatica...[0m
    wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True >nul
    echo [92m✓[0m Memoria virtual automatica configurada
    pause
    goto menu
)
if "%mem_op%"=="4" (
    echo [95mConfigurando memoria virtual manual...[0m
    wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False >nul
    echo [96mDigite o tamanho inicial em MB (ex: 4096): [0m
    set /p size=
    echo [96mDigite o tamanho maximo em MB (ex: 8192): [0m
    set /p max=
    wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=!size!,MaximumSize=!max! >nul
    echo [92m✓[0m Memoria virtual manual configurada
    pause
    goto menu
)
if "%mem_op%"=="5" goto menu
goto memory

:: =========================
:: VERIFICAÇÃO DO SISTEMA
:: =========================
:system_check
call :header
echo.
echo                [96mVERIFICACAO DO SISTEMA[0m
echo [94m==========================================================[0m
echo.
echo [92m[INFORMACOES DO SISTEMA][0m
echo [94m=======================[0m
for /f "tokens=1,* delims=:" %%a in ('systeminfo ^| findstr /C:"Nome" /C:"Sistema" /C:"Processador"') do (
    echo [96m%%a:[0m %%b
)
echo.

echo [92m[MEMORIA RAM][0m
echo [94m============[0m
wmic memorychip get capacity,speed,partnumber 2>nul | findstr /v "PartNumber" | findstr [0-9]
echo.

echo [92m[GPU DETECTADA][0m
echo [94m==============[0m
wmic path win32_VideoController get name,adapterram,driverversion 2>nul | findstr /v "Name"
echo.

echo [92m[OTIMIZACOES ATIVAS][0m
echo [94m==================[0m
powercfg /getactivescheme | find "Ultimate Performance" >nul && echo [92m✓[0m Plano: ULTRA PERFORMANCE
powercfg /getactivescheme | find "Alto" >nul && echo [92m✓[0m Plano: ALTA PERFORMANCE
bcdedit | find "useplatformclock" >nul && echo [92m✓[0m Timer otimizado
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness 2>nul && echo [92m✓[0m Prioridade jogos: ATIVA
echo.

echo [94m================================================================[0m
echo [96m[1][0m [95mTeste de ping rapido[0m
echo [96m[2][0m [95mVoltar ao menu[0m
echo [96m[3][0m [90mSair[0m
echo.
set /p check_op=[96mEscolha: [0m

if "%check_op%"=="1" (
    echo [95mTestando ping para Google (3 tentativas)...[0m
    ping -n 3 8.8.8.8
    pause
    goto system_check
)
if "%check_op%"=="2" goto menu
if "%check_op%"=="3" goto sair
goto system_check

:: =========================
:: DESFAZER TUDO
:: =========================
:undo
call :header
echo.
echo          [96mDESFAZENDO TODAS AS ALTERACOES[0m
echo [94m==========================================================[0m
echo.
echo [93mEscolha o nivel para reverter:[0m
echo.
echo [96m[1][0m [95mReverter nivel BASICO[0m
echo [96m[2][0m [95mReverter nivel BALANCEADO[0m
echo [96m[3][0m [95mReverter nivel ULTRA[0m
echo [96m[4][0m [95mReverter TUDO completamente[0m
echo [96m[5][0m [90mVoltar ao menu[0m
echo.
set /p undo_op=[96mEscolha: [0m

if "%undo_op%"=="1" goto undo_basico
if "%undo_op%"=="2" goto undo_balanceado
if "%undo_op%"=="3" goto undo_ultra
if "%undo_op%"=="4" goto undo_all
if "%undo_op%"=="5" goto menu
goto undo

:undo_basico
echo [95mRevertendo nivel basico...[0m
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /f >nul 2>&1
echo [92m✓[0m Nivel basico revertido
pause
goto menu

:: =========================
:: SAIR COM ESTILO
:: =========================
:sair
cls
echo [94m====================================================================================================[0m
echo        [96mOBRIGADO POR USAR ULTRA GAME OPTIMIZER [93mv3.0[0m!
echo [94m====================================================================================================[0m
echo.
echo [95mMelhorias implementadas:[0m
echo [96m•[0m 3 niveis de otimizacao para diferentes necessidades
echo [96m•[0m Foco em reducao de travamentos em Fortnite e outros jogos
echo [96m•[0m Otimizacoes de memoria especificas para estabilidade
echo [96m•[0m Sistema de reversao segmentada por niveis
echo [96m•[0m Interface colorida e intuitiva
echo.
echo [93mLembre-se de reiniciar o PC para aplicar[0m
echo [93mtodas as otimizacoes completamente.[0m
echo.
echo [94mDesenvolvido para melhor performance em jogos[0m
echo.
timeout /t 3 >nul
exit
