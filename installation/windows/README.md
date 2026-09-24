# LaTeX unter Windows installieren

Diese Anleitung beschreibt die Installation der LaTeX-Arbeitsumgebung unter Windows.

Verwendet werden:

- MiKTeX
- Visual Studio Code
- LaTeX Workshop
- TeXStudio
- Git

Das Installationsskript befindet sich im gleichen Verzeichnis:

```text
install-latex.ps1
```

---

## 1. Repository herunterladen

### Mit Git

PowerShell oder die Eingabeaufforderung öffnen:

```powershell
git clone https://github.com/DmitryPodyuk/sfn-latex-workshop.git
```

Danach:

```powershell
cd sfn-latex-workshop\installation\windows
```

### Alternativ als ZIP-Datei

Auf GitHub:

**Code → Download ZIP**

ZIP-Datei entpacken und anschließend in das Verzeichnis

```text
installation\windows
```

wechseln.

---

## 2. PowerShell verwenden

Empfohlen wird **PowerShell**.

PowerShell kann über das Windows-Startmenü geöffnet werden.

Falls Administratorrechte erforderlich sind:

1. Startmenü öffnen
2. `PowerShell` eingeben
3. Rechtsklick auf PowerShell
4. **Als Administrator ausführen**

---

## 3. Installation starten

Falls Windows die Ausführung lokaler PowerShell-Skripte verhindert:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

Diese Einstellung gilt nur für die aktuelle PowerShell-Sitzung.

Danach:

```powershell
.\install-latex.ps1
```

---

## 4. Installation über CMD

Die klassische Windows-Eingabeaufforderung (`cmd.exe`) kann ebenfalls verwendet werden.

Da `install-latex.ps1` ein PowerShell-Skript ist, muss es aus CMD über PowerShell gestartet werden:

```cmd
powershell -ExecutionPolicy Bypass -File install-latex.ps1
```

PowerShell ist für dieses Skript jedoch der empfohlene Weg.

---

## 5. Installation überprüfen

Nach Abschluss der Installation empfiehlt es sich, ein **neues PowerShell-Fenster** zu öffnen.

### LaTeX

```powershell
pdflatex --version
```

### Visual Studio Code

```powershell
code --version
```

### Git

```powershell
git --version
```

Wenn Versionsinformationen ausgegeben werden, wurde das jeweilige Programm gefunden.

---

## 6. LaTeX Workshop überprüfen

VS Code öffnen.

Extensions öffnen:

```text
Ctrl + Shift + X
```

Nach

```text
LaTeX Workshop
```

suchen.

Publisher:

```text
James Yu
```

Alternativ kann die Extension über die Kommandozeile installiert werden:

```powershell
code --install-extension James-Yu.latex-workshop
```

---

## 7. MiKTeX

Unter Windows verwenden wir **MiKTeX**.

Ein Vorteil von MiKTeX besteht darin, dass fehlende LaTeX-Pakete bei Bedarf automatisch nachinstalliert werden können.

Wenn MiKTeX beim Kompilieren fragt, ob ein fehlendes Package installiert werden soll, kann die Installation bestätigt werden.

---

## 8. TeXStudio

TeXStudio wird zusätzlich zu VS Code installiert.

Es kann über das Windows-Startmenü gestartet werden.

TeXStudio ist insbesondere für Anfänger praktisch, da viele LaTeX-Funktionen direkt integriert sind.

VS Code und TeXStudio können parallel verwendet werden.

---

## 9. Testdokument

Eine Datei namens

```text
test.tex
```

anlegen:

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

```powershell
pdflatex test.tex
```

Es sollte eine Datei

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

Anschließend:

```text
Build & View
```

ausführen.

---

## 12. Typische Probleme

### `pdflatex` wird nicht gefunden

PowerShell schließen und neu öffnen.

Dann:

```powershell
pdflatex --version
```

erneut ausführen.

### `code` wird nicht gefunden

VS Code kann trotzdem über das Startmenü gestartet werden.

### VS Code kompiliert nicht

Zuerst prüfen:

```powershell
pdflatex --version
```

Falls dieser Befehl funktioniert, anschließend kontrollieren, ob **LaTeX Workshop** installiert ist.

---

## Zurück zur Hauptseite

[← SFN LaTeX Workshop](../../README.md)


---
