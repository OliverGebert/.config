#!/bin/bash

# script to install / update all relevant brew formulae

echo "*** brew :"
echo "- htop modern terminal substitute for top"
echo "- tree creates a files and folder tree"
echo "- zsh"
echo "- zsh-syntax-highlighting"
echo "- oh-my-posh"
echo "- hack-nerd-font"
echo "- tmux"
echo "- neovim"
echo "- ripgrep fuzzy grep"
echo "- tree-sitter"
echo "- git"
echo "- python + debugpy"
echo "- hashicorp-vagrant allows to start virtual machines"
echo "- bash"
echo "- gh github client CLI"
echo "- lazygit terminal git manager"
echo "- luajit LUA interpreter"
echo "- bat substitute for cat"
echo "- tmuxp python program to start tmux with a yaml configuration"
echo "- fzf terminal fuzzy finder"
echo "- entr runs commands on file changes"
echo "- age terminal encryption tool"
echo "- cataclysm"
echo "- atac termimnal API client"
echo "- termshark a GUI wrapper around tshark, analog to wireshark"
echo "- aerospace windows tile  manager"
echo "- pytest for python unit testing"
echo "- jq for butifying json output from curl"
echo "- curlie for having an easier to use curl variant"
echo "- pandoc for pdf converter"
echo "- basictex as mini LATEX distribution"

read -p 'Install or upgrade these components (y/n) ?' ANSWER

if [ "${ANSWER}" != "y" ] 
then
	echo "*** script stops. no brew executed"
	exit 1
fi

brew install htop
brew install tree
brew install zsh
brew install zsh-syntax-highlighting
brew install oh-my-posh
brew install hack-nerd-font
brew install tmux
brew install neovim
brew install ripgrep
brew install tree-sitter
brew install git
brew install python
pip install debugpy
brew install hashicorp-vagrant
brew install bash
brew install gh
brew install lazygit
brew install luajit
brew install bat
brew install tmuxp
brew install fzf
brew install entr
brew install age
brew install cataclysm
brew tap julien-cpsn/atac 
brew install atac
brew install termshark
brew install --cask nikitabobko/tap/aerospace
brew install pytest
brew install jq
brew install curlie
brew install pandoc
brew install basictex

echo "*** setup script completed"
echo "*** "
