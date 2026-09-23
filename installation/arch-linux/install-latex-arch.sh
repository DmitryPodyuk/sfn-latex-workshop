#!/usr/bin/env bash

set -euo pipefail

echo "=================================================="
echo " SFN LaTeX setup for Arch Linux"
echo " TeX Live + TeXStudio + VS Code + LaTeX Workshop"
echo "=================================================="
echo

# --------------------------------------------------
# Safety check
# --------------------------------------------------

if [ "$EUID" -eq 0 ]; then
    echo "ERROR: Do not run this script as root."
    echo
    echo "Run it as your normal user:"
    echo "    ./install-latex-arch.sh"
    echo
    echo "The script will use sudo where required."
    exit 1
fi


# --------------------------------------------------
# 1. System information
# --------------------------------------------------

echo ">>> Linux distribution:"

if [ -f /etc/os-release ]; then
    cat /etc/os-release
fi

echo
echo ">>> Architecture:"
uname -m
echo


# --------------------------------------------------
# 2. Update Arch Linux
# --------------------------------------------------

echo ">>> Updating Arch Linux..."

sudo pacman -Syu --noconfirm


# --------------------------------------------------
# 3. Basic tools
# --------------------------------------------------

echo
echo ">>> Installing basic development tools..."

sudo pacman -S --needed --noconfirm \
    base-devel \
    git \
    curl \
    wget \
    ca-certificates


# --------------------------------------------------
# 4. Install TeX Live
# --------------------------------------------------

echo
echo ">>> Installing TeX Live..."

sudo pacman -S --needed --noconfirm \
    texlive-basic \
    texlive-latex \
    texlive-latexrecommended \
    texlive-latexextra \
    texlive-fontsrecommended \
    texlive-langgerman \
    texlive-mathscience \
    texlive-pictures \
    texlive-xetex \
    texlive-luatex \
    texlive-binextra \
    biber

echo
echo ">>> TeX Live installed."


# --------------------------------------------------
# 5. Install TeXStudio
# --------------------------------------------------

echo
echo ">>> Installing TeXStudio..."

sudo pacman -S --needed --noconfirm texstudio

echo
echo ">>> TeXStudio installed."


# --------------------------------------------------
# 6. Install Microsoft Visual Studio Code
# --------------------------------------------------
#
# Microsoft VS Code is not the same package as Arch's
# repository package "code" (Code OSS).
#
# We install visual-studio-code-bin from the AUR.
#
# If yay is already installed, use it.
# Otherwise build the AUR package directly.
# --------------------------------------------------

echo
echo ">>> Installing Microsoft Visual Studio Code..."

if command -v code >/dev/null 2>&1; then

    echo ">>> A 'code' command already exists:"
    command -v code
    echo ">>> Existing VS Code installation will be used."

elif command -v yay >/dev/null 2>&1; then

    echo ">>> yay detected."
    yay -S --needed --noconfirm visual-studio-code-bin

else

    echo ">>> yay not found."
    echo ">>> Building visual-studio-code-bin directly from AUR..."

    BUILD_DIR="$(mktemp -d)"

    cleanup() {
        rm -rf "$BUILD_DIR"
    }

    trap cleanup EXIT

    git clone \
        https://aur.archlinux.org/visual-studio-code-bin.git \
        "$BUILD_DIR/visual-studio-code-bin"

    cd "$BUILD_DIR/visual-studio-code-bin"

    makepkg -si --noconfirm

    cd "$HOME"

fi


# --------------------------------------------------
# 7. Verify VS Code
# --------------------------------------------------

echo
echo ">>> Checking VS Code..."

if ! command -v code >/dev/null 2>&1; then
    echo
    echo "ERROR: VS Code installation failed."
    exit 1
fi

code --version | head -n 1


# --------------------------------------------------
# 8. Install LaTeX Workshop
# --------------------------------------------------

echo
echo ">>> Installing LaTeX Workshop..."

code --install-extension James-Yu.latex-workshop --force


# --------------------------------------------------
# 9. Configure VS Code
# --------------------------------------------------

VSCODE_DIR="$HOME/.config/Code/User"
VSCODE_SETTINGS="$VSCODE_DIR/settings.json"

mkdir -p "$VSCODE_DIR"

if [ ! -e "$VSCODE_SETTINGS" ]; then

    echo
    echo ">>> Creating VS Code LaTeX settings..."

    cat > "$VSCODE_SETTINGS" <<'EOF'
{
    "latex-workshop.latex.autoBuild.run": "onSave",
    "latex-workshop.view.pdf.viewer": "tab"
}
EOF

else

    echo
    echo ">>> Existing VS Code settings detected:"
    echo "    $VSCODE_SETTINGS"
    echo
    echo ">>> Existing settings will NOT be overwritten."
    echo
    echo "Add the following entries manually if required:"
    echo
    echo '    "latex-workshop.latex.autoBuild.run": "onSave",'
    echo '    "latex-workshop.view.pdf.viewer": "tab"'
    echo

fi


# --------------------------------------------------
# 10. Verify TeX commands
# --------------------------------------------------

echo
echo "=================================================="
echo " Checking installed programs"
echo "=================================================="
echo

for program in \
    pdflatex \
    xelatex \
    lualatex \
    latexmk \
    biber \
    chktex \
    texstudio \
    code
do

    printf "%-15s : " "$program"

    if command -v "$program" >/dev/null 2>&1; then
        command -v "$program"
    else
        echo "NOT FOUND"
    fi

done


# --------------------------------------------------
# 11. Create a test project
# --------------------------------------------------

TESTDIR="$HOME/Documents/latex-test"

echo
echo ">>> Creating test project:"
echo "    $TESTDIR"

mkdir -p "$TESTDIR"

cat > "$TESTDIR/test.tex" <<'EOF'
\documentclass[a4paper,12pt]{article}

\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[ngerman]{babel}
\usepackage{amsmath}
\usepackage{graphicx}
\usepackage{hyperref}

\title{LaTeX-Test unter Arch Linux}
\author{SFN}
\date{\today}

\begin{document}

\maketitle

\section{Erster Test}

Hallo SFN!

Diese Datei wurde mit \LaTeX{} unter Arch Linux erstellt.

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
EOF


# --------------------------------------------------
# 12. Compile the test document
# --------------------------------------------------

echo
echo ">>> Testing LaTeX compilation..."

cd "$TESTDIR"

latexmk \
    -pdf \
    -interaction=nonstopmode \
    -halt-on-error \
    test.tex


# --------------------------------------------------
# 13. Check result
# --------------------------------------------------

if [ ! -f "$TESTDIR/test.pdf" ]; then
    echo
    echo "ERROR: test.pdf was not created."
    exit 1
fi


# --------------------------------------------------
# 14. Results
# --------------------------------------------------

echo
echo "=================================================="
echo " Installation completed successfully"
echo "=================================================="
echo

echo "TeX Live / pdfLaTeX:"
pdflatex --version | head -n 2
echo

echo "XeLaTeX:"
xelatex --version | head -n 1
echo

echo "LuaLaTeX:"
lualatex --version | head -n 1
echo

echo "latexmk:"
latexmk --version | head -n 2
echo

echo "Biber:"
biber --version
echo

echo "VS Code:"
code --version | head -n 1
echo

echo "TeXStudio:"
texstudio --version 2>/dev/null | head -n 1 || true
echo

echo "Test document:"
echo "    $TESTDIR/test.pdf"
echo

echo "Open the project in VS Code:"
echo "    code \"$TESTDIR\""
echo

echo "Open the document in TeXStudio:"
echo "    texstudio \"$TESTDIR/test.tex\""
echo

echo "Done."