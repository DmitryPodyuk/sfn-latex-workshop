# SFN LaTeX Workshop

Dieses Repository enthält Materialien und Installationsskripte für den **SFN LaTeX Workshop**.

Unterstützt werden aktuell:

| Betriebssystem | LaTeX-Distribution | VS Code | TeXStudio |
|---|---|---:|---:|
| Windows 11 | MiKTeX | ✅ | ✅ |
| Linux Mint | TeX Live | ✅ | ✅ |
| Arch Linux | TeX Live | ✅ | ✅ |

## Installation

Bitte die Anleitung für das verwendete Betriebssystem auswählen:

### Windows

[Installation unter Windows](installation/windows/README.md)

Verwendet werden:

- MiKTeX
- Visual Studio Code
- LaTeX Workshop
- TeXStudio
- Git

---

### Linux Mint

[Installation unter Linux Mint](installation/linux-mint/README.md)

Verwendet werden:

- TeX Live
- Visual Studio Code
- LaTeX Workshop
- TeXStudio
- Git

---

### Arch Linux

[Installation unter Arch Linux](installation/arch-linux/README.md)

Verwendet werden:

- TeX Live
- Visual Studio Code
- LaTeX Workshop
- TeXStudio
- Git

---

## Repository klonen

Das komplette Repository kann mit Git heruntergeladen werden:

```bash
git clone https://github.com/DmitryPodyuk/sfn-latex-workshop.git
```

Danach:

```bash
cd sfn-latex-workshop
```

Alternativ kann das Repository auf GitHub über

**Code → Download ZIP**

als ZIP-Datei heruntergeladen werden.

---

## Repository-Struktur

```text
sfn-latex-workshop/
│
├── README.md
│
├── installation/
│   ├── windows/
│   │   ├── README.md
│   │   └── install-latex.ps1
│   │
│   ├── linux-mint/
│   │   ├── README.md
│   │   └── install-latex.sh
│   │
│   └── arch-linux/
│       ├── README.md
│       └── install-latex.sh
│
├── examples/
│
└── presentations/
```

---

## Editoren

Im Workshop werden zwei Editoren unterstützt.

### Visual Studio Code

VS Code ist ein allgemeiner moderner Editor. Für LaTeX verwenden wir die Extension:

**LaTeX Workshop**  
Publisher: **James Yu**

Vorteile:

- Git-Integration
- Erweiterungen
- Unterstützung für viele Programmiersprachen
- gute Projektverwaltung
- integrierte PDF-Vorschau

### TeXStudio

TeXStudio wurde speziell für LaTeX entwickelt.

Vorteile:

- einfacher Einstieg
- wenig Konfiguration
- LaTeX-Funktionen direkt integriert
- integrierte PDF-Vorschau

Beide Editoren können parallel installiert werden.

Die erzeugten `.tex`-Dateien sind unabhängig vom verwendeten Editor.

---

## Erster LaTeX-Test

Nach erfolgreicher Installation kann folgende Datei als `test.tex` gespeichert werden:

```latex
\documentclass{article}

\begin{document}

Hello, LaTeX!

\[
E = mc^2
\]

\end{document}
```

Anschließend im Terminal bzw. in PowerShell:

```bash
pdflatex test.tex
```

Wenn danach die Datei

```text
test.pdf
```

erzeugt wurde, funktioniert die grundlegende LaTeX-Installation.

---

## Workshop-Inhalte

Im weiteren Verlauf des Workshops beschäftigen wir uns unter anderem mit:

- Aufbau eines LaTeX-Dokuments
- Dokumentklassen
- Packages
- mathematischen Formeln
- physikalischen Formeln
- Tabellen
- Abbildungen
- Literaturverwaltung
- BibLaTeX und Biber
- Forschungstagebuch und Laborbuch
- wissenschaftlichen Arbeiten
- SFN-Templates
- Besonderer Lernleistung (BLL)
- Präsentationen mit LaTeX Beamer
- Git und GitHub für LaTeX-Projekte

---

## Ziel

Die Installation ist nur der erste Schritt.

Ziel des Workshops ist es, LaTeX als Werkzeug für wissenschaftliches Arbeiten kennenzulernen:

> Vom ersten `.tex`-Dokument bis zur professionell gesetzten wissenschaftlichen Arbeit.


---