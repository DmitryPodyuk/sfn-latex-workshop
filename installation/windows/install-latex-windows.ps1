# ============================================================
# SFN LaTeX setup for Windows
#
# Installs:
#   - MiKTeX
#   - Strawberry Perl
#   - Microsoft Visual Studio Code
#   - LaTeX Workshop
#   - TeXStudio
#
# Configures:
#   - automatic MiKTeX package installation
#   - VS Code LaTeX Workshop
#
# Creates and compiles:
#   - Documents\latex-test\test.tex
#
# ============================================================

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest


# ------------------------------------------------------------
# Helper functions
# ------------------------------------------------------------

function Write-Section {
    param([string]$Text)

    Write-Host ""
    Write-Host "============================================================"
    Write-Host " $Text"
    Write-Host "============================================================"
    Write-Host ""
}


function Refresh-ProcessPath {

    $machinePath = [Environment]::GetEnvironmentVariable(
        "Path",
        [EnvironmentVariableTarget]::Machine
    )

    $userPath = [Environment]::GetEnvironmentVariable(
        "Path",
        [EnvironmentVariableTarget]::User
    )

    $env:Path = "$machinePath;$userPath"


    # Common locations which may not yet have propagated
    # into the current PowerShell process.

    $extraPaths = @(

        "$env:LOCALAPPDATA\Programs\MiKTeX\miktex\bin\x64",
        "$env:ProgramFiles\MiKTeX\miktex\bin\x64",

        "C:\Strawberry\perl\bin",
        "C:\Strawberry\perl\site\bin",
        "C:\Strawberry\c\bin",

        "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin",
        "$env:ProgramFiles\Microsoft VS Code\bin"
    )

    foreach ($path in $extraPaths) {

        if (
            (Test-Path $path) -and
            ($env:Path -notlike "*$path*")
        ) {
            $env:Path += ";$path"
        }
    }
}


function Install-WingetPackage {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Id,

        [Parameter(Mandatory = $true)]
        [string]$Name,

        [string]$Scope = ""
    )

    Write-Host ">>> Installing/checking $Name..."

    $arguments = @(

        "install",
        "--id", $Id,
        "--exact",
        "--source", "winget",
        "--accept-package-agreements",
        "--accept-source-agreements",
        "--silent"
    )

    if ($Scope -ne "") {
        $arguments += @("--scope", $Scope)
    }

    & winget @arguments

    if ($LASTEXITCODE -ne 0) {

        Write-Warning "$Name installation returned exit code $LASTEXITCODE."

        Write-Host "Checking whether the package is already installed..."

        & winget list --id $Id --exact

        if ($LASTEXITCODE -ne 0) {
            throw "Installation of $Name failed."
        }
    }

    Write-Host ""
}


function Test-Command {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Command
    )

    $result = Get-Command $Command -ErrorAction SilentlyContinue

    if ($null -eq $result) {

        Write-Host ("{0,-15} : NOT FOUND" -f $Command)

        return $false
    }

    Write-Host ("{0,-15} : {1}" -f $Command, $result.Source)

    return $true
}


# ------------------------------------------------------------
# Header
# ------------------------------------------------------------

Write-Section "SFN LaTeX setup for Windows"

Write-Host "MiKTeX + Strawberry Perl + VS Code + LaTeX Workshop + TeXStudio"
Write-Host ""


# ------------------------------------------------------------
# 1. Check WinGet
# ------------------------------------------------------------

Write-Section "Checking Windows Package Manager"

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {

    Write-Host "ERROR: winget was not found."
    Write-Host ""
    Write-Host "Install/update 'App Installer' from Microsoft Store"
    Write-Host "and run this script again."

    exit 1
}

Write-Host "WinGet:"
winget --version


# ------------------------------------------------------------
# 2. Install MiKTeX
# ------------------------------------------------------------

Write-Section "Installing MiKTeX"

Install-WingetPackage `
    -Id "MiKTeX.MiKTeX" `
    -Name "MiKTeX" `
    -Scope "user"


# ------------------------------------------------------------
# 3. Install Strawberry Perl
# ------------------------------------------------------------
#
# MiKTeX does not include Perl.
#
# LaTeX Workshop uses latexmk by default.
# latexmk is written in Perl.
#
# ------------------------------------------------------------

Write-Section "Installing Strawberry Perl"

Install-WingetPackage `
    -Id "StrawberryPerl.StrawberryPerl" `
    -Name "Strawberry Perl"


# ------------------------------------------------------------
# 4. Install Microsoft Visual Studio Code
# ------------------------------------------------------------

Write-Section "Installing Microsoft Visual Studio Code"

Install-WingetPackage `
    -Id "Microsoft.VisualStudioCode" `
    -Name "Microsoft Visual Studio Code" `
    -Scope "user"


