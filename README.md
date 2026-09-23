# SFN LaTeX Workshop – Installation

Dieses Repository enthält Installationsskripte für die LaTeX-Umgebung des SFN-LaTeX-Workshops.

Unterstützt werden:

* Windows
* Linux Mint
* Arch Linux

Ziel ist eine möglichst einheitliche Arbeitsumgebung mit:

* LaTeX-Distribution
* Visual Studio Code
* LaTeX Workshop Extension für VS Code
* TeXStudio
* Git
* den für den Workshop benötigten LaTeX-Werkzeugen

---

# 1. Übersicht

| Betriebssystem | LaTeX-Distribution | VS Code | TeXStudio |
| -------------- | ------------------ | ------: | --------: |
| Windows        | MiKTeX             |       ✅ |         ✅ |
| Linux Mint     | TeX Live           |       ✅ |         ✅ |
| Arch Linux     | TeX Live           |       ✅ |         ✅ |

Für Windows wird **MiKTeX** verwendet.

Für Linux Mint und Arch Linux wird **TeX Live** verwendet.

Beide LaTeX-Distributionen können `.tex`-Dateien kompilieren und PDFs erzeugen. Die unterschiedlichen Distributionen wurden gewählt, weil sie sich gut in die jeweiligen Betriebssysteme integrieren lassen.

---

# 2. Repository-Struktur

```text
sfn-latex-workshop/
│
├── README.md
│
├── installation/
│   │
│   ├── windows/
│   │   └── install-latex.ps1
│   │
│   ├── linux-mint/
│   │   └── install-latex.sh
│   │
│   └── arch-linux/
│       └── install-latex.sh
│
├── examples/
│   ├── hello-world.tex
│   └── math-example.tex
│
└── presentations/
    ├── session-01/
    └── session-02/
```

---

# 3. Repository herunterladen

Es gibt zwei Möglichkeiten.

## Variante A – mit Git

Terminal bzw. PowerShell öffnen:

```bash
git clone https://github.com/DmitryPodyuk/sfn-latex-workshop.git
```

Danach:

```bash
cd sfn-latex-workshop
```
---

## Variante B – ZIP-Datei herunterladen

Auf GitHub:

**Code → Download ZIP**

Danach die ZIP-Datei entpacken.

Für Workshop-Teilnehmer ohne Git-Erfahrung ist dies zunächst vollkommen ausreichend.

---

# 4. Windows

## 4.1 Installierte Komponenten

Das Windows-Skript richtet die LaTeX-Arbeitsumgebung ein.

Verwendet werden:

* MiKTeX
* Visual Studio Code
* LaTeX Workshop für VS Code
* TeXStudio
* Git
* gegebenenfalls zusätzliche Hilfsprogramme, die für LaTeX benötigt werden

MiKTeX besitzt insbesondere unter Windows den Vorteil, fehlende LaTeX-Pakete bei Bedarf automatisch installieren zu können.

---

## 4.2 PowerShell starten

PowerShell als Administrator öffnen.

Dazu:

1. Startmenü öffnen
2. `PowerShell` eingeben
3. Rechtsklick auf PowerShell
4. **Als Administrator ausführen**

---

## 4.3 Zum Repository wechseln

Beispiel:

```powershell
cd "$HOME\Downloads\sfn-latex-workshop"
```

Anschließend:

```powershell
cd installation\windows
```

---

## 4.4 PowerShell-Skript erlauben

Falls Windows die Ausführung lokaler PowerShell-Skripte verhindert:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

Diese Einstellung gilt nur für die aktuelle PowerShell-Sitzung.

---

## 4.5 Installation starten

```powershell
.\install-latex.ps1
```

Das Skript führt die vorgesehenen Installations- und Konfigurationsschritte automatisch aus.

Je nach bereits vorhandener Software werden möglicherweise einzelne Schritte übersprungen.

---

# 5. Windows-Installation überprüfen

Nach Abschluss der Installation eine **neue PowerShell** öffnen.

