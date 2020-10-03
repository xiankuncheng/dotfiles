#!/usr/bin/env bash
CURRENT_FOLDER=$(cd "$(dirname "$0")";pwd)

# config
ln -s $CURRENT_FOLDER/.config ~/
#Alfred
ln -s $CURRENT_FOLDER/Alfred/Alfred.alfredpreferences ~/Library/Application\ Support/Alfred/
#Hammerspoon
ln -s $CURRENT_FOLDER/.hammerspoon ~/
#iTerm
ln -s $CURRENT_FOLDER/iTerm/com.googlecode.iterm2.plist ~/Library/Preferences
#zshrc
ln -s $CURRENT_FOLDER/.zshrc ~/
#spacemacs personal config
ln -s $CURRENT_FOLDER/.spacemacs  ~/
#defualt emacs profile when without profile
ln -s $CURRENT_FOLDER/.emacs-profile ~/
#emacs profiles
ln -s $CURRENT_FOLDER/.emacs-profiles.el ~/
#spacemacs private layer
ln -s $CURRENT_FOLDER/spacemacs/private ~/spacemacs/
