#!/bin/bash

# Homebrew Backup & Restore Tool

BACKUP_FILE="Brewfile"

# Funktion: Backup erstellen
backup_brew() {
    echo "📦 Erstelle Brewfile mit allen installierten Paketen..."
    brew bundle dump --file="$BACKUP_FILE" --force
    echo "✅ Backup gespeichert in: $BACKUP_FILE"
}

# Funktion: Backup wiederherstellen
restore_brew() {
    if [[ ! -f "$BACKUP_FILE" ]]; then
        echo "❌ Fehler: $BACKUP_FILE existiert nicht. Bitte zuerst Backup durchführen."
        exit 1
    fi

    echo "🔄 Installiere Pakete aus $BACKUP_FILE..."
    brew bundle --file="$BACKUP_FILE"
    echo "✅ Wiederherstellung abgeschlossen."
}

# Menü
echo "=== Homebrew Backup & Restore Tool ==="
echo "1) Backup erstellen"
echo "2) Backup wiederherstellen"
read -p "Bitte Auswahl treffen (1/2): " auswahl

case "$auswahl" in
    1) backup_brew ;;
    2) restore_brew ;;
    *) echo "❌ Ungültige Auswahl."; exit 1 ;;
esac

