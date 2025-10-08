#!/bin/bash
# convert_and_merge.sh
# Konvertiert alle SVG-Dateien in PDF (mit rsvg-convert)
# und fügt sie anschließend mit pdfunite zu einer einzelnen PDF-Datei zusammen.

set -euo pipefail

# --- Parameter ---
OUTPUT_FILE="output.pdf"

# --- Prüfen, ob benötigte Tools vorhanden sind ---
command -v rsvg-convert >/dev/null 2>&1 || {
  echo "Fehler: rsvg-convert nicht gefunden. Bitte installiere es mit 'brew install librsvg'." >&2
  exit 1
}

command -v pdfunite >/dev/null 2>&1 || {
  echo "Fehler: pdfunite nicht gefunden. Bitte installiere es mit 'brew install poppler'." >&2
  exit 1
}

# --- SVG → PDF konvertieren ---
echo "Konvertiere SVG-Dateien in PDF ..."
for f in *.svg; do
  if [[ -f "$f" ]]; then
    out="${f%.svg}.pdf"
    echo "  $f → $out"
    if ! rsvg-convert -f pdf -o "$out" "$f"; then
      echo "Fehler beim Konvertieren von $f" >&2
      exit 1
    fi
  fi
done
