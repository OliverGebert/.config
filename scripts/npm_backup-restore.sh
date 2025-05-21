#!/bin/bash

# NPM Backup & Restore Tool

BACKUP_FILE="npm-global-packages.txt"

# Funktion: Backup erstellen
backup_npm() {
    echo "📦 Sichere global installierte npm-Pakete..."
    npm ls -g --depth=0 --parseable | tail -n +2 | xargs -n1 basename > "$BACKUP_FILE"
    echo "✅ Backup gespeichert in: $BACKUP_FILE"
}

# Funktion: Wiederherstellen
restore_npm() {
    if [[ ! -f "$BACKUP_FILE" ]]; then
        echo "❌ Fehler: $BACKUP_FILE nicht gefunden. Bitte führe zuerst ein Backup durch."
        exit 1
    fi

    echo "🔄 Installiere Pakete aus $BACKUP_FILE..."
    while read -r pkg; do
        echo "➕ Installiere $pkg ..."
        npm install -g "$pkg" || echo "⚠️ Problem bei $pkg"
    done < "$BACKUP_FILE"

    echo "✅ Wiederherstellung abgeschlossen."
}

# Menü
echo "=== NPM Global Backup & Restore Tool ==="
echo "1) Backup erstellen"
echo "2) Wiederherstellen"
read -p "Bitte Auswahl treffen (1/2): " auswahl

case "$auswahl" in
    1) backup_npm ;;
    2) restore_npm ;;
    *) echo "❌ Ungültige Auswahl."; exit 1 ;;
esac

