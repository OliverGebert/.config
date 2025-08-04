#!/bin/zsh

# Script: show_aliases.zsh
# Description:
#   Parses alias definitions from ~/.zshrc
#   Prints alias name, command, and comment with colors

ZSHRC="${HOME}/.zshrc"

if [[ ! -f "$ZSHRC" ]]; then
  echo "❌ .zshrc not found: $ZSHRC"
  exit 1
fi

CYAN='\033[36m'
GREEN='\033[32m'
GRAY='\033[2m'
RESET='\033[0m'

echo "${CYAN}>>> Aliases from $ZSHRC${RESET}"
echo

grep -E '^alias ' "$ZSHRC" | while IFS= read -r line; do

  # Extract comment (everything after first #, if present)
  if [[ "$line" == *"#"* ]]; then
    comment="${line#*#}"
    comment="${comment#"${comment%%[![:space:]]*}"}"  # trim leading spaces
  else
    comment=""
  fi

  # Remove comment part for parsing name and command
  line_no_comment="${line%%#*}"

  # Extract name: remove 'alias ', then cut at '=' and trim whitespace
  name="${line_no_comment%%=*}"     # everything left of '='
  name="${name#alias }"             # remove 'alias ' prefix
  name="${name// /}"                # remove spaces (e.g. 'alias  ls =')

  # Extract command: everything right of '='
  command="${line_no_comment#*=}"

  # Remove surrounding quotes (single or double)
  command="${command%\"}"
  command="${command#\"}"
  command="${command%\'}"
  command="${command#\'}"

  printf "${CYAN}%-15s${RESET} → ${GREEN}%-40s${RESET} → ${GRAY}%s${RESET}\n" "$name" "$command" "$comment"
done

