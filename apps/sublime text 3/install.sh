#!/bin/sh
source ./configurations/bot/echos.sh
action "Setting up Sublime Text 3..."
# Make sure library directory exists
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages

# Symlink user preferences
action 'Linking Preferences...'
ln -s ~/.dotfiles/apps/sublime\ text\ 3/preferences ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User;ok
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl;ok

# Install Package Control
bot "Installing package control for sublime text"
curl -o ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package https://packagecontrol.io/Package\ Control.sublime-package
ok
bot "All done! Sublime Text 3 is good to go! woot!"
