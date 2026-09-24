# LaTeX unter Linux Mint installieren

Diese Anleitung beschreibt die Installation der LaTeX-Arbeitsumgebung unter Linux Mint.

Verwendet werden:

- TeX Live
- Visual Studio Code
- LaTeX Workshop
- TeXStudio
- Git

Das Installationsskript befindet sich im gleichen Verzeichnis:

```text
install-latex.sh
```

---

## 1. Terminal öffnen

Unter Linux Mint kann das Terminal normalerweise mit

```text
Ctrl + Alt + T
```

geöffnet werden.

---

## 2. Repository herunterladen

Falls Git bereits installiert ist:

```bash
git clone https://github.com/DmitryPodyuk/sfn-latex-workshop.git
```

Danach:

```bash
cd sfn-latex-workshop/installation/linux-mint
```

Alternativ kann das Repository auf GitHub über

**Code → Download ZIP**

heruntergeladen und entpackt werden.

---

## 3. Skript ausführbar machen

```bash
chmod +x install-latex.sh
```

---

## 4. Installation starten

```bash
./install-latex.sh
```

Falls für einzelne Installationsschritte Administratorrechte benötigt werden, fragt `sudo` nach dem Benutzerpasswort.

---

## 5. Installation überprüfen

### LaTeX

```bash
pdflatex --version
```

### TeX Live

```bash
tlmgr --version
```

### Visual Studio Code

```bash
code --version
```

### Git

```bash
git --version
```

### TeXStudio

```bash
texstudio
```

---

## 6. TeX Live

Unter Linux Mint verwenden wir **TeX Live**.

TeX Live ist eine der am weitesten verbreiteten LaTeX-Distributionen unter Linux.

Die Workshop-Installation enthält eine umfangreiche Auswahl an LaTeX-Paketen, sodass die üblichen Packages bereits verfügbar sein sollten.

---

## 7. Visual Studio Code

Für LaTeX verwenden wir in VS Code die Extension:

**LaTeX Workshop**

Publisher:

```text
James Yu
```

Die Extension kann auch über das Terminal installiert werden:

```bash
code --install-extension James-Yu.latex-workshop
```

---

## 8. TeXStudio

TeXStudio wird zusätzlich installiert und kann über das Anwendungsmenü oder das Terminal gestartet werden:

```bash
texstudio
```

TeXStudio und VS Code können parallel verwendet werden.

---

## 9. Testdokument

Eine Datei namens

```text
test.tex
```

erstellen:

```latex
\documentclass{article}

\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[ngerman]{babel}

\title{Mein erstes LaTeX-Dokument}
\author{SFN LaTeX Workshop}
\date{\today}

\begin{document}

\maketitle

\section{Hallo LaTeX}

Hallo Welt!

Dies ist mein erstes mit \LaTeX{} erzeugtes Dokument.

\[
E = mc^2
\]

\end{document}
```

Danach:

```bash
pdflatex test.tex
```

Es sollte die Datei

```text
test.pdf
```

erzeugt werden.

---

## 10. Kompilieren mit VS Code

`test.tex` in VS Code öffnen.

Mit LaTeX Workshop kann das Dokument typischerweise mit

```text
Ctrl + Alt + B
```

kompiliert werden.

---

## 11. Kompilieren mit TeXStudio

`test.tex` mit TeXStudio öffnen und

```text
Build & View
```

ausführen.

---

## 12. Typische Probleme

### `pdflatex: command not found`

Prüfen, ob TeX Live korrekt installiert wurde.

Danach gegebenenfalls Terminal schließen und neu öffnen.

```bash
pdflatex --version
```

### `code: command not found`

VS Code kann gegebenenfalls trotzdem über das Anwendungsmenü gestartet werden.

### VS Code kompiliert nicht

Zuerst prüfen:

```bash
pdflatex --version
```

Wenn dieser Befehl funktioniert, kontrollieren, ob **LaTeX Workshop** installiert ist.

---

## Zurück zur Hauptseite

[← SFN LaTeX Workshop](../../README.md)


---

