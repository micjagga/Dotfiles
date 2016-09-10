#!/bin/sh
source ./config/bot/echos.sh
action "Setting up Iterm 2..."
# Symlink preferences
ln -s ./apps/iterm2/com.googlecode.iterm2.plist  ~/Library/Preferences/com.googlecode.iterm2.plist

