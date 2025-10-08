#!/bin/bash
# fps.sh - Prozesspicker mit fzf und optional kill

if ! command -v fzf >/dev/null 2>&1; then
    echo "Fehler: fzf nicht installiert."
    exit 1
fi

# Interaktive Auswahl (Mehrfachauswahl)
ps -ef | fzf --prompt="Prozess auswählen: " | while read -r line; do
    PID=$(echo "$line" | awk '{print $2}')
    if [[ -z "$PID" ]]; then
        echo "Fehler: PID konnte nicht extrahiert werden."
        continue
    fi

    # PID in Zwischenablage kopieren (nur erste PID)
    if [[ -z "$CLIP_SET" ]]; then
        if command -v pbcopy >/dev/null 2>&1; then
            echo -n "$PID" | pbcopy
            echo "PID $PID in Zwischenablage (macOS)"
        fi
        CLIP_SET=1
    fi

    # Kill-Abfrage
    # Verwende /dev/tty für read, damit es auch aus Pipes funktioniert
    read -r -p "PID $PID killen? (y/N): " answer </dev/tty
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        kill -9 "$PID" && echo "PID $PID beendet" || echo "Fehler beim Beenden von PID $PID"
    else
        echo "PID $PID nicht beendet"
    fi
done