# ------------------------------------------------------------
# 5. Install TeXStudio
# ------------------------------------------------------------

Write-Section "Installing TeXStudio"

Install-WingetPackage `
    -Id "TeXstudio.TeXstudio" `
    -Name "TeXStudio"


# ------------------------------------------------------------
# 6. Refresh PATH
# ------------------------------------------------------------

Write-Section "Refreshing PATH"

Refresh-ProcessPath

Write-Host $env:Path


# ------------------------------------------------------------
# 7. Check MiKTeX
# ------------------------------------------------------------

Write-Section "Checking MiKTeX"

if (-not (Get-Command miktex -ErrorAction SilentlyContinue)) {

    Write-Host "MiKTeX command not found."
    Write-Host ""
    Write-Host "Try closing PowerShell and running the script again."
    Write-Host ""

    exit 1
}

Write-Host "MiKTeX:"
miktex --version


# ------------------------------------------------------------
# 8. Update MiKTeX package database
# ------------------------------------------------------------

Write-Section "Updating MiKTeX package database"

miktex packages update-package-database


# ------------------------------------------------------------
# 9. Enable automatic package installation
# ------------------------------------------------------------

Write-Section "Enabling MiKTeX automatic package installation"

if (Get-Command initexmf -ErrorAction SilentlyContinue) {

    initexmf --set-config-value "[MPM]AutoInstall=1"
    initexmf --update-fndb

}
else {

    Write-Warning "initexmf was not found."

}


# ------------------------------------------------------------
# 10. Install packages needed by our workflow
# ------------------------------------------------------------

Write-Section "Installing important MiKTeX packages"

miktex --enable-installer packages install `
    latexmk `
    biber


# ------------------------------------------------------------
# 11. Refresh MiKTeX filename database
# ------------------------------------------------------------

Write-Host ""
Write-Host ">>> Refreshing MiKTeX filename database..."

miktex fndb refresh


# ------------------------------------------------------------
# 12. Refresh PATH again
# ------------------------------------------------------------

Refresh-ProcessPath


# ------------------------------------------------------------
# 13. Check Perl
# ------------------------------------------------------------

Write-Section "Checking Perl"

if (Get-Command perl -ErrorAction SilentlyContinue) {

    perl --version | Select-Object -First 3

}
else {

    Write-Warning "Perl was not found in the current PATH."
    Write-Host ""
    Write-Host "A Windows restart or logout/login may be required."

}


# ------------------------------------------------------------
# 14. Check LaTeX commands
# ------------------------------------------------------------

Write-Section "Checking LaTeX commands"

Test-Command "pdflatex"
Test-Command "xelatex"
Test-Command "lualatex"
Test-Command "latexmk"
Test-Command "biber"
Test-Command "perl"


# ------------------------------------------------------------
# 15. Check VS Code
# ------------------------------------------------------------

Write-Section "Checking VS Code"

if (-not (Get-Command code -ErrorAction SilentlyContinue)) {

    Refresh-ProcessPath

}

if (-not (Get-Command code -ErrorAction SilentlyContinue)) {

    Write-Host "VS Code is installed, but 'code' is not yet visible."
    Write-Host ""
    Write-Host "Close PowerShell and open it again."
    Write-Host "Then run:"
    Write-Host ""
    Write-Host "    code --version"
    Write-Host ""

    exit 1
}

code --version


# ------------------------------------------------------------
# 16. Install LaTeX Workshop
# ------------------------------------------------------------

Write-Section "Installing LaTeX Workshop"

code `
    --install-extension James-Yu.latex-workshop `
    --force


# ------------------------------------------------------------
# 17. Configure VS Code
# ------------------------------------------------------------

Write-Section "Configuring VS Code"

$VSCodeDirectory = Join-Path `
    $env:APPDATA `
    "Code\User"

$VSCodeSettings = Join-Path `
    $VSCodeDirectory `
    "settings.json"

