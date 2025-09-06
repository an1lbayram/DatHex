@echo off
:: =============================================
:: DatHex - Windows Winget Mass Upgrader
:: Author: an1lbayram
:: License: MIT
:: =============================================

title DatHex v1.3 - by an1lbayram
set "CLI_COLOR=0B"
color %CLI_COLOR%
setlocal EnableDelayedExpansion

:: Internet connection check
ping -n 2 8.8.8.8 >nul 2>&1
if errorlevel 1 (
    echo [ERROR] No internet connection detected!
    echo [!] Please connect to the internet to perform upgrades.
    timeout /t 5 >nul
    goto exit_script
)

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
cls
color !CLI_COLOR!
echo  ******************************************************        
echo                     DatHex v1.3
echo                  - by an1lbayram -                    
echo  ******************************************************
echo                      MAIN MENU                     
echo  ******************************************************
echo.

echo   [1] Upgrade ALL applications
echo   [2] List upgradable apps
echo   [3] Change CLI color
echo   [4] Exclude applications from upgrade
echo   [5] Exit
echo.
set /p choice="Select option (1-5): "

if "%choice%"=="1" goto upgrade_all
if "%choice%"=="2" goto list_apps
if "%choice%"=="3" goto change_color
if "%choice%"=="4" goto exclude_apps
if "%choice%"=="5" goto exit_script

echo.
echo [!] Invalid selection. Please enter 1, 2, 3, 4, or 5.
timeout /t 2 >nul
goto menu

:change_color
cls
echo.
echo  Available CLI color codes:
echo  0 = Black   8 = Gray
echo  1 = Blue    9 = Light Blue
echo  2 = Green   A = Light Green
echo  3 = Aqua    B = Light Aqua
echo  4 = Red     C = Light Red
echo  5 = Purple  D = Light Purple
echo  6 = Yellow  E = Light Yellow
echo  7 = White   F = Bright White
echo.
echo  Format: [Background][Foreground] (e.g. 0A for black bg, light green text)
echo.
echo  Presets:
echo [1] Main (0B)                      [16] Green on White (2F)
echo [2] Dark Green (0A)                [17] Aqua on White (3F)
echo [3] Aqua (03)                      [18] Red on White (4F)
echo [4] Red (0C)                       [19] Purple on Yellow (5E)
echo [5] Purple (0D)                    [20] Yellow on White (6F)
echo [6] Yellow (0E)                    [21] White on Light Red (7C)
echo [7] Gray (08)                      [22] Gray on Black (80)
echo [8] White on Blue (1F)             [23] Light Blue on Black (90)
echo [9] Black on White (F0)            [24] Light Green on Black (A0)
echo [10] Light Blue (09)               [25] Light Aqua on Black (B0)
echo [11] Bright White (0F)             [26] Light Purple on Black (D0)
echo [12] Black on Light Yellow (E0)    [27] Light Yellow on Black (E0)
echo [13] Black on Green (02)           [28] Bright White on Black (F0)
echo [14] Black on White (07)           [29] Black on Light Purple (0D)
echo [15] Blue on Light Yellow (1E)     [30] Black on Light Yellow (0E)
echo.
set /p newcolor="Enter new color code (or M to return to Main Menu): "

if /i "!newcolor!"=="M" goto menu
if "!newcolor!"=="1" set "newcolor=0B" & goto apply_color
if "!newcolor!"=="2" set "newcolor=0A" & goto apply_color
if "!newcolor!"=="3" set "newcolor=03" & goto apply_color
if "!newcolor!"=="4" set "newcolor=0C" & goto apply_color
if "!newcolor!"=="5" set "newcolor=0D" & goto apply_color
if "!newcolor!"=="6" set "newcolor=0E" & goto apply_color
if "!newcolor!"=="7" set "newcolor=08" & goto apply_color
if "!newcolor!"=="8" set "newcolor=1F" & goto apply_color
if "!newcolor!"=="9" set "newcolor=F0" & goto apply_color
if "!newcolor!"=="10" set "newcolor=09" & goto apply_color
if "!newcolor!"=="11" set "newcolor=0F" & goto apply_color
if "!newcolor!"=="12" set "newcolor=E0" & goto apply_color
if "!newcolor!"=="13" set "newcolor=02" & goto apply_color
if "!newcolor!"=="14" set "newcolor=07" & goto apply_color
if "!newcolor!"=="15" set "newcolor=1E" & goto apply_color
if "!newcolor!"=="16" set "newcolor=2F" & goto apply_color
if "!newcolor!"=="17" set "newcolor=3F" & goto apply_color
if "!newcolor!"=="18" set "newcolor=4F" & goto apply_color
if "!newcolor!"=="19" set "newcolor=5E" & goto apply_color
if "!newcolor!"=="20" set "newcolor=6F" & goto apply_color
if "!newcolor!"=="21" set "newcolor=7C" & goto apply_color
if "!newcolor!"=="22" set "newcolor=80" & goto apply_color
if "!newcolor!"=="23" set "newcolor=90" & goto apply_color
if "!newcolor!"=="24" set "newcolor=A0" & goto apply_color
if "!newcolor!"=="25" set "newcolor=B0" & goto apply_color
if "!newcolor!"=="26" set "newcolor=D0" & goto apply_color
if "!newcolor!"=="27" set "newcolor=E0" & goto apply_color
if "!newcolor!"=="28" set "newcolor=F0" & goto apply_color
if "!newcolor!"=="29" set "newcolor=0D" & goto apply_color
if "!newcolor!"=="30" set "newcolor=0E" & goto apply_color

