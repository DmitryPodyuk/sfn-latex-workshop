#!/usr/bin/env bash

set -euo pipefail

echo "=================================================="
echo " SFN LaTeX setup for Linux Mint"
echo " TeX Live + TeXStudio + VS Code + LaTeX Workshop"
echo "=================================================="
echo

# --------------------------------------------------
# 1. System information
# --------------------------------------------------

echo ">>> Linux distribution:"
if command -v lsb_release >/dev/null 2>&1; then
    lsb_release -a || true
else
    cat /etc/os-release
fi

echo
echo ">>> Architecture:"
dpkg --print-architecture
echo


# --------------------------------------------------
# 2. Update package information
# --------------------------------------------------

echo ">>> Updating APT package database..."

sudo apt update


# --------------------------------------------------
# 3. Basic tools
# --------------------------------------------------

echo ">>> Installing basic tools..."

sudo apt install -y \
    wget \
    gpg \
    ca-certificates \
    curl \
    git


# --------------------------------------------------
# 4. Install TeX Live
# --------------------------------------------------

echo ">>> Installing TeX Live..."

sudo apt install -y \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-lang-german \
    texlive-science \
    texlive-pictures \
    texlive-xetex \
    texlive-luatex \
    latexmk \
    biber \
    chktex

echo
echo ">>> TeX Live installed."


# --------------------------------------------------
# 5. Install TeXStudio
# --------------------------------------------------

echo ">>> Installing TeXStudio..."

sudo apt install -y texstudio

echo
echo ">>> TeXStudio installed."


# --------------------------------------------------
# 6. Microsoft signing key for VS Code
# --------------------------------------------------

echo ">>> Installing Microsoft repository key..."

sudo rm -f /usr/share/keyrings/microsoft.gpg

wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null

sudo chmod 644 /usr/share/keyrings/microsoft.gpg


# --------------------------------------------------
# 7. Add official Microsoft VS Code repository
# --------------------------------------------------

echo ">>> Adding official Microsoft VS Code repository..."

sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null <<'EOF'
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF


# --------------------------------------------------
# 8. Install VS Code
# --------------------------------------------------

echo ">>> Updating package database..."

sudo apt update

echo ">>> Installing Visual Studio Code..."

sudo apt install -y code


# --------------------------------------------------
# 9. Install LaTeX Workshop extension
# --------------------------------------------------

echo ">>> Installing LaTeX Workshop extension..."

code --install-extension James-Yu.latex-workshop --force


# --------------------------------------------------
# 10. Configure VS Code
# --------------------------------------------------

VSCODE_DIR="$HOME/.config/Code/User"
VSCODE_SETTINGS="$VSCODE_DIR/settings.json"

mkdir -p "$VSCODE_DIR"

if [ ! -e "$VSCODE_SETTINGS" ]; then

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
    echo "    The installer will NOT overwrite them."
    echo
    echo "    Add these settings manually if required:"
    echo
    echo '    "latex-workshop.latex.autoBuild.run": "onSave",'
    echo '    "latex-workshop.view.pdf.viewer": "tab"'
    echo

fi


# --------------------------------------------------
# 11. Verify commands
# --------------------------------------------------

echo
echo "=================================================="
echo " Checking installed programs"
echo "=================================================="
echo

for program in pdflatex xelatex lualatex latexmk biber texstudio code; do

    printf "%-15s : " "$program"

    if command -v "$program" >/dev/null 2>&1; then
        command -v "$program"
    else
        echo "NOT FOUND"
    fi

done


# --------------------------------------------------
# 12. Create a test LaTeX project
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

\title{LaTeX-Test unter Linux Mint}
\author{SFN}
\date{\today}

\begin{document}

\maketitle

\section{Erster Test}

Hallo SFN!

Diese Datei wurde mit \LaTeX{} unter Linux Mint erstellt.

\section{Mathematik}

Einstein:

\[
E = mc^2
\]

Die quadratische Gleichung:

\[
x_{1,2}
=
\frac{-b \pm \sqrt{b^2-4ac}}{2a}
\]

\section{Links}

Weitere Informationen:

\url{https://www.latex-project.org/}

\end{document}
EOF


# --------------------------------------------------
# 13. Compile test document
# --------------------------------------------------

echo
echo ">>> Testing LaTeX compilation..."

cd "$TESTDIR"

latexmk -pdf -interaction=nonstopmode test.tex


# --------------------------------------------------
# 14. Result
# --------------------------------------------------

echo
echo "=================================================="
echo " Installation completed successfully"
echo "=================================================="
echo
echo "TeX Live:"
pdflatex --version | head -n 2
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

echo "Test document:"
echo "    $TESTDIR/test.pdf"
echo
echo "Open project in VS Code:"
echo "    code \"$TESTDIR\""
echo
echo "Open project in TeXStudio:"
echo "    texstudio \"$TESTDIR/test.tex\""
echo
echo "Done."