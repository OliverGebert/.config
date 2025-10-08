#!/bin/bash

# Speicher- und Wiederherstellungsskript für TeX Live Konfiguration

BACKUP_FILE="texlive-packages.txt"

# Funktion: Pakete sichern
backup_packages() {
    echo "📦 Erstelle Sicherungsliste installierter TeX Live Pakete..."
    tlmgr list --only-installed > "$BACKUP_FILE"
    echo "✅ Sicherung abgeschlossen: $BACKUP_FILE enthält alle installierten Pakete."
}

# Funktion: Pakete aus Sicherung wiederherstellen
restore_packages() {
    if [[ ! -f "$BACKUP_FILE" ]]; then
        echo "❌ Fehler: Die Datei '$BACKUP_FILE' wurde nicht gefunden. Bitte führe zuerst ein Backup durch."
        exit 1
    fi

    echo "🔄 Starte Wiederherstellung aus '$BACKUP_FILE'..."
    while read -r line; do
        if [[ "$line" =~ ^i\ ([^ ]+) ]]; then
            pkg="${BASH_REMATCH[1]}"
            echo "➕ Installiere Paket: $pkg"
            tlmgr install "$pkg" >/dev/null || echo "⚠️ Problem bei der Installation von $pkg"
        fi
    done < "$BACKUP_FILE"
    echo "✅ Wiederherstellung abgeschlossen."
}

# Hauptmenü
echo "=== TeX Live Backup & Restore Tool ==="
echo "1) Backup der installierten Pakete erstellen"
echo "2) Pakete aus Backup wiederherstellen"
echo -n "Bitte Auswahl treffen (1/2): "
read auswahl

case "$auswahl" in
    1)
        backup_packages
        ;;
    2)
        restore_packages
        ;;
    *)
        echo "❌ Ungültige Auswahl."
        exit 1
        ;;
esac
