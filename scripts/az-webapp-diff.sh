#!/usr/bin/env bash
set -euo pipefail

# -----------------------------
# Helper functions
# -----------------------------
error() {
  echo "❌ Error: $1" >&2
  exit 1
}

check_command() {
  command -v "$1" >/dev/null 2>&1 || error "'$1' is required but not installed or not in PATH."
}

# -----------------------------
# Prerequisite checks
# -----------------------------
check_command az
check_command nvim
check_command jq

# -----------------------------
# Load variables from .env
# -----------------------------
ENV_FILE=".env"
if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC2046
  export $(grep -E '^[A-Z0-9_]+=.*' "$ENV_FILE" | xargs)
  echo "ℹ️  Loaded environment variables from $ENV_FILE"
else
  echo "⚠️  No .env file found in $(pwd). Will ask interactively."
fi

# -----------------------------
# Ask user for missing values
# -----------------------------
prompt_if_empty() {
  local var_name="$1"
  local prompt_msg="$2"
  local current_value="${!var_name:-}"
  if [[ -z "$current_value" ]]; then
    read -rp "$prompt_msg: " user_value
    export "$var_name"="$user_value"
  fi
}

prompt_if_empty A_WEBAPP_NAME "Enter web app A name (manual)"
prompt_if_empty A_RESOURCE_GROUP "Enter web app A resource group"

prompt_if_empty B_WEBAPP_NAME "Enter web app B name (Terraform)"
prompt_if_empty B_RESOURCE_GROUP "Enter web app B resource group"

# -----------------------------
# Retrieve configurations
# -----------------------------
A_FILE="A.json"
B_FILE="B.json"

echo "🔍 Fetching configuration for web app A..."
az webapp config show \
  --name "$A_WEBAPP_NAME" \
  --resource-group "$A_RESOURCE_GROUP" \
  --output json >"$A_FILE" \
  || error "Failed to get web app A config."

echo "🔍 Fetching configuration for web app B..."
az webapp config show \
  --name "$B_WEBAPP_NAME" \
  --resource-group "$B_RESOURCE_GROUP" \
  --output json >"$B_FILE" \
  || error "Failed to get web app B config."

# -----------------------------
# Validate output files
# -----------------------------
[[ -s "$A_FILE" ]] || error "$A_FILE is empty."
[[ -s "$B_FILE" ]] || error "$B_FILE is empty."

# Optional: format JSONs consistently
jq . "$A_FILE" >"${A_FILE}.tmp" && mv "${A_FILE}.tmp" "$A_FILE"
jq . "$B_FILE" >"${B_FILE}.tmp" && mv "${B_FILE}.tmp" "$B_FILE"

# -----------------------------
# Diff configurations using Neovim
# -----------------------------
echo "📊 Opening Neovim diff..."
nvim -d "$A_FILE" "$B_FILE"

