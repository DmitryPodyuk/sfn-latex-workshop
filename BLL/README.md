# SFN – LaTeX-Vorlage für eine Besondere Lernleistung (BLL)

**Anwendungsbereich:** wissenschaftliche Ausarbeitung einer besonderen
Lernleistung im Rahmen des hessischen Abiturs. Die Vorlage orientiert
sich an wissenschaftlichen Arbeiten, ist aber **keine amtliche
Mustervorlage**. **Schulische Vorgaben haben Vorrang.**

## Erste Schritte (VS Code + LaTeX Workshop)

1. Den gesamten Ordner `SFN_BLL_Vorlage` in VS Code öffnen.
2. `angaben.tex` bearbeiten: Thema, Name, Schule, Jahrgangsstufe,
   Referenzfach, schulische Lehrkraft, optionale SFN-Betreuung und Datum.
3. Falls vorhanden und zur Verwendung freigegeben: Logos als
   `logos/schule.pdf` bzw. `.png` und `logos/sfn.pdf` bzw. `.png`
   hinzufügen. **Keine Logos nötig**, das Dokument baut auch ohne sie.
4. In `kapitel/` die Beispiele nach und nach durch die eigene Arbeit
   ersetzen. Die Demonstrationswerte dürfen keinesfalls als reale
   Messergebnisse ausgegeben werden.
5. `bll.tex` mit dem **pdfLaTeX + Biber**-Workflow kompilieren.
6. Von der betreuenden Lehrkraft freigeben lassen: Titelseite,
   formale Kriterien und Erklärung zur Eigenständigkeit.

## Kompilieren

Im Projekt-Hauptordner (Windows PowerShell oder Linux-Terminal):

```bash
latexmk -pdf -interaction=nonstopmode -halt-on-error bll.tex
```

Alternativ manuell:

```bash
pdflatex bll.tex
biber bll
pdflatex bll.tex
pdflatex bll.tex
```

In LaTeX Workshop: Recipe mit pdfLaTeX und Biber verwenden. Kein
`-shell-escape` notwendig. Verwendet werden übliche TeX-Live/MiKTeX-
Pakete, darunter `scrreprt`, `babel`, `microtype`, `setspace`, `geometry`,
`graphicx`, `amsmath`, `siunitx`, `booktabs`, `tabularx`, `csquotes`,
`biblatex`, `biber`, `hyperref`, `listings` und `scrlayer-scrpage`.

## Projektstruktur

- `bll.tex` – Hauptdatei, bestimmt die Reihenfolge der Bestandteile.
- `angaben.tex` – alle persönlichen und schulischen Angaben.
- `gestaltung.tex` – Satzspiegel, Schrift, Seitenzahlen, Querverweise.
- `titelseite.tex` – wissenschaftlich gestaltete Titelseite.
- `kapitel/*.tex` – Kurzfassung, Einleitung, Theorie, Methoden,
  Ergebnisse, Diskussion, Fazit.
- `literatur.bib` – Literaturdatenbank für Biber.
- `abbildungen/` – eigenständige Vektorbeispiele, eigene Grafiken.
- `anhang/` – Arbeitsprotokoll sowie optional Programmcode.
- `selbststaendigkeit.tex` – **nur Formulierungsvorschlag**.

## Vor der Abgabe verbindlich mit der Schule klären

- zugelassene BLL und konkretes Referenzfach, Umfang und Abgabetermin;
- Seitenränder, Zeilenabstand, Schriftgröße, Zitierstil, Aussehen des
  Deckblatts, Inhalts-/Abbildungs-/Tabellenverzeichnisse;
- Wortlaut, Unterschrift und Platzierung der Eigenständigkeitserklärung;
- Umgang mit KI-Werkzeugen und Dokumentation externer Beiträge;
- Anforderungen an den Anhang, Versuchsnachweise und ggf. Datei-Abgabe;
- Nutzungsrechte für Schul- und SFN-Logo.

Eine BLL ist keine universitäre Diplomarbeit: Vorbild ist die
**wissenschaftliche Methode**, nicht ein übertrieben umfangreiches
Vorspann- oder Formalienpaket. Im Zweifel lieber klar und knapp.

In der hessischen Qualifikationsphase ist `Q3/Q4` meist aussagekräftiger
als eine Klassenbezeichnung; beides ist in `angaben.tex` anpassbar.
SFN-Begleitende können fachlich unterstützen. Die schulische Betreuung,
Zulassung und Bewertung folgen dagegen den schulrechtlichen Vorgaben.

## Wichtige Quellen zur Einordnung (Stand: Oktober 2026)

- OAVO Hessen, insbesondere § 22 Abs. 3 und § 37 Abs. 4–6:
  https://www.rv.hessenrecht.hessen.de/bshe/
- Hessisches Kultusministerium – Landesabitur:
  https://kultus.hessen.de/schulsystem/schulformen-und-bildungsgaenge/gymnasium/landesabitur
- Physikalisches Beispielmodell (OpenStax):
  https://openstax.org/books/university-physics-volume-1/pages/15-4-pendulums

Die in der Musteransicht verwendeten Werte sind **ausschließlich
berechnet**. Weder wissenschaftliche Originalforschung noch eine
fertige BLL werden durch die Vorlage vorgetäuscht.
