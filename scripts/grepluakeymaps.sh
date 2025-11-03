#!/bin/bash
# Script is used by Neovim to provide help on all custom keymappings

# Farben definieren
GREEN=$'\e[32m'   # Grün für Key
GRAY=$'\e[90m'    # Hellgrau für Beschreibung
RESET=$'\e[0m'
BLUE=$'\e[34m'
RED=$'\e[31m'

# Search recursively for lines containing keymap definitions with <C- or <leader>
rg --no-filename --no-line-number 'mapk\(' ~/.config/nvim --glob '!utils.lua' |

# Exclude lines that contain comments followed by <C- or <leader>
grep -v '\-\-.*\(<C-\|<leader>\)' |

# Remove leading whitespace, leading mapk and () function() -- " '
sed 's/^[ \t]*//' |
sed 's/mapk//' |
sed -E 's/^\(//; s/\)$//' |
sed "s/function()//g" |
sed "s/--//g" |
sed "s/['\"]//g" |

# remove douplicate entries
awk '!seen[$0]++' |

# Sort by second field (the key), then by first (mode)
sort -t',' -k2,2 -k1,1  |

# substitute with placeholder
sed 's/<,/PLACEHOLDER/' |

# AWK: vier Spalten aufteilen
awk -v red="$RED" -v green="$GREEN" -v gray="$GRAY" -v blue="$BLUE" -v reset="$RESET" '
BEGIN { FS = "," }
{
    # Trim spaces
    for (i=1;i<=NF;i++) gsub(/^[ \t]+|[ \t]+$/, "", $i)

    # Ausgabe
    printf "%s%-3s%s %s%-12s%s %s%-50s%s %s%s%s\n", \
        red, $1, reset, \
        green, $2, reset, \
        blue, $4, reset, \
        gray, $3, reset
}' |

# placeholder return
sed 's/PLACEHOLDER/<,/' 
