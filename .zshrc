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
# initialize zoxide
eval "$(zoxide init zsh)"
# Zsh key bindings (z.B. für motions oder plugins wie zsh-vi-mode)
bindkey -v  # vi mode aktivieren
export KEYTIMEOUT=1
export VIRTUAL_ENV_DISABLE_PROMPT=0
# move zcompdump files into cache dir below .oh-my-zsh
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
# export scripts folder to enable usage for own shell scripts
export PATH="$HOME/.config/scripts:$PATH"
# export structurizr folder to enable usage for c4 model structurizr
export PATH="$HOME/.config/structurizr:$PATH"
export WORKON_HOME=$HOME/.virtualenvs

# aliases for shortcuts
alias h="history -E" # history with time stamp
alias c="clear" # clear screen
alias y="yazi" # open file explorer tui
alias zq="zoxide query -l --score" # query z DB
alias e="eza" # sub for ls
alias fc="fancy-cat" # cat with decorator
alias ht="htop" # process viewer
alias la="ls -la" # list directory long and all
alias lg="lazygit" # open lazygit tui
alias ld="lazydocker" # open lazydocker tui
alias nv="nvim" # open neovim
alias ts="termshark" # open wireshark tui based on tshark

# aliases for mini scripts
alias ela='eza -lha --git --icons' # eza long without git files
alias elt='eza --tree --icons -L 2' # eza with tree view
alias frm='rm -i "$(fzf)"' # fuzzy select and confirm for rm file
alias fcd='cd $(find . -type d | fzf)' # fuzzy cd
alias fbat='fzf --preview="bat --color=always {}"'  # preview fzf in bat
alias fnv='nvim $(fzf -m --preview="bat --color=always {}")'  # open fzf result in nvim
alias fas="aerospace list-windows --all |fzf --bind 'enter:execute(bash -c \"aerospace focus --window-id {1}\")+abort'"
alias tmk='tmux kill-session' # kill tmux session
alias nvzsh='nv ~/.config/.zshrc' # open neovim with .zshrc file for edit
alias npmup='npm -g outdated --parseable --depth=0 | cut -d: -f4 | xargs npm -g install'
alias lpath='echo $PATH | sed "s/:/\n/g" | sort'    # print $PATH with newline for each colon
alias wttr='curl -f "https://wttr.in/"'   # provide weather forecast

# alias for scripts
alias a="alias.sh" # shows all defined alias in .zshrc file
alias cheat="cheatsheet.sh" # opens API request on topic
alias help="searchhelper.sh" # searches all Helper.md files for matching string
alias tms="tmsessionloader.sh" # opens tmux session loader with parameter

function yz() {  # open yazi with y and cd into last dior on exit -Q to avoid cd
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
# pnp
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
export TERM=xterm-kitty

# Set blinking cursor at every prompt
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)
