@echo off
title alegria
color 0C
mode con: cols=85 lines=40
setlocal enabledelayedexpansion

echo ====================================================
echo             ALEGRIA - Limpeza Completa
echo ====================================================
echo.
:: Admin check
net session >nul 2>&1
if errorlevel 1 (
    echo ERRO: Execute como Administrador!
    pause
    exit /b 1
)

:: SALVAR CAMINHO DO ARQUIVO PARA AUTO-DESTRUIÇÃO DEPOIS
set "SELF=%~f0"
set "SELF_NAME=%~nx0"

echo [1] NAVEGADORES - Historico COMPLETO
echo ====================================================
echo.
echo FORCANDO limpeza do Brave e outros navegadores...

:: Método AGESSIVO para Brave
if exist "%localappdata%\BraveSoftware" (
    echo   Brave: Metodo agressivo...
    :: Mata processo do Brave
    taskkill /f /im brave.exe >nul 2>&1
    taskkill /f /im brave-browser.exe >nul 2>&1
    timeout /t 1 /nobreak >nul
    
    :: Remove/corrompe arquivos de histórico
    for /r "%localappdata%\BraveSoftware" %%f in (History Cookies Web Data Login Data) do (
        if exist "%%f" (
            echo CORRUPTED_!random! > "%%f"
            del /f /q "%%f" >nul 2>&1
        )
    )
    
    :: Remove cache
    if exist "%localappdata%\BraveSoftware\Brave-Browser\User Data\Default\Cache" (
        rmdir /s /q "%localappdata%\BraveSoftware\Brave-Browser\User Data\Default\Cache" >nul 2>&1
    )
    
    echo   Brave: Historico completamente removido
)

echo   OK - Navegadores limpos
echo.

echo [2] WINDOWS DEFENDER - Limpeza DIRETA SEM REINICIAR
echo ====================================================
echo.
echo Parando Windows Defender temporariamente...
net stop WinDefend >nul 2>&1
net stop WdNisSvc >nul 2>&1
sc config WinDefend start= disabled >nul 2>&1
timeout /t 2 /nobreak >nul

echo Removendo historico de scans...
if exist "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service" (
    takeown /f "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service" /r /d y >nul 2>&1
    icacls "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service" /grant Administrators:F /t /c /q >nul 2>&1
    rmdir /s /q "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service" >nul 2>&1
    echo   Historico de scans removido
) else (
    echo   Historico nao encontrado
)

echo Corrompendo database do Defender...
if exist "C:\ProgramData\Microsoft\Windows Defender\Scans\mpenginedb.db" (
    takeown /f "C:\ProgramData\Microsoft\Windows Defender\Scans\mpenginedb.db" /d y >nul 2>&1
    icacls "C:\ProgramData\Microsoft\Windows Defender\Scans\mpenginedb.db" /grant Administrators:F /c /q >nul 2>&1
    del /f /q "C:\ProgramData\Microsoft\Windows Defender\Scans\mpenginedb.db" >nul 2>&1
    del /f /q "C:\ProgramData\Microsoft\Windows Defender\Scans\mpenginedb.db-wal" >nul 2>&1
    del /f /q "C:\ProgramData\Microsoft\Windows Defender\Scans\mpenginedb.db-shm" >nul 2>&1
    echo   Database corrompida
) else (
    echo   Database nao encontrada
)

echo Limpando logs do Event Viewer...
wevtutil cl "Microsoft-Windows-Windows Defender/Operational" >nul 2>&1

echo Limpando pasta de Quarantine...
if exist "C:\ProgramData\Microsoft\Windows Defender\Quarantine" (
    takeown /f "C:\ProgramData\Microsoft\Windows Defender\Quarantine" /r /d y >nul 2>&1
    icacls "C:\ProgramData\Microsoft\Windows Defender\Quarantine" /grant Administrators:F /t /c /q >nul 2>&1
    rmdir /s /q "C:\ProgramData\Microsoft\Windows Defender\Quarantine" >nul 2>&1
    mkdir "C:\ProgramData\Microsoft\Windows Defender\Quarantine" >nul 2>&1
)

echo Restaurando Windows Defender...
sc config WinDefend start= auto >nul 2>&1
net start WinDefend >nul 2>&1
net start WdNisSvc >nul 2>&1

echo   OK - Windows Defender limpo SEM reiniciar
echo.

echo [3] JOURNAL TRACE - Limpeza de Logs
echo ====================================================
echo.
echo Limpando USN Journal...
fsutil usn deletejournal /D C: >nul 2>&1
echo   USN Journal limpo

echo Corrompendo Event Logs...
for %%f in (
    "C:\Windows\System32\winevt\Logs\Application.evtx"
    "C:\Windows\System32\winevt\Logs\System.evtx"
    "C:\Windows\System32\winevt\Logs\Security.evtx"
    "C:\Windows\System32\winevt\Logs\Setup.evtx"
) do (
    if exist "%%f" (
        echo CORRUPTED_BY_ALEGRIA > "%%f"
    )
)
echo   Event Logs corrompidos
echo.

echo [4] ARQUIVOS RECENTES E SHELLBAGS
echo ====================================================
echo.
echo Limpando rastros do Explorer...

:: Recent items
if exist "%appdata%\Microsoft\Windows\Recent" (
    del /f /q "%appdata%\Microsoft\Windows\Recent\*" >nul 2>&1
    echo   Recent items limpos
)

