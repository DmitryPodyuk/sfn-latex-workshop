# SFN LaTeX-Rezeptbuch – Forschungsarbeiten

Ein didaktisch gestaffeltes Nachschlagewerk für vier Termine à 120 Minuten.
Die Materialien wurden für das lokale LaTeX-Setup auf Windows/Linux und VS Code
entworfen. Es werden keine Shell-Escape-Funktionen benötigt.

## Start

1. **Den gesamten Ordner** `sfn-latex-rezeptbuch/` in VS Code öffnen.
2. `rezeptbuch.tex` öffnen und mit LaTeX Workshop kompilieren.
3. Die separat kompilierbaren Beispiele in `rezepte/` ausprobieren.
4. Für ein fertiges Forschungsdokument `beispiel-forschungsarbeit.tex` öffnen.

Alle unten gezeigten Terminalbefehle setzen voraus, dass man sich im
**Hauptordner** (`sfn-latex-rezeptbuch/`) befindet. Bei Aufrufen aus
anderen Ordnern können die relativen Pfade zu Bildern/Daten fehlen.

## Bauen

Das Rezeptbuch ohne Literaturverzeichnis:

```bash
latexmk -pdf rezeptbuch.tex
```

Ein unabhängiges Rezept:

```bash
latexmk -pdf rezepte/04_abbildung.tex
```

Beispiel mit Quellen (Biber muss installiert sein):

```bash
latexmk -pdf rezepte/09_quellen.tex
latexmk -pdf beispiel-forschungsarbeit.tex
```

Falls `latexmk` im Setup nicht funktioniert, etwa am Beispiel `09_quellen`:

```bash
pdflatex rezepte/09_quellen.tex
biber 09_quellen
pdflatex rezepte/09_quellen.tex
pdflatex rezepte/09_quellen.tex
```

Wichtig: Bei der Arbeit an einem Rezept mit Bild-, CSV- oder Bib-Datei
muss die Projektstruktur erhalten bleiben. Einige Editor-Konfigurationen
starten den Compiler aus dem Rezept-Unterordner; in diesem Fall den
Terminal-Aufruf aus dem Hauptordner verwenden.

## Was gehört wohin?

- `rezeptbuch.tex`: Lehr- und Rezeptbuch, das die MWEs aus den Einzeldateien
  einliest und als Quelltext im PDF abbildet.
- `rezepte/*.tex`: vollständige Mini-Dokumente mit einer klaren Technik.
- `beispiel-forschungsarbeit.tex`: integriertes Musterprojekt von Titelseite
  bis Literaturverzeichnis und Anhang.
- `literatur.bib`: öffentliche Fachliteratur als Beispieldatensätze.
- `bilder/messaufbau.png`: eigens erzeugte Kursgrafik; kann frei in Übungen
  genutzt und verändert werden.
- `daten/messwerte.csv`: synthetische, **nicht experimentell erhobene** Daten.
- `kapitel/anhang_messprotokoll.tex`: separat eingebundenes Kapitel.

## Didaktische Schwerpunkte

- **Termin 1:** Struktur, Titel, Abstract, Text und Listen.
- **Termin 2:** Bild, Tabelle, Beschriftung und Querverweis.
- **Termin 3:** Formeln, SI-Einheiten, Programmcode; Diagramme optional.
- **Termin 4:** Quellen/Biber, Anhang, Integration und Qualitätskontrolle.

Minimalanforderungen sind im Rezeptbuch als **P0** markiert, sinnvolle
Ergänzungen als **P1**, freiwillige Vertiefungen als **P2**.

## Technische Hinweise

- UTF-8-kodierte TeX-Dateien, `pdflatex` und `biber` (für Rezepte mit
  Literaturverzeichnis).
- Die Beispiele nutzen `siunitx` Version 3 (`\qty`, `\num`).
- Wenn ein Paket in MiKTeX fehlt: Paketinstallation zulassen und erneut
  kompilieren; bei TeX Live entsprechende Sammlung installieren.
- Paketdetails: https://ctan.org/.
- Die Beispieldaten sind didaktisch erfunden, damit keine falsche
  Forschungsleistung suggeriert wird.
