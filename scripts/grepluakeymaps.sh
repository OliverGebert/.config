#!/bin/bash

rg --no-filename --no-line-number '<C-|<leader>' ~/.config/nvim \
  | grep -v '\-\-.*\(<C-\|<leader>\)' \
  | sed 's/^[ \t]*//' \
  | sort