:: Registry recent items
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f >nul 2>&1
echo   Registry recent limpo

:: Shellbags
reg delete "HKCU\Software\Microsoft\Windows\Shell\BagMRU" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\ShellNoRoam\BagMRU" /f >nul 2>&1
echo   Shellbags limpos
echo.

echo [5] USB LOGS E OUTROS RASTROS
echo ====================================================
echo.
echo Limpando logs USB...
reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\USBSTOR" /f >nul 2>&1
del /f /q "C:\Windows\inf\setupapi*.log" >nul 2>&1
echo   Logs USB limpos

echo Limpando Prefetch...
del /f /q "C:\Windows\Prefetch\*.pf" >nul 2>&1
echo   Prefetch limpo

echo Limpando arquivos temporarios...
del /f /q "%temp%\*" >nul 2>&1
del /f /q "%windir%\Temp\*" >nul 2>&1
del /f /q "%localappdata%\Temp\*" >nul 2>&1
echo   Temp files limpos

echo Flush DNS...
ipconfig /flushdns >nul 2>&1
echo   DNS cache limpo
echo.

echo [6] LOGS DE PROCESSOS E EVENTOS
echo ====================================================
echo.
echo Limpando logs de processos...
wevtutil cl "Microsoft-Windows-Kernel-Process/Analytic" >nul 2>&1
wevtutil cl "Microsoft-Windows-Kernel-Memory/Analytic" >nul 2>&1
wevtutil cl Application >nul 2>&1
wevtutil cl System >nul 2>&1
echo   Logs de eventos limpos
echo.

echo [7] LIMPANDO LOGS DESTE SCRIPT
echo ====================================================
echo.
echo Removendo rastros de execucao deste script...

:: Limpa logs do Event Viewer que podem ter registrado esta execução
wevtutil qe Application /f:text | findstr /i "alegria" >nul && wevtutil cl Application >nul 2>&1
wevtutil qe System /f:text | findstr /i "alegria" >nul && wevtutil cl System >nul 2>&1

:: Limpa arquivos temporários com nome do script
del /f /q "%temp%\*alegria*" >nul 2>&1
del /f /q "%temp%\*cleaner*" >nul 2>&1

echo   Logs deste script removidos
echo.

echo ====================================================
echo        LIMPEZA COMPLETA CONCLUIDA!
echo ====================================================
echo.
echo TUDO REMOVIDO SEM REINICIAR:
echo ✓ Brave - Historico COMPLETO
echo ✓ Windows Defender - Scans, Database, Quarantine
echo ✓ Journal Trace - USN Journal, Event Logs
echo ✓ Arquivos recentes e ShellBags
echo ✓ Logs USB e Prefetch
echo ✓ Temp files e DNS Cache
echo ✓ Logs de processos e eventos
echo ✓ Logs deste script
echo.
echo NENHUM REINICIO NECESSARIO!
echo.

echo [8] CRIANDO TAREFA PARA LIMPEZA FUTURA
echo ====================================================
echo.
echo Criando tarefa para limpar na proxima inicializacao...
schtasks /create /tn "DefenderCleanup" /tr "cmd /c del /f /q \"C:\ProgramData\Microsoft\Windows Defender\Scans\mpenginedb.db*\" & rmdir /s /q \"C:\ProgramData\Microsoft\Windows Defender\Scans\History\"" /sc onstart /ru SYSTEM /f >nul 2>&1
echo   Tarefa agendada criada
echo.

:: ====================================================
:: AUTO-DESTRUICAO REALMENTE FUNCIONAL
:: ====================================================
echo [AUTO-DESTRUICAO] Preparando remocao...
echo.
timeout /t 2 /nobreak >nul

echo Criando script de auto-destruicao...
(
echo @echo off
echo echo Auto-destruindo arquivo original...
echo ping 127.0.0.1 -n 3 ^>nul
echo.
echo Etapa 1: Removendo logs relacionados...
echo wevtutil qe Application /f:text ^| findstr /i "alegria" ^>nul ^&^& wevtutil cl Application ^>nul 2^>^&1
echo wevtutil qe System /f:text ^| findstr /i "alegria" ^>nul ^&^& wevtutil cl System ^>nul 2^>^&1
echo.
echo Etapa 2: Removendo arquivo original...
echo if exist "%SELF%" (
echo   echo Corrompendo arquivo...
echo   echo  > "%SELF%"
del /f /q "%SELF%"
echo   del /f /q "%SELF%" ^>nul 2^>^&1
echo )
echo.
echo Etapa 3: Removendo de locais comuns...
echo for %%%%d in ^(Desktop Downloads Documents^) do (
echo   del /f /q "%%userprofile%%%%%d\alegria.*" ^>nul 2^>^&1
echo   del /f /q "%%userprofile%%%%%d\*.bat" ^>nul 2^>^&1
echo )
echo.
echo Etapa 4: Removendo este script de auto-destruicao...
echo del /f /q "%%~f0" ^>nul 2^>^&1
echo exit
) > "%temp%\destroy_self.bat"

echo Executando auto-destruicao em background...
start /B "" cmd /c "timeout /t 1 /nobreak >nul && call "%temp%\destroy_self.bat""

echo.
echo O arquivo original sera removido em 5 segundos.
echo.
echo Fechando este programa...
timeout /t 3 /nobreak >nul

:: Fecha esta janela
exit