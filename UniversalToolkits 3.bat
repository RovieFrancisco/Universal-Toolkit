@echo off
setlocal EnableDelayedExpansion
title UNIVERSAL TOOLKIT
color 0b

:: Check for admin rights
net session >nul 2>&1
::if %errorlevel% neq 0 (
::    echo ==================================
::    echo   Please run as Administrator.
::    echo ==================================
::    pause
::    exit
::)

set password=cm92aWUwNQ==

:login
cls
echo [32m========================================
echo [1m[31m*              LOGIN PANEL             *
echo [0m[32m========================================
set "pass="
set /p pass=[36mEnter Password: 

for /f "delims=" %%A in ('
    powershell -NoProfile -Command ^
    "[Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('%password%'))"
') do set passcode=%%A

if "%pass%"=="%passcode%" goto loading

echo.
echo ! ! ! Wrong Password ! ! !
echo.
color 0c
pause
goto login

:loading
echo.
echo Logging in...
echo.

set "bar="

for /L %%i in (0,10,100) do (
    if %%i==0 set "clr=[31m"
    if %%i==10 set "clr=[33m"
    if %%i==20 set "clr=[32m"
    if %%i==30 set "clr=[36m"
    if %%i==40 set "clr=[34m"
    if %%i==50 set "clr=[35m"
    if %%i==60 set "clr=[91m"
    if %%i==70 set "clr=[92m"
    if %%i==80 set "clr=[93m"
    if %%i==90 set "clr=[94m"
    if %%i==100 set "clr=[97m"

    set "bar=!bar!#"

    <nul set /p="!clr![10000D[!bar!] %%i%%"

    timeout /t 1 >nul
)

echo.
echo Login Complete!
timeout /t 1 >nul
goto Main_menu


:: =========================
:: MAIN MENU
:: =========================

:Main_menu
cls
color 0b
echo [32m========================================
echo [1m[31m*           UNIVERSAL TOOLKIT          *
echo [0m[32m========================================
echo [36m 1. WiFi Repair Toolkit
echo  2. System Tools
echo  3. Advanced Tools
echo  4. Hidden Tools
echo  5. Visit my Website
echo  6. Exit
echo [32m========================================

set "mainChoice="
set /p mainChoice=[36mSelect option: [33m

echo(%mainChoice%| findstr /R "^[1-6]$" >nul || goto invalidMain

if "%mainChoice%"=="1" goto WiFi_menu
if "%mainChoice%"=="2" goto System_menu
if "%mainChoice%"=="3" goto Advanced_menu
if "%mainChoice%"=="4" goto Hidden_Tools_menu
if "%mainChoice%"=="5" start http://roviefrancisco.free.nf/
if "%mainChoice%"=="6" exit

goto end

:: =========================
:: WIFI TOOLKIT
:: =========================

:WiFi_menu
cls
echo [32m========================================
echo [1m[31m*          WIFI REPAIR TOOLKIT         *
echo [0m[32m========================================
echo [36m 1. Show Wi-Fi Profiles
echo  2. Show Wi-Fi Password
echo  3. Flush DNS
echo  4. Release and Renew IP
echo  5. Reset Winsock
echo  6. Full Network Repair
echo  7. Ping Google Test
echo  8. Open Network Connections
echo  9. Show IP Configuration
echo 10. Back to Main Menu
echo [32m========================================

set /p choice=[36mSelect option: [33m

echo(%choice%| findstr /R "^[1-9]$ ^10$" >nul || goto invalidWifi

if "%choice%"=="1" (
    cls
    netsh wlan show profiles
    pause
    goto WiFi_menu
)

if "%choice%"=="2" goto password
if "%choice%"=="3" goto confirmFlushDNS
if "%choice%"=="4" goto confirmRenewIP
if "%choice%"=="5" goto confirmWinsock
if "%choice%"=="6" goto confirmRepair

if "%choice%"=="7" (
    cls
    ping google.com
    pause
    goto WiFi_menu
)

if "%choice%"=="8" (
    start ncpa.cpl
    goto WiFi_menu
)

if "%choice%"=="9" (
    cls
    ipconfig /all
    pause
    goto WiFi_menu
)

if "%choice%"=="10" goto Main_menu


:: =========================
:: WIFI FUNCTIONS
:: =========================

:confirmFlushDNS
cls
echo Flushing DNS will remove all temporary IPs stored in local storage.
set /p confirm=Flush DNS? (Y/N):

if /i "%confirm%"=="Y" (
    cls
    ipconfig /flushdns
    pause
    goto WiFi_menu
)

if /i "%confirm%"=="N" goto WiFi_menu

goto invalidConfirm


:confirmRenewIP
cls
echo Renewing IP will refresh your computer's IP address from the router/DHCP server.
set /p confirm=Release and Renew IP? (Y/N):

if /i "%confirm%"=="Y" (
    cls
    ipconfig /release
    ipconfig /renew
    pause
    goto WiFi_menu
)

if /i "%confirm%"=="N" goto WiFi_menu

goto invalidConfirm


:confirmWinsock
cls
echo This will resets the Windows Winsock catalog back to default. It removes and rebuilds network socket configuration.
set /p confirm=Reset Winsock? (Y/N):

if /i "%confirm%"=="Y" (
    cls
    netsh winsock reset
    pause
    goto WiFi_menu
)

if /i "%confirm%"=="N" goto WiFi_menu

goto invalidConfirm


:confirmRepair
cls
echo Full repair sequence is basically a full Windows network reset/troubleshooting combo.
set /p confirm=Run Full Network Repair? (Y/N):

if /i "%confirm%"=="Y" goto repair
if /i "%confirm%"=="N" goto WiFi_menu

goto invalidConfirm


:password
cls
netsh wlan show profiles

echo.
set "wifi="
set /p wifi=Enter Wi-Fi Name: 

if "%wifi%"=="" goto invalidWifiName

netsh wlan show profile name="%wifi%" key=clear
pause
goto WiFi_menu


:repair
cls
echo Repairing network...

ipconfig /flushdns
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew

echo.
echo Repair complete.
pause
goto WiFi_menu


:: =========================
:: SYSTEM MENUS
:: =========================

:System_menu
cls
echo [32m========================================
echo [1m[31m*            SYSTEM TOOLKIT            *
echo [0m[32m========================================
echo [36m 1. System Repair
echo  2. Command Prompt (Administrator)
echo  3. Force Shutdown
echo  4. Back to Main Menu
echo [32m========================================

set "SystemChoice="
set /p SystemChoice=[36mSelect option: [33m

echo(%SystemChoice%| findstr /R "^[1-4]$" >nul || goto invalidSystem

if "%SystemChoice%"=="1" goto systemRepair
if "%SystemChoice%"=="2" runas /user:Administrator cmd
if "%SystemChoice%"=="3" shutdown /s /f /t 0
if "%SystemChoice%"=="4" goto Main_menu

goto System_menu

:systemRepair
cls
echo =====================================
echo         SYSTEM REPAIR TOOL
echo =====================================
 
echo.
echo [32m[1/6] Checking Windows system files...
sfc /scannow
 
echo.
echo [31m[2/6] Repairing Windows image...
DISM /Online /Cleanup-Image /RestoreHealth
 
echo.
echo [36m[3/6] Flushing DNS cache...
ipconfig /flushdns
 
echo.
echo [33m[4/6] Resetting network...
netsh winsock reset
netsh int ip reset
 
echo.
echo [35m[5/6] Releasing and renewing IP...
ipconfig /release
ipconfig /renew
 
echo.
echo [34m[6/6] Checking disk health...
chkdsk C:
 
echo.
echo [32m=====================================
echo       REPAIR PROCESS COMPLETE
echo =====================================
 
echo [36mRestart your PC for all fixes to apply.
pause
goto System_menu


:: =========================
:: ADVANCED MENUS
:: =========================

:Advanced_menu
cls
echo [32m========================================
echo [1m[31m*          ADVANCED TOOLKIT            *
echo [0m[32m========================================
echo [36m 1. Startup Booster
echo  2. Network Booster
echo  3. RAM Optimizer
echo  4. Gaming Mode / High Performance Power Plan
echo  5. Chrome Cleaner
echo  6. Back to Main Menu
echo [32m========================================

set "AdvancedChoice="
set /p AdvancedChoice=[36mSelect option: [33m

echo(%AdvancedChoice%| findstr /R "^[1-6]$" >nul || goto invalidAdvanced

if "%AdvancedChoice%"=="1" goto startUpBooster
if "%AdvancedChoice%"=="2" goto networkBooster
if "%AdvancedChoice%"=="3" goto ramOptimizer
if "%AdvancedChoice%"=="4" goto highPerformance
if "%AdvancedChoice%"=="5" goto chromeCleaner
if "%AdvancedChoice%"=="6" goto Main_menu

:startUpBooster
cls
echo Cleaning Startup temp files...
del /s /f /q %temp%\*

echo Opening Startup Manager...
start msconfig

pause
goto Advanced_menu

:networkBooster
cls
echo Repairing slow internet...
ipconfig /flushdns

netsh winsock reset

netsh int tcp set global rss=enabled
netsh int tcp set global autotuninglevel=normal

echo Optimization complete.

pause
goto Advanced_menu

:ramOptimizer
echo Optimizing RAM...
echo off | clip
taskkill /f /fi "STATUS eq NOT RESPONDING"
powershell -command "& {[System.GC]::Collect()}"
echo Ram optimized.
pause
goto Advanced_menu

:highPerformance
powercfg -setactive SCHEME_MAX
pause
goto Advanced_menu

:chromeCleaner
echo Closing Chrome...
taskkill /f /im chrome.exe >nul 2>&1

echo Cleaning Chrome Cache...

del /s /f /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*"
del /s /f /q "%LocalAppData%\Google\Chrome\User Data\Default\Code\Cache\*"
del /s /f /q "%LocalAppData%\Google\Chrome\User Data\Default\GPUCache\*"
del /s /f /q "%LocalAppData%\Google\Chrome\User Data\Default\Media\Cache\*"

echo Chrome cache cleaned successfully!

pause
goto Advanced_menu


:: =========================
:: HIDDEN TOOLS
:: =========================

:Hidden_Tools_menu
cls
echo [32m========================================
echo [1m[31m*             HIDDEN TOOLS             *
echo [0m[32m========================================
echo [36m 1. Microsoft System Configuration
echo  2. Resource and Performance Monitor
echo  3. Performance Monitor
echo  4. Event Viewer
echo  5. Task Manager
echo  6. Character Map
echo  7. Component Services
echo  8. Computer Management
echo  9. Control Panel
echo 10. Disk Cleanup
echo 11. Local Security Policy
echo 12. Print Management
echo 13. Registry Editor
echo 14. Run Dialog
echo 15. Services
echo 16. Steps Recorder
echo 17. System Information Panel
echo 18. Task Scheduler
echo 19. Windows Powershell
echo 20. Windows Defender Firewall
echo 21. System Information
echo 22. DirectX Diagnostic Tool
echo 23. ROM ^& RAM information
echo 24. Credential Manager
echo 25. Back to Main Menu
echo [32m========================================

set "HiddenToolsChoice="
set /p HiddenToolsChoice=[36mSelect option: [33m

echo(%HiddenToolsChoice%| findstr /R "^[1-9]$ ^1[0-9]$ ^2[0-5]$" >nul || goto invalidHiddenTools

if "%HiddenToolsChoice%"=="1" start msconfig
if "%HiddenToolsChoice%"=="2" start resmon
if "%HiddenToolsChoice%"=="3" start perfmon
if "%HiddenToolsChoice%"=="4" start eventvwr
if "%HiddenToolsChoice%"=="5" taskmgr
if "%HiddenToolsChoice%"=="6" charmap
if "%HiddenToolsChoice%"=="7" dcomcnfg
if "%HiddenToolsChoice%"=="8" compmgmt.msc
if "%HiddenToolsChoice%"=="9" control
if "%HiddenToolsChoice%"=="10" cleanmgr
if "%HiddenToolsChoice%"=="11" secpol.msc
if "%HiddenToolsChoice%"=="12" printmanagement.msc
if "%HiddenToolsChoice%"=="13" regedit
if "%HiddenToolsChoice%"=="14" explorer shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}
if "%HiddenToolsChoice%"=="15" services.msc
if "%HiddenToolsChoice%"=="16" psr
if "%HiddenToolsChoice%"=="17" msinfo32
if "%HiddenToolsChoice%"=="18" taskschd.msc
if "%HiddenToolsChoice%"=="19" powershell
if "%HiddenToolsChoice%"=="20" wf.msc
if "%HiddenToolsChoice%"=="21" systeminfo
if "%HiddenToolsChoice%"=="22" dxdiag
if "%HiddenToolsChoice%"=="23" goto romRamInfo
if "%HiddenToolsChoice%"=="24" control.exe /name Microsoft.CredentialManager
if "%HiddenToolsChoice%"=="25" goto Main_menu

pause
goto Hidden_Tools_menu

:romRamInfo
cls
echo [32m========================================
echo [1m[31m*               ROM INFO               *
echo [0m[32m========================================
echo [36m
wmic diskdrive get model,manufacturer,size

echo.
echo [32m========================================
echo [1m[31m*               RAM INFO               *
echo [0m[32m========================================
echo [36m
wmic memorychip get manufacturer,partnumber,serialnumber,capacity,speed

pause
goto Hidden_Tools_menu

:: =========================
:: PLACEHOLDER MENUS
:: =========================

:More_menu
cls
echo System Toolkit Coming Soon
pause
goto Main_menu


:: =========================
:: INVALID HANDLERS
:: =========================

:invalidWifiName
echo.
echo Wi-Fi name cannot be empty.
pause
goto password

:invalidConfirm
echo.
echo Please enter Y or N only.
pause
goto WiFi_menu


:invalidMain
echo.
echo Invalid or empty input.
pause
goto Main_menu

:invalidWifi
echo.
echo Invalid or empty input.
pause
goto WiFi_menu

:invalidSystem
echo.
echo Invalid or empty input.
pause
goto System_menu

:invalidAdvanced
echo.
echo Invalid or empty input.
pause
goto Advanced_menu

:invalidHiddenTools
echo.
echo Invalid or empty input.
pause
goto Hidden_Tools_menu


:end