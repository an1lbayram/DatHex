@echo off
:: =============================================
:: DatHex - Windows Winget Mass Upgrader
:: Author: an1lbayram | License: MIT
::
:: TR: Winget kullanarak sistemdeki tüm uygulamaları topluca sessizce günceller
:: EN: Silently upgrades all installed apps using winget on Windows
:: =============================================

title DatHex v1.0 - by an1lbayram

color 0B
echo  ******************************************************        
echo                     DatHex v1.0
echo                  - by an1lbayram -                    
echo  ******************************************************
echo.

:: Admin check
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Please run as Administrator!
    timeout /t 5 >nul
    exit /b 1
)

:: Winget check
where winget >nul 2>&1 || (
    echo [X] Winget not found. Opening installer...
    start ms-appinstaller:?source=https://aka.ms/getwinget
    echo [!] Please install Winget and then re-run this tool.
    pause
    exit /b 1
)

:: Interactive Menu
:menu
color 0B
cls
echo  ******************************************************        
echo                     DatHex v1.0
echo                  - by an1lbayram -                    
echo  ******************************************************
echo                      MAIN MENU                     
echo  ******************************************************
echo.

echo   [1] Upgrade ALL applications
echo   [2] List upgradable apps
echo   [3] Exit
echo.
set /p choice="Select option (1-3): "

if "%choice%"=="1" goto upgrade_all
if "%choice%"=="2" goto list_apps
if "%choice%"=="3" goto exit_script

echo.
echo [!] Invalid selection. Please enter 1, 2, or 3.
timeout /t 2 >nul
goto menu

:upgrade_all
echo.
echo [i] These applications will be upgraded:
winget upgrade
echo.

:confirm_upgrade
set /p confirm="Do you want to continue with the upgrade? (Y/N): "
if /i "%confirm%"=="Y" goto start_upgrade
if /i "%confirm%"=="N" goto menu

echo.
echo [!] Invalid input! Please press Y or N.
goto confirm_upgrade

:start_upgrade
echo.
echo [~] Starting upgrades... (Please wait)
winget upgrade --all --accept-package-agreements --accept-source-agreements --silent || (
    echo.
    echo [X] Upgrade failed! Possible reasons:
    echo - System requires reboot
    echo - Network issues
    echo - Conflicting apps
    pause
    goto menu
)

echo.
echo [✓] All apps upgraded successfully!
echo [i] Some changes may require system restart.
pause
goto menu

:list_apps
echo.
winget upgrade
pause
goto menu

:exit_script
echo.
echo [i] Exiting UpdateWitch. Goodbye!
timeout /t 5 >nul

exit
