#!/bin/bash

# script to install / update all relevant brew formulae

echo "*** brew :"
echo "- htop"
echo "- tree"
echo "- zsh"
echo "- zsh-syntax-highlighting"
echo "- oh-my-posh"
echo "- hack-nerd-font"
echo "- tmux"
echo "- neovim"
echo "- ripgrep"
echo "- tree-sitter"
echo "- git"
echo "- python"
echo "- hashicorp-vagrant"

echo "- brew install gh"
echo "- brew install lazygiecho"
echo "- brew install luajit"
echo "- brew install bat"

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
brew install hashicorp-vagrant
brew install gh
brew install lazygit
brew install luajit
brew install bat

echo "*** setup script completed"
echo "*** "
