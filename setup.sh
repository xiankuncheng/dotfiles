#!/usr/bin/env bash

#neovim config
ln -s .config ~/
#Alfred
cp -Rv Alfred/Alfred.alfredpreferences ~/Library/Application\ Support/Alfred/
#Hammerspoon
ln -s .hammerspoon ~/
#iTerm
cp -Rv iTerm/com.googlecode.iterm2.plist ~/Library/Preferences
#zshrc
ln -s .zshrc ~/
#doom emacs personal config
ln -s .doom.d ~/
#spacemacs personal config
ln -s .spacemacs  ~/
#defualt emacs profile when without profile
ln -s .emacs-profile ~/
#emacs profiles
ln -s .emacs-profiles.el ~/
