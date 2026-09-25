@echo off
setlocal EnableExtensions EnableDelayedExpansion

title SFN LaTeX Workshop - Windows Setup

rem ============================================================================
rem SFN LaTeX Workshop - Windows installation script
rem Target: 64-bit Windows 10/11 Home/Pro with WinGet available
rem Runs from cmd.exe; no PowerShell commands are used.
rem
rem Installs:
rem   - Git
rem   - MiKTeX
rem   - Strawberry Perl (needed by latexmk)
rem   - Visual Studio Code
rem   - LaTeX Workshop extension for VS Code
rem   - TeXstudio
rem
rem Then:
rem   - enables MiKTeX automatic package installation
rem   - installs/updates latexmk and biber
rem   - creates and compiles a small LaTeX test document
rem ============================================================================

echo.
echo ================================================================
echo   SFN LaTeX Workshop - Windows Setup
echo ================================================================
echo.

rem --- Basic Windows check ----------------------------------------------------
ver | findstr /i "Windows" >nul 2>&1
if errorlevel 1 (
    echo [ERROR] This script must be run on Windows.
    goto :fatal
)

if /i not "%PROCESSOR_ARCHITECTURE%"=="AMD64" if /i not "%PROCESSOR_ARCHITEW6432%"=="AMD64" (
    echo [WARNING] This script is tested for 64-bit x86 Windows only.
    echo           Detected architecture: %PROCESSOR_ARCHITECTURE%
    echo.
)

rem --- WinGet is required -----------------------------------------------------
where winget.exe >nul 2>&1
if errorlevel 1 (
    echo [ERROR] WinGet was not found.
    echo.
    echo WinGet is normally provided by Microsoft App Installer on current
    echo Windows 10/11 systems. Install/update "App Installer" from the
    echo Microsoft Store and run this script again.
    echo.
    echo The Microsoft Store page will now be opened if possible.
    start "" "ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1" >nul 2>&1
    goto :fatal
)

echo [OK] WinGet found.
winget --version

echo.
echo Updating WinGet package sources...
winget source update
if errorlevel 1 (
    echo [WARNING] WinGet source update reported an error.
    echo           The script will nevertheless try to continue.
)

set "FAILED=0"

rem --- Install applications --------------------------------------------------
call :InstallPackage "Git.Git" "Git"
call :InstallPackage "MiKTeX.MiKTeX" "MiKTeX"
call :InstallPackage "StrawberryPerl.StrawberryPerl" "Strawberry Perl"
call :InstallPackage "Microsoft.VisualStudioCode" "Visual Studio Code"
call :InstallPackage "TeXstudio.TeXstudio" "TeXstudio"

rem --- Make newly installed programs visible in THIS cmd session -------------
call :AddPath "%ProgramFiles%\Git\cmd"
call :AddPath "%ProgramFiles%\Microsoft VS Code\bin"
call :AddPath "%LOCALAPPDATA%\Programs\Microsoft VS Code\bin"
call :AddPath "%LOCALAPPDATA%\Programs\MiKTeX\miktex\bin\x64"
call :AddPath "%ProgramFiles%\MiKTeX\miktex\bin\x64"
call :AddPath "C:\Strawberry\perl\bin"
call :AddPath "C:\Strawberry\c\bin"

rem --- Locate MiKTeX ---------------------------------------------------------
set "MIKTEXBIN="
for %%D in (
    "%LOCALAPPDATA%\Programs\MiKTeX\miktex\bin\x64"
    "%ProgramFiles%\MiKTeX\miktex\bin\x64"
) do (
    if exist "%%~D\initexmf.exe" set "MIKTEXBIN=%%~D"
)

if not defined MIKTEXBIN (
    for /f "delims=" %%I in ('where initexmf.exe 2^>nul') do (
        if not defined MIKTEXBIN set "MIKTEXBIN=%%~dpI"
    )
)

if not defined MIKTEXBIN (
    echo.
    echo [ERROR] MiKTeX was installed or detected by WinGet, but its command
    echo         line tools cannot be found in this CMD session.
    echo         Close CMD, open a new CMD window and run this script again.
    set "FAILED=1"
    goto :AfterMiKTeX
)

echo.
echo [OK] MiKTeX command directory:
echo      %MIKTEXBIN%

rem --- Configure MiKTeX ------------------------------------------------------
echo.
echo Configuring MiKTeX automatic package installation...
"%MIKTEXBIN%\initexmf.exe" --set-config-value=[MPM]AutoInstall=yes
if errorlevel 1 (
    echo [WARNING] Could not set MiKTeX AutoInstall automatically.
    echo           You can later set it in MiKTeX Console to "Always".
) else (
    echo [OK] MiKTeX automatic package installation enabled.
)

echo.
echo Updating MiKTeX package database...
"%MIKTEXBIN%\miktex.exe" packages update
if errorlevel 1 (
    echo [WARNING] MiKTeX package update reported an error.
)

echo.
echo Installing MiKTeX package: latexmk
"%MIKTEXBIN%\miktex.exe" packages install latexmk
if errorlevel 1 (
    echo [WARNING] latexmk could not be installed automatically.
    set "FAILED=1"
) else (
    echo [OK] latexmk installed/available.
)