MiKTeX bzw. LaTeX prüfen:

```powershell
pdflatex --version
```

VS Code prüfen:

```powershell
code --version
```

Git prüfen:

```powershell
git --version
```

Wenn die entsprechenden Versionsinformationen angezeigt werden, wurde das jeweilige Programm korrekt gefunden.

---

# 6. Linux Mint

Für Linux Mint verwenden wir **TeX Live**.

TeX Live ist die unter Linux am weitesten verbreitete LaTeX-Distribution und lässt sich direkt über die Paketverwaltung installieren.

---

## 6.1 Terminal öffnen

Zum Beispiel mit:

```text
Ctrl + Alt + T
```

---

## 6.2 Repository herunterladen

Falls Git bereits vorhanden ist:

```bash
git clone https://github.com/DmitryPodyuk/sfn-latex-workshop.git
```

Danach:

```bash
cd sfn-latex-workshop/installation/linux-mint
```

Falls das Repository als ZIP-Datei heruntergeladen wurde, entsprechend in das entpackte Verzeichnis wechseln.

---

## 6.3 Skript ausführbar machen

```bash
chmod +x install-latex.sh
```

---

## 6.4 Installation starten

```bash
./install-latex.sh
```

Falls das Skript für einzelne Installationsschritte Administratorrechte benötigt, fragt Linux nach dem Benutzerpasswort.

---

# 7. Linux-Mint-Installation überprüfen

Nach Abschluss der Installation:

```bash
pdflatex --version
```

TeX Live Package Manager:

```bash
tlmgr --version
```

VS Code:

```bash
code --version
```

Git:

```bash
git --version
```

TeXStudio kann entweder über das Anwendungsmenü gestartet werden oder – abhängig von der Installation – über:

```bash
texstudio
```

---

# 8. Arch Linux

Auch unter Arch Linux verwenden wir **TeX Live**.

Die Installation unterscheidet sich von Linux Mint, da Arch die Paketverwaltung `pacman` verwendet.

---

## 8.1 Terminal öffnen

Unter KDE Plasma beispielsweise:

```text
Ctrl + Alt + T
```

---

## 8.2 Repository herunterladen

```bash
git clone https://github.com/DmitryPodyuk/sfn-latex-workshop.git
```

Danach:

```bash
cd sfn-latex-workshop/installation/arch-linux
```

---

## 8.3 Skript ausführbar machen

```bash
chmod +x install-latex.sh
```

---

## 8.4 Installation starten

```bash
./install-latex.sh
```

Falls Administratorrechte benötigt werden, fragt `sudo` nach dem Benutzerpasswort.

---

# 9. Arch-Installation überprüfen

LaTeX:

```bash
pdflatex --version
```

VS Code:

```bash
code --version
```

Git:

```bash
git --version
```

TeXStudio:

```bash
texstudio
```

---

# 10. Visual Studio Code

Für alle drei Systeme verwenden wir **Visual Studio Code** als eine mögliche Entwicklungsumgebung für LaTeX.

Für VS Code benötigen wir insbesondere die Extension:

**LaTeX Workshop** vom James Yu

---

## 10.1 Installation kontrollieren

VS Code öffnen.

Danach:

```text
Extensions
```

oder:

```text
Ctrl + Shift + X
```

Nach

```text
LaTeX Workshop
```

suchen.

Falls die Extension noch nicht installiert ist:

**Install** auswählen.

---

## 10.2 Installation über die Kommandozeile

Falls der `code`-Befehl verfügbar ist:

```bash
code --install-extension James-Yu.latex-workshop
```

Dieser Befehl funktioniert grundsätzlich auf Windows und Linux.

---

# 11. TeXStudio

Neben VS Code installieren wir **TeXStudio**.

TeXStudio ist eine speziell für LaTeX entwickelte Entwicklungsumgebung.

Für Anfänger kann TeXStudio einfacher sein, während VS Code langfristig mehr Erweiterungsmöglichkeiten bietet.

Beide Programme können parallel installiert werden.

