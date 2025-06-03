#!/bin/bash

# Script is used by Neovim to provide help on all custom keymappings

# Search recursively for lines containing keymap definitions with <C- or <leader>
rg --no-filename --no-line-number 'keymap\..*(<C-|<leader>)' ~/.config/nvim |

# Exclude lines that only contain comments with <C- or <leader>
grep -v '\-\-.*\(<C-\|<leader>\)' |

# Remove leading whitespace or tabs
sed 's/^[ \t]*//' |

# Remove 'vim.keymap.set(' prefix
sed 's/vim.keymap.set(//' |

# Sort by second field (the key combination), then by first (mode)
sort -t',' -k2,2 -k1,1 |

# Remove duplicates by key combination (only first occurrence kept)
awk -F',' '!seen[$2]++' |

# Delete everything up to and including the first comma (mode)
sed 's/^[^,]*,[[:space:]]*//'