REM Numeric range check
echo !newcolor!| findstr /r "^[0-9][0-9]*$" >nul
if !errorlevel! equ 0 (
    if !newcolor! geq 1 if !newcolor! leq 30 (
        echo.
        echo [!] Please select from the preset numbers 1-30 above.
        timeout /t 2 >nul
        goto change_color
    ) else (
        echo.
        echo [!] Invalid number! Please enter a number between 1 and 30.
        timeout /t 2 >nul
        goto change_color
    )
)

REM Allow 2-digit HEX or 1-digit HEX (auto-prefixed with 0)
echo !newcolor!| findstr /r /i "^[0-9A-F][0-9A-F]$" >nul
if !errorlevel! equ 0 goto apply_color

echo !newcolor!| findstr /r /i "^[0-9A-F]$" >nul
if !errorlevel! equ 0 (
    set "newcolor=0!newcolor!"
    goto apply_color
)

echo.
echo [!] Invalid color code! Please enter a number between 1-30 or a valid hex code.
timeout /t 2 >nul
goto change_color

:apply_color
set "CLI_COLOR=!newcolor!"
color !CLI_COLOR!
echo.
echo [i] CLI color changed to !CLI_COLOR!.
timeout /t 1 >nul
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

:exclude_apps
:: Clean temp files and create directory
set "TEMP_DIR=%TEMP%\winget_temp"
rd /s /q "%TEMP_DIR%" 2>nul
mkdir "%TEMP_DIR%" 2>nul

echo.
echo [i] Fetching upgradable applications...

:: Get upgradable apps and filter output
>"%TEMP_DIR%\raw_list.txt" winget upgrade

:: Process and number the apps
set "count=0"
(for /f "skip=3 tokens=1,2,3,4,*" %%a in ('type "%TEMP_DIR%\raw_list.txt"') do (
    if "%%a" NEQ "" (
        echo %%a | findstr /i "upgrades available" >nul || (
            echo %%a | findstr /r "^-" >nul || (
                set /a "count+=1"
                echo !count! - %%a %%b %%c %%d %%e
                if "%%c" NEQ "" (
                    echo %%c>"%TEMP_DIR%\id_!count!.txt"
                ) else (
                    echo %%b>"%TEMP_DIR%\id_!count!.txt"
                )
            )
        )
    )
)) > "%TEMP_DIR%\numbered_list.txt"

:: Display the list
type "%TEMP_DIR%\numbered_list.txt"

:: Check if there are upgradable apps
if %count%==0 (
    echo.
    echo [i] No upgradable applications found.
    timeout /t 2 >nul
    rd /s /q "%TEMP_DIR%" 2>nul
    goto menu
)

echo.
echo [i] Enter the numbers of the applications you want to EXCLUDE from upgrade.
echo [i] Separate multiple numbers with spaces (e.g. 2 5 7).
echo [i] Press M to return to Main Menu without making a selection.
set /p exclude_nums="Exclude (1-%count%) or M: "

if /i "%exclude_nums%"=="M" (
    rd /s /q "%TEMP_DIR%" 2>nul
    goto menu
)

:: Validate input
set "valid=1"
for %%n in (%exclude_nums%) do (
    echo %%n| findstr /r "^[0-9][0-9]*$" >nul || set "valid=0"
    if %%n lss 1 set "valid=0"
    if %%n gtr %count% set "valid=0"
)
if "!valid!"=="0" (
    echo.
    echo [!] Invalid input! Please enter numbers between 1 and %count%.
    timeout /t 2 >nul
    rd /s /q "%TEMP_DIR%" 2>nul
    goto exclude_apps
)

:: Show summary
echo.
echo [i] Applications to be EXCLUDED from upgrade:
for %%x in (%exclude_nums%) do (
    findstr /b "%%x -" "%TEMP_DIR%\numbered_list.txt"
)

echo.
echo [i] Applications to be UPGRADED:
for /L %%i in (1,1,%count%) do (
    set "skip=0"
    for %%x in (%exclude_nums%) do (
        if %%i equ %%x set "skip=1"
    )
    if !skip! equ 0 (
        findstr /b "%%i -" "%TEMP_DIR%\numbered_list.txt"
    )
)

echo.
set /p confirm="Do you want to proceed with the upgrade? (Y/N/M): "
if /i "%confirm%"=="M" (
    rd /s /q "%TEMP_DIR%" 2>nul
    goto menu
)
if /i "%confirm%"=="N" (
    rd /s /q "%TEMP_DIR%" 2>nul
    goto menu
)
if /i "%confirm%"=="Y" goto start_upgrade_exclude

echo.
echo [!] Invalid input! Please press Y, N, or M.
timeout /t 2 >nul
goto exclude_apps

:start_upgrade_exclude
echo.
echo [~] Starting upgrades (excluding selected apps)... (Please wait)

:: Upgrade non-excluded apps
for /L %%i in (1,1,%count%) do (
    set "skip=0"
    for %%x in (%exclude_nums%) do (
        if %%i equ %%x set "skip=1"
    )
    if !skip! equ 0 (
        set /p app_id=<"%TEMP_DIR%\id_%%i.txt"
        echo [~] Upgrading: !app_id!
        winget upgrade --id "!app_id!" --accept-package-agreements --accept-source-agreements --silent
    )
)

:: Cleanup
rd /s /q "%TEMP_DIR%" 2>nul

echo.
echo [✓] Selected apps upgraded successfully!
echo [i] Some changes may require system restart.
pause
goto menu

:exit_script
echo.
echo [i] Exiting DatHex. Goodbye!
timeout /t 5 >nul
exit
