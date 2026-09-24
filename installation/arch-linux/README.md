# LaTeX unter Arch Linux installieren

Diese Anleitung beschreibt die Installation der LaTeX-Arbeitsumgebung unter Arch Linux.

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

Unter KDE Plasma kann das Terminal beispielsweise mit

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
cd sfn-latex-workshop/installation/arch-linux
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

Falls Administratorrechte benötigt werden, fragt `sudo` nach dem Benutzerpasswort.

Arch Linux verwendet für die Paketverwaltung hauptsächlich:

```text
pacman
```

---

## 5. Installation überprüfen

### LaTeX

```bash
pdflatex --version
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

Unter Arch Linux verwenden wir **TeX Live**.

TeX Live stellt die LaTeX-Umgebung sowie eine große Anzahl zusätzlicher Packages bereit.

Die Installation erfolgt über die Arch-Paketverwaltung.

---

## 7. Visual Studio Code

Für LaTeX verwenden wir in VS Code die Extension:

**LaTeX Workshop**

Publisher:

```text
James Yu
```

Falls der `code`-Befehl verfügbar ist:

```bash
code --install-extension James-Yu.latex-workshop
```

---

## 8. TeXStudio

TeXStudio wird zusätzlich installiert.

Start über das Anwendungsmenü oder:

```bash
texstudio
```

VS Code und TeXStudio können unabhängig voneinander verwendet werden.

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

`test.tex` mit TeXStudio öffnen.

Dann:

```text
Build & View
```

ausführen.

---

## 12. Typische Probleme

### `pdflatex: command not found`

Prüfen, ob die TeX-Live-Pakete korrekt installiert wurden:

```bash
pdflatex --version
```

Falls erforderlich, die Installation erneut überprüfen.

### `code: command not found`

Prüfen, welches VS-Code-Paket installiert wurde und ob der ausführbare Befehl `code` heißt.

### VS Code kompiliert nicht

Zuerst:

```bash
pdflatex --version
```

testen.

Wenn LaTeX funktioniert, anschließend prüfen, ob **LaTeX Workshop** installiert ist.

---

## Arch Linux aktualisieren

Bei Arch Linux ist es sinnvoll, das System als Ganzes aktuell zu halten:

```bash
sudo pacman -Syu
```

Partielle System-Upgrades sollten bei Arch Linux vermieden werden.

---

## Zurück zur Hauptseite

[← SFN LaTeX Workshop](../../README.md)