Ihr könnt selbst entscheiden, welchen Editor ihr bevorzugt.

---

# 12. Erster LaTeX-Test

Nach erfolgreicher Installation legen wir eine Datei namens

```text
hello.tex
```

an.

Inhalt:

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

\end{document}
```

---

# 13. Dokument im Terminal kompilieren

In das Verzeichnis mit `hello.tex` wechseln.

Dann:

```bash
pdflatex hello.tex
```

Auch unter Windows kann derselbe Befehl in PowerShell verwendet werden:

```powershell
pdflatex hello.tex
```

Danach sollte die Datei

```text
hello.pdf
```

erzeugt worden sein.

---

# 14. Kompilieren mit VS Code

`hello.tex` in VS Code öffnen.

LaTeX Workshop erkennt normalerweise automatisch, dass es sich um ein LaTeX-Dokument handelt.

Anschließend kann das Dokument kompiliert werden.

Typischer Tastaturbefehl:

```text
Ctrl + Alt + B
```

Das erzeugte PDF kann anschließend direkt in VS Code angezeigt werden.

---

# 15. Kompilieren mit TeXStudio

`hello.tex` mit TeXStudio öffnen.

Anschließend:

```text
Build & View
```

ausführen.

Standardmäßig kann hierfür häufig die Taste

```text
F5
```

verwendet werden.

---

# 16. Welchen Editor soll ich benutzen?

Für den Workshop werden zwei Varianten unterstützt.

## Visual Studio Code

Vorteile:

* moderner Editor
* sehr viele Erweiterungen
* Git-Integration
* geeignet für viele Programmiersprachen
* gute Projektverwaltung
* LaTeX Workshop bietet umfangreiche LaTeX-Unterstützung

## TeXStudio

Vorteile:

* speziell für LaTeX entwickelt
* einfacher Einstieg
* viele LaTeX-Funktionen direkt integriert
* wenig zusätzliche Konfiguration erforderlich

### Empfehlung

Wer hauptsächlich LaTeX schreiben möchte und einen möglichst einfachen Einstieg sucht, kann zunächst **TeXStudio** verwenden.

Wer VS Code bereits kennt oder später auch Git, Python und andere Werkzeuge verwenden möchte, kann **VS Code + LaTeX Workshop** verwenden.

Die erzeugten `.tex`-Dateien sind unabhängig vom verwendeten Editor.

---

# 17. MiKTeX und TeX Live

Im Workshop kommen zwei unterschiedliche LaTeX-Distributionen zum Einsatz.

## Windows

```text
MiKTeX
```

## Linux Mint und Arch Linux

```text
TeX Live
```

Für unsere LaTeX-Dokumente spielt dieser Unterschied normalerweise keine Rolle.

Ein Dokument wie

```latex
\documentclass{article}
```

kann mit beiden Distributionen kompiliert werden.

---

# 18. Fehlende LaTeX-Pakete

LaTeX-Funktionen werden häufig über sogenannte Packages eingebunden.

Beispiel:

```latex
\usepackage{amsmath}
```

oder:

```latex
\usepackage{graphicx}
```

---

## Windows / MiKTeX

MiKTeX kann fehlende Pakete normalerweise automatisch erkennen und nachinstallieren.

Falls MiKTeX fragt, ob ein fehlendes Package installiert werden soll, kann die Installation bestätigt werden.

---

## Linux / TeX Live

Bei den Workshop-Installationen wird eine umfangreiche TeX-Live-Installation verwendet, sodass die üblichen Packages bereits vorhanden sein sollten.

---

# 19. Installation testen

Nach der Installation sollten mindestens die folgenden Befehle funktionieren.

## Windows

```powershell
pdflatex --version
code --version
git --version
```

## Linux Mint

```bash
pdflatex --version
code --version
git --version
```

## Arch Linux

```bash
pdflatex --version
code --version
git --version
```

---

# 20. Typische Probleme

## `pdflatex: command not found`

LaTeX wurde entweder nicht vollständig installiert oder ist noch nicht im `PATH`.

Terminal beziehungsweise PowerShell schließen und neu öffnen.

Danach erneut testen:

```bash
pdflatex --version
```

---

## `code: command not found`

VS Code ist installiert, aber der Kommandozeilenbefehl wurde möglicherweise noch nicht eingerichtet.

VS Code kann trotzdem über das Anwendungsmenü gestartet werden.

---

## VS Code kompiliert das Dokument nicht

Zunächst prüfen:

```bash
pdflatex --version
```

Wenn dieser Befehl nicht funktioniert, liegt das Problem nicht bei VS Code, sondern bei der LaTeX-Installation.

Wenn `pdflatex` funktioniert, anschließend kontrollieren, ob die Extension **LaTeX Workshop** installiert ist.

---

## TeXStudio startet, aber LaTeX funktioniert nicht

Im Terminal prüfen:

```bash
pdflatex --version
```

Wenn dieser Befehl funktioniert, kann TeXStudio normalerweise ebenfalls auf die LaTeX-Distribution zugreifen.

---

# 21. Installation aktualisieren

Die Installationsskripte können während des Workshops aktualisiert werden.

Wenn das Repository mit Git heruntergeladen wurde:

```bash
git pull
```

Dadurch wird die lokale Version mit der aktuellen Version auf GitHub synchronisiert.

---

# 22. Wichtiger Hinweis

Die Installationsskripte verändern Softwarepakete auf dem jeweiligen Rechner.

Vor der Ausführung sollte der Inhalt eines Skripts grundsätzlich gelesen werden.

Die Skripte sind für die im SFN-LaTeX-Workshop getesteten Systeme vorgesehen.

Abweichende Linux-Distributionen oder ältere Windows-Versionen können zusätzliche Anpassungen erfordern.

---

# 23. Unterstützte und getestete Konfigurationen

| System                  | LaTeX    | Editor              | Status |
| ----------------------- | -------- | ------------------- | ------ |
| Windows 11              | MiKTeX   | VS Code / TeXStudio | ✅      |
| Linux Mint              | TeX Live | VS Code / TeXStudio | ✅      |
| Arch Linux + KDE Plasma | TeX Live | VS Code / TeXStudio | ✅      |

---

# 24. Workshop-Ziel

Die Installation ist nur der erste Schritt.

Im weiteren Verlauf des Workshops beschäftigen wir uns unter anderem mit:

* Aufbau eines LaTeX-Dokuments
* Dokumentklassen
* Packages
* mathematischen Formeln
* physikalischen Formeln
* Tabellen
* Abbildungen
* Literaturverwaltung
* BibLaTeX / Biber
* Forschungstagebuch und Laborbuch
* wissenschaftlichen Arbeiten
* SFN-Templates
* Besonderer Lernleistung (BLL)
* Präsentationen mit LaTeX Beamer
* Git und GitHub für LaTeX-Projekte

---

# 25. Minimaler Systemtest

Wenn ihr überprüfen möchtet, ob eure Installation grundsätzlich funktioniert, reichen drei Schritte.

### 1. LaTeX prüfen

```bash
pdflatex --version
```

### 2. Testdatei erzeugen

```latex
\documentclass{article}

\begin{document}

Hello, LaTeX!

\[
E = mc^2
\]

\end{document}
```

Als

```text
test.tex
```

speichern.

### 3. Kompilieren

```bash
pdflatex test.tex
```

Wenn anschließend

```text
test.pdf
```

existiert, funktioniert die grundlegende LaTeX-Installation.

---

# SFN LaTeX Workshop

Ziel des Workshops ist nicht nur, LaTeX zu installieren, sondern LaTeX als Werkzeug für wissenschaftliches Arbeiten kennenzulernen.

Nach erfolgreicher Installation können wir uns daher auf das Wesentliche konzentrieren:

> Vom ersten `.tex`-Dokument bis zur professionell gesetzten wissenschaftlichen Arbeit.
