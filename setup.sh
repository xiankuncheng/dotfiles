#!/usr/bin/env bash

#neovim config
cp -Rv .config ~/
#Alfred
cp -Rv Alfred/Alfred.alfredpreferences ~/Library/Application\ Support/Alfred/
#Hammerspoon
cp -Rv .hammerspoon ~/
#iTerm
cp -Rv iTerm/com.googlecode.iterm2.plist ~/Library/Preferences
#zshrc
cp .zshrc ~/
#doom emacs personal config
cp -Rv .doom.d ~/
#spacemacs personal config
cp -Rv .spacemacs  ~/
#defualt emacs profile when without profile
cp -Rv .emacs-profile ~/
#emacs profiles
cp -Rv .emacs-profiles.el ~/
