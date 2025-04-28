# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/oli/oh-my-zsh"

# Set name of the theme to load
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

export WORKON_HOME=$HOME/.virtualenvs

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
plugins=virtualenv
# move zcompdump files into cache dir below .oh-my-zsh
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

source $ZSH/oh-my-zsh.sh
# OSX iterm2 requires to set Presets in iTerm preferences
# define catpppucchin mocha highlighting for zsh
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export VIRTUAL_ENV_DISABLE_PROMPT=0
export TDD_PROJECT_ROOT=/Users/oli/home/TDD
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

eval "$(oh-my-posh init zsh)"
# source syntax highlighting plugin
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pnpm
export PNPM_HOME="/Users/oli/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