New-Item `
    -ItemType Directory `
    -Force `
    -Path $VSCodeDirectory `
    | Out-Null


if (-not (Test-Path $VSCodeSettings)) {

    Write-Host ">>> Creating VS Code settings.json..."

    @'
{
    "latex-workshop.latex.autoBuild.run": "onSave",
    "latex-workshop.view.pdf.viewer": "tab"
}
'@ | Set-Content `
        -Path $VSCodeSettings `
        -Encoding UTF8

}
else {

    Write-Host ""
    Write-Host "Existing VS Code settings detected:"
    Write-Host ""
    Write-Host "    $VSCodeSettings"
    Write-Host ""
    Write-Host "The script will NOT overwrite them."
    Write-Host ""
    Write-Host "Add these settings manually if required:"
    Write-Host ""
    Write-Host '    "latex-workshop.latex.autoBuild.run": "onSave",'
    Write-Host '    "latex-workshop.view.pdf.viewer": "tab"'
    Write-Host ""

}


# ------------------------------------------------------------
# 18. Create test project
# ------------------------------------------------------------

Write-Section "Creating LaTeX test project"

$Documents = [Environment]::GetFolderPath(
    [Environment+SpecialFolder]::MyDocuments
)

$TestDirectory = Join-Path `
    $Documents `
    "latex-test"

New-Item `
    -ItemType Directory `
    -Force `
    -Path $TestDirectory `
    | Out-Null


$TestFile = Join-Path `
    $TestDirectory `
    "test.tex"


@'
\documentclass[a4paper,12pt]{article}

\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[ngerman]{babel}
\usepackage{amsmath}
\usepackage{graphicx}
\usepackage{hyperref}

\title{LaTeX-Test unter Windows}
\author{SFN}
\date{\today}

\begin{document}

\maketitle

\section{Erster Test}

Hallo SFN!

Diese Datei wurde mit \LaTeX{} unter Windows erstellt.

\section{Mathematik}

Einstein:

\[
E = mc^2
\]

Die quadratische Gleichung:

\[
x_{1,2}
=
\frac{-b \pm \sqrt{b^2-4ac}}{2a}.
\]

\section{Links}

Weitere Informationen:

\url{https://www.latex-project.org/}

\end{document}
'@ | Set-Content `
    -Path $TestFile `
    -Encoding UTF8


Write-Host "Test file:"
Write-Host ""
Write-Host "    $TestFile"


# ------------------------------------------------------------
# 19. Compile test document
# ------------------------------------------------------------

Write-Section "Testing LaTeX compilation"

Refresh-ProcessPath

Set-Location $TestDirectory


if (Get-Command latexmk -ErrorAction SilentlyContinue) {

    latexmk `
        -pdf `
        -interaction=nonstopmode `
        -halt-on-error `
        test.tex

}
elseif (Get-Command pdflatex -ErrorAction SilentlyContinue) {

    Write-Warning "latexmk not found. Falling back to pdflatex."

    pdflatex `
        -interaction=nonstopmode `
        -halt-on-error `
        test.tex

}
else {

    throw "Neither latexmk nor pdflatex could be found."

}


# ------------------------------------------------------------
# 20. Check PDF
# ------------------------------------------------------------

$TestPDF = Join-Path `
    $TestDirectory `
    "test.pdf"

if (-not (Test-Path $TestPDF)) {

    throw "LaTeX compilation failed: test.pdf was not created."

}


# ------------------------------------------------------------
# 21. Final verification
# ------------------------------------------------------------

Write-Section "Installation completed successfully"

Write-Host "Installed environment:"
Write-Host ""

Write-Host "MiKTeX:"
pdflatex --version | Select-Object -First 2
Write-Host ""

Write-Host "Perl:"
perl --version | Select-Object -First 2
Write-Host ""

Write-Host "latexmk:"
latexmk --version | Select-Object -First 3
Write-Host ""

Write-Host "Biber:"
biber --version
Write-Host ""

Write-Host "VS Code:"
code --version | Select-Object -First 1
Write-Host ""

Write-Host "Test document:"
Write-Host ""
Write-Host "    $TestPDF"
Write-Host ""

Write-Host "Open project in VS Code:"
Write-Host ""
Write-Host "    code `"$TestDirectory`""
Write-Host ""

Write-Host "Open the same file in TeXStudio:"
Write-Host ""
Write-Host "    $TestFile"
Write-Host ""

Write-Host "Done."