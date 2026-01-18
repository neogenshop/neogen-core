@echo off
chcp 65001 >nul
title ULTRA GAME OPTIMIZER v3.0 - NÍVEIS DE OTIMIZAÇÃO
mode con cols=100 lines=40
setlocal enabledelayedexpansion

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
goto :eof

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
:: ENERGY MENU
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
:: INPUT LAG MENU
:: =========================
:input
call :header
echo.
echo             [96mOTIMIZACAO DE INPUT LAG[0m
echo [94m==========================================================[0m
echo.
echo [96m[1][0m [95mAplicar tweaks de timer[0m (Recomendado)
echo [96m[2][0m [95mReverter tweaks de timer[0m
echo [96m[3][0m [95mVer configuracoes atuais[0m
echo [96m[4][0m [90mVoltar ao menu[0m
echo.
set /p input_op=[96mEscolha: [0m

if "%input_op%"=="1" (
    echo [95mAplicando tweaks de input lag...[0m
    bcdedit /set useplatformclock true >nul
    bcdedit /set disabledynamictick yes >nul
    bcdedit /set tscsyncpolicy Enhanced >nul
    echo [92m✓[0m Tweaks aplicados - Reinicie o PC
    pause
    goto menu
)
if "%input_op%"=="2" (
    echo [95mRevertendo tweaks...[0m
    bcdedit /deletevalue useplatformclock >nul
    bcdedit /deletevalue disabledynamictick >nul
    bcdedit /deletevalue tscsyncpolicy >nul
    echo [92m✓[0m Tweaks revertidos - Reinicie o PC
    pause
    goto menu
)
if "%input_op%"=="3" (
    echo [95mConfiguracoes atuais:[0m
    bcdedit | findstr "useplatformclock disabledynamictick tscsyncpolicy"
    pause
    goto input
)
if "%input_op%"=="4" goto menu
goto input

:: =========================
:: NETWORK MENU
:: =========================
:net
call :header
echo.
echo              [96mOTIMIZACAO DE INTERNET[0m
echo [94m==========================================================[0m
echo.
echo [96m[1][0m [95mOtimizar rede para jogos[0m (Recomendado)
echo [96m[2][0m [95mOtimizar para streaming[0m
echo [96m[3][0m [95mResetar configuracoes de rede[0m
echo [96m[4][0m [95mVer configuracoes atuais[0m
echo [96m[5][0m [90mVoltar ao menu[0m
echo.
set /p net_op=[96mEscolha: [0m

if "%net_op%"=="1" (
    echo [95mAplicando tweaks de internet para jogos...[0m
    
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
    
    echo [92m✓[0m Rede otimizada para jogos
    echo Reinicie o PC para efeito completo
    pause
    goto menu
)
if "%net_op%"=="2" (
    echo [95mOtimizando para streaming...[0m
    netsh int tcp set global autotuninglevel=restricted >nul
    netsh int tcp set global ecncapability=enabled >nul
    echo [92m✓[0m Otimizado para streaming
    pause
    goto menu
)
if "%net_op%"=="3" (
    echo [95mResetando configuracoes de rede...[0m
    netsh int ip reset >nul
    netsh winsock reset >nul
    ipconfig /flushdns >nul
    echo [92m✓[0m Rede resetada - Reinicie o PC
    pause
    goto menu
)
if "%net_op%"=="4" (
    echo [95mConfiguracoes TCP atuais:[0m
    netsh int tcp show global
    pause
    goto net
)
if "%net_op%"=="5" goto menu
goto net

:: =========================
:: PRIORITY MENU
:: =========================
:priority
call :header
echo.
echo            [96mPRIORIDADE MAXIMA PARA JOGOS[0m
echo [94m==========================================================[0m
echo.
echo [96m[1][0m [95mAtivar prioridade maxima[0m (Recomendado)
echo [96m[2][0m [95mDesativar prioridade[0m
echo [96m[3][0m [95mVer configuracoes atuais[0m
echo [96m[4][0m [90mVoltar ao menu[0m
echo.
set /p pri_op=[96mEscolha: [0m

if "%pri_op%"=="1" (
    echo [95mAjustando prioridade maxima para jogos...[0m
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 0xffffffff /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >nul
    echo [92m✓[0m Prioridade maxima ativada
    pause
    goto menu
)
if "%pri_op%"=="2" (
    echo [95mDesativando prioridade...[0m
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /f >nul
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /f >nul
    echo [92m✓[0m Prioridade desativada
    pause
    goto menu
)
if "%pri_op%"=="3" (
    echo [95mVerificando configuracoes...[0m
    reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex 2>nul && echo [92m✓[0m Prioridade ativa
    reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness 2>nul && echo [92m✓[0m Responsividade configurada
    pause
    goto priority
)
if "%pri_op%"=="4" goto menu
goto priority

:: =========================
:: MOUSE MENU
:: =========================
:mouse
call :header
echo.
echo             [96mCONFIGURACAO DE MOUSE RAW[0m
echo [94m==========================================================[0m
echo.
echo [96m[1][0m [95mDesativar aceleracao do mouse[0m (Recomendado)
echo [96m[2][0m [95mReativar aceleracao padrao[0m
echo [96m[3][0m [95mVer configuracoes atuais[0m
echo [96m[4][0m [90mVoltar ao menu[0m
echo.
set /p mouse_op=[96mEscolha: [0m

if "%mouse_op%"=="1" (
    echo [95mAjustando mouse para RAW INPUT...[0m
    reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul
    echo [92m✓[0m Aceleracao desativada - Reinicie os jogos
    pause
    goto menu
)
if "%mouse_op%"=="2" (
    echo [95mReativando aceleracao padrao...[0m
    reg delete "HKCU\Control Panel\Mouse" /v MouseSpeed /f >nul
    reg delete "HKCU\Control Panel\Mouse" /v MouseThreshold1 /f >nul
    reg delete "HKCU\Control Panel\Mouse" /v MouseThreshold2 /f >nul
    echo [92m✓[0m Configuracoes padrao restauradas
    pause
    goto menu
)
if "%mouse_op%"=="3" (
    echo [95mConfiguracoes atuais do mouse:[0m
    reg query "HKCU\Control Panel\Mouse" /v MouseSpeed 2>nul || echo MouseSpeed: Nao configurado
    reg query "HKCU\Control Panel\Mouse" /v MouseThreshold1 2>nul || echo MouseThreshold1: Nao configurado
    reg query "HKCU\Control Panel\Mouse" /v MouseThreshold2 2>nul || echo MouseThreshold2: Nao configurado
    pause
    goto mouse
)
if "%mouse_op%"=="4" goto menu
goto mouse

:: =========================
:: FORTNITE MENU
:: =========================
:fortnite
call :header
echo.
echo            [96mTWEAKS ESPECIFICOS FORTNITE[0m
echo [94m==========================================================[0m
echo.
echo [96m[1][0m [95mAplicar tweaks Fortnite[0m (Recomendado)
echo [96m[2][0m [95mRemover tweaks Fortnite[0m
echo [96m[3][0m [90mVoltar ao menu[0m
echo.
set /p fn_op=[96mEscolha: [0m

if "%fn_op%"=="1" (
    echo [95mAplicando tweaks especificos do Fortnite...[0m
    reg add "HKCU\Software\Epic Games\Unreal Engine\Hardware Survey" /v DisableSurvey /t REG_DWORD /d 1 /f >nul 2>&1
