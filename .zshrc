# oh my section Path to your oh-my-zsh installation.
export ZSH="/Users/oli/oh-my-zsh"

# Set name of the theme: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"
source $ZSH/oh-my-zsh.sh

# creates posh prompt - now using starship -> disabled
# eval "$(oh-my-posh init zsh)"

# source modern vi navigation ZVM
source /usr/local/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# source syntax highlighting plugin
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
# command execution stamp shown in the history command output.
HIST_STAMPS="yyyy-mm-dd"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Standard plugins can be found in $ZSH/plugins/
plugins=(git)
plugins=virtualenv
# define catpppucchin mocha highlighting for zsh
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
# integrate carapace to zsh for tab completion 
eval "$(carapace _carapace)"
# Zsh key bindings (z.B. für motions oder plugins wie zsh-vi-mode)
bindkey -v  # vi mode aktivieren
export KEYTIMEOUT=1

export VIRTUAL_ENV_DISABLE_PROMPT=0
# move zcompdump files into cache dir below .oh-my-zsh
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
# export scripts folder to enable usage for own shell scripts
export PATH="$HOME/.config/scripts:$PATH"
export WORKON_HOME=$HOME/.virtualenvs

# aliases for shortcuts
alias h="history -E"
alias c="clear"
alias la="ls -la"
alias ht="htop"
alias nv="nvim"
alias lg="lazygit"
alias yz="yazi"
alias fc="fancy-cat"

# alias for scripts
alias cheat="cheatsheet.sh"
alias help="searchhelper.sh"
alias tms="tmsessionloader.sh"

# aliases for mini scripts
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
function y() {  # open yazi with y and cd into last dior on exit -Q to avoid cd
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
# pnpm
export PNPM_HOME="/Users/oli/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# starship init
eval "$(starship init zsh)"
# Starship Konfig angeben (z. B. ~/.config/starship.toml)
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# Catppuccin Farben für iterm2
# conflict with kitty grafic: export TERM=xterm-256color

# Set blinking cursor at every prompt
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)
