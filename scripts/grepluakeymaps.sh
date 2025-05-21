#!/bin/bash

# script is used by nvim to provide help on all custom keymappings
rg --no-filename --no-line-number 'keymap.*(<C-|<leader>)' ~/.config/nvim \
  | grep -v '\-\-.*\(<C-\|<leader>\)' \
  | sed 's/^[ \t]*//' \
  | sort
