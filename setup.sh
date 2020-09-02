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
#spacemacs personal config
cp -Rv .spacemacs  ~/
#defualt emacs profile when without profile
cp -Rv .emacs-profile ~/
#emacs profiles
cp -Rv .emacs-profiles.el ~/
