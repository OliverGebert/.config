# oh my section Path to your oh-my-zsh installation.
export ZSH="/Users/oli/oh-my-zsh"

# Set name of the theme to load
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"
source $ZSH/oh-my-zsh.sh

# creates posh prompt - now using starship -> disabled
# eval "$(oh-my-posh init zsh)"

# source modern vi navigation ZVM
source /usr/local/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# source syntax highlighting plugin
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# command execution stamp shown in the history command output.
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

export WORKON_HOME=$HOME/.virtualenvs
# integrate carapace to zsh
eval "$(carapace _carapace)"

# Standard plugins can be found in $ZSH/plugins/
plugins=(git)
plugins=virtualenv
# OSX iterm2 requires to set Presets in iTerm preferences
# define catpppucchin mocha highlighting for zsh
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export VIRTUAL_ENV_DISABLE_PROMPT=0
# move zcompdump files into cache dir below .oh-my-zsh
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
# export scripts folder to enable usage for own shell scripts
export PATH="$HOME/.config/scripts:$PATH"

# aliases for shortcuts
alias h="history"
alias c="clear"
alias la="ls -la"
alias ht="htop"
alias nv="nvim"
alias lg="lazygit"

# alias for scripts
alias cheat="cheatsheet.sh"
alias help="searchhelper.sh"
alias tms="tmsessionloader.sh"

# aliases for mini scripts
# alias tms='tmuxp load tmsession.yaml'  # obsolete, tms.sh script select right .yml file depending on external display
alias tmk='tmux kill-session'
alias ela='eza -lha --git --icons'
alias elt='eza --tree --icons -L 2'
alias fcd='cd $(find . -type d | fzf)'
alias fbat='fzf --preview="bat --color=always {}"'  # preview fzf in bat
alias fas="aerospace list-windows --all |fzf --bind 'enter:execute(bash -c \"aerospace focus --window-id {1}\")+abort'"
alias fnv='nvim $(fzf -m --preview="bat --color=always {}")'  # open fzf result in nvim
alias nvzsh='nv ~/.config/.zshrc'
alias lpath='echo $PATH | sed "s/:/\n/g" | sort'    # print $PATH with newline for each colon
alias wttr='curl -f "https://wttr.in/"'   # provide weather forecast
alias draw='/Applications/draw.io.app/Contents/MacOS/draw.io'

# pnpm
export PNPM_HOME="/Users/oli/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# starship
eval "$(starship init zsh)"
# integrate starship with ZVM - custom prompt for insert and normal mode
function update_starship_vim_mode() {
  if [[ "${ZVM_MODE}" == "vicmd" ]]; then
    export STARSHIP_VIM_MODE="NORMAL"
  else
    export STARSHIP_VIM_MODE="INSERT"
  fi
}
# Funktion: wird bei Moduswechsel aufgerufen
function zle-keymap-select-hook() {
  update_starship_vim_mode
  zle reset-prompt
}
# Hook registrieren für Moduswechsel (nur wenn ZLE aktiv ist)
autoload -Uz add-zsh-hook
zle -N zle-keymap-select zle-keymap-select-hook
add-zsh-hook precmd update_starship_vim_mode

# Zsh key bindings (z.B. für motions oder plugins wie zsh-vi-mode)
bindkey -v  # vi mode aktivieren
export KEYTIMEOUT=1

# Starship Konfig angeben (z. B. ~/.config/starship.toml)
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# Catppuccin Farben für Terminal (wenn z. B. Alacritty oder iTerm2)
export TERM=xterm-256color