echo.
echo Installing MiKTeX package: biber
"%MIKTEXBIN%\miktex.exe" packages install biber
if errorlevel 1 (
    echo [WARNING] biber could not be installed automatically.
    set "FAILED=1"
) else (
    echo [OK] biber installed/available.
)

:AfterMiKTeX

rem --- Locate VS Code command ------------------------------------------------
set "CODECMD="
if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd" set "CODECMD=%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd"
if exist "%ProgramFiles%\Microsoft VS Code\bin\code.cmd" set "CODECMD=%ProgramFiles%\Microsoft VS Code\bin\code.cmd"
if not defined CODECMD (
    for /f "delims=" %%I in ('where code.cmd 2^>nul') do (
        if not defined CODECMD set "CODECMD=%%I"
    )
)

if defined CODECMD (
    echo.
    echo Installing/updating VS Code extension: LaTeX Workshop...
    call "%CODECMD%" --install-extension James-Yu.latex-workshop --force
    if errorlevel 1 (
        echo [WARNING] LaTeX Workshop extension installation failed.
        set "FAILED=1"
    ) else (
        echo [OK] LaTeX Workshop extension installed.
    )
) else (
    echo.
    echo [WARNING] VS Code command line tool code.cmd was not found.
    echo           Install LaTeX Workshop manually in VS Code if necessary.
    set "FAILED=1"
)

rem --- Verify tools ----------------------------------------------------------
echo.
echo ================================================================
echo   Verification
 echo ================================================================

call :CheckCommand git.exe "Git"
call :CheckCommand perl.exe "Perl"
call :CheckCommand pdflatex.exe "pdfLaTeX"
call :CheckCommand biber.exe "Biber"
call :CheckCommand latexmk.exe "latexmk"

rem --- Create a test document ------------------------------------------------
if defined MIKTEXBIN if exist "%MIKTEXBIN%\pdflatex.exe" (
    set "TESTDIR=%USERPROFILE%\Documents\latex-test"
    if not exist "!TESTDIR!" mkdir "!TESTDIR!" >nul 2>&1

    set "TESTFILE=!TESTDIR!\test.tex"
    >"!TESTFILE!" echo \documentclass{article}
    >>"!TESTFILE!" echo \usepackage[T1]{fontenc}
    >>"!TESTFILE!" echo \usepackage[ngerman]{babel}
    >>"!TESTFILE!" echo \begin{document}
    >>"!TESTFILE!" echo SFN LaTeX Workshop -- Installation erfolgreich.
    >>"!TESTFILE!" echo \[
    >>"!TESTFILE!" echo E = mc^^2
    >>"!TESTFILE!" echo \]
    >>"!TESTFILE!" echo \end{document}

    echo.
    echo Compiling test document...
    pushd "!TESTDIR!"
    "%MIKTEXBIN%\pdflatex.exe" --enable-installer -interaction=nonstopmode -halt-on-error test.tex
    if errorlevel 1 (
        echo [WARNING] Test document compilation failed.
        echo           Check !TESTDIR!\test.log for details.
        set "FAILED=1"
    ) else (
        echo [OK] Test PDF created:
        echo      !TESTDIR!\test.pdf
    )
    popd
)

echo.
echo ================================================================
if "%FAILED%"=="0" (
    echo   SETUP COMPLETED SUCCESSFULLY
    echo ================================================================
    echo.
    echo Installed/configured:
    echo   - Git
    echo   - MiKTeX
    echo   - Strawberry Perl
    echo   - Visual Studio Code
    echo   - LaTeX Workshop
    echo   - TeXstudio
    echo   - latexmk and biber
    echo.
    echo Recommendation: close this CMD window and open a NEW CMD window
    echo before using the tools, so Windows reloads the permanent PATH.
) else (
    echo   SETUP COMPLETED WITH WARNINGS
    echo ================================================================
    echo.
    echo At least one step could not be completed automatically.
    echo Read the messages above. In many cases, opening a new CMD window
    echo and running this script once more is sufficient.
)

echo.
pause
exit /b %FAILED%

rem ============================================================================
rem Subroutines
rem ============================================================================

:InstallPackage
set "PKGID=%~1"
set "PKGNAME=%~2"
echo.
echo ----------------------------------------------------------------
echo Checking %PKGNAME%...
winget list --id "%PKGID%" -e --source winget >nul 2>&1
if not errorlevel 1 (
    echo [OK] %PKGNAME% is already installed.
    exit /b 0
)

echo Installing %PKGNAME%...
winget install --id "%PKGID%" -e --source winget --accept-package-agreements --accept-source-agreements --silent
if errorlevel 1 (
    echo [ERROR] Installation failed: %PKGNAME% [%PKGID%]
    set "FAILED=1"
) else (
    echo [OK] %PKGNAME% installed.
)
exit /b 0

:AddPath
if exist "%~1" (
    echo ;%PATH%; | find /i ";%~1;" >nul 2>&1
    if errorlevel 1 set "PATH=%~1;%PATH%"
)
exit /b 0

:CheckCommand
where %~1 >nul 2>&1
if errorlevel 1 (
    echo [WARNING] %~2 - NOT FOUND
    set "FAILED=1"
) else (
    echo [OK]      %~2 - found
)
exit /b 0

:fatal
echo.
echo Setup aborted.
echo.
pause
exit /b 1
