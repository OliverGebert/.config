#!/bin/bash

# ---------------------------------------------------------
# tmuxp-session-starter.sh
#
# Purpose:
# Detects if an external monitor is connected
# and loads the appropriate tmuxp session:
# - ltms.yml -> large screen (external monitor)
# - stms.yml -> small screen (internal display)
# If the corresponding file does not exist, fallback to ~/.config/scripts/tms.yml.
# Also checks if a tmux session is already running.
#
# Requirements:
# - tmux and tmuxp installed
# - system_profiler (macOS built-in)
# ---------------------------------------------------------

# Configuration
TMUXP_CONFIG_DIR="$(pwd)"                    # Path to tmuxp config files (current directory)
TMUXP_GLOBAL_FALLBACK=~/.config/scripts/tms.yml  # Global fallback session file

# Function: Check if an external monitor is connected
check_external_monitor() {
  system_profiler SPDisplaysDataType | grep "Connection Type:" | grep -v -q "Connection Type: Internal"
 # system_profiler SPDisplaysDataType | grep -q "Display Type: External"
  return $?  # Return 0 if found, 1 if not
}

# Function: Load a tmuxp session with fallback
load_tmuxp_session() {
  local session_file="$1"
  if [ -f "$TMUXP_CONFIG_DIR/$session_file" ]; then
    echo "[INFO] Loading tmuxp session: $session_file"
    tmuxp load "$TMUXP_CONFIG_DIR/$session_file"
  else
    echo "[WARNING] $session_file not found. Falling back to global tms.yml..."
    tmuxp load "$TMUXP_GLOBAL_FALLBACK"
  fi
}

# Function: Check if a tmux session is already running
check_tmux_running() {
  if tmux info &> /dev/null; then
    return 0  # tmux is running
  else
    return 1  # tmux is not running
  fi
}

# Main logic
if check_tmux_running; then
  echo "[INFO] tmux is already running. No new session will be started."
  exit 0
fi

if check_external_monitor; then
  echo "[INFO] External monitor detected."
  load_tmuxp_session "ltms.yml"
else
  echo "[INFO] No external monitor detected."
  load_tmuxp_session "stms.yml"
fi
