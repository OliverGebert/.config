#!/bin/bash

# Pip Backup & Restore Tool
BACKUP_FILE="pip-packages.txt"

# Funktion: Backup erstellen
backup_pip() {
    echo "📦 Sichere globale pip-Pakete..."
    pip freeze > "$BACKUP_FILE"
    echo "✅ Backup gespeichert in: $BACKUP_FILE"
}

# Funktion: Wiederherstellen
restore_pip() {
    if [[ ! -f "$BACKUP_FILE" ]]; then
        echo "❌ Fehler: $BACKUP_FILE existiert nicht. Bitte führe zuerst ein Backup durch."
        exit 1
    fi

    echo "🔄 Installiere pip-Pakete aus $BACKUP_FILE..."
    pip install --upgrade --requirement "$BACKUP_FILE"
    echo "✅ Wiederherstellung abgeschlossen."
}

# Menü
echo "=== Pip Backup & Restore Tool ==="
echo "1) Backup erstellen"
echo "2) Wiederherstellen"
read -p "Bitte Auswahl treffen (1/2): " auswahl

case "$auswahl" in
    1) backup_pip ;;
    2) restore_pip ;;
    *) echo "❌ Ungültige Auswahl."; exit 1 ;;
esac

