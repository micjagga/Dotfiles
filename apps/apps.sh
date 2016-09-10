#!/usr/bin/env bash

# include my library helpers for colorized echo and require_brew, etc
source ./config/echos.sh

###############################################################################
#Install GUI tools using Homebrew                                             #
###############################################################################

bot "Initialising Application Tools™"
bot "Setting up buxbot (better defaults)™"

read -r -p "install default daily tools? (Browsers, Slack, etc) [y|N] " dailyresponse
if [[ $dailyresponse =~ ^(y|yes|Y) ]];then
    ok "will install everyday tools."
else
    ok "will skip everyday tools.";
fi

read -r -p "install the designer tools? (Dropbox, Sketch, etc) [y|N] " designerresponse
if [[ $designerresponse =~ ^(y|yes|Y) ]];then
    ok "will install designer tools."
else
    ok "will skip designer tools.";
fi

read -r -p "install the developer tools? (iTerm, Sublime Text, etc) [y|N] " developerresponse
if [[ $developerresponse =~ ^(y|yes|Y) ]];then
    ok "will install developer tools."
else
    ok "will skip developer tools.";
fi

read -r -p "install the Quicklook plugins? [y|N] " quicklookresponse
if [[ $quicklookresponse =~ ^(y|yes|Y) ]];then
    ok "will install Quicklook plugins."
else
    ok "will skip Quicklook plugins.";
fi

read -r -p "install other useful Utility tools? (flux, Cdock, duet, displayLink etc) [y|N] " utilresponse
if [[ $utilresponse =~ ^(y|yes|Y) ]];then
    ok "will install Utility tools."
else
    ok "will skip Utility tools.";
fi

bot "Let's go! Make sure to check on your computer regularly in case something needs your password."

if [[ $everydayresponse =~ ^(y|yes|Y) ]];then
    action "install brew cask packages..."

    require_cask firefox
    require_cask google-chrome

    require_cask google-drive
    require_cask avast

    require_cask alfred
    require_cask skype
    # require_cask google-hangouts
    require_cask slack
    require_cask harvest
    require_cask vlc
    require_cask fluid
    require_cask spotify
    require_cask steam
    require_cask transmission
    require_cask typora
    require_cask microsoft-office
    require_cask raindrop
    require_cask notion

    ok "Music Players, Messangers, Utility Apps, Browsers etc. All set!"
    ok "Daily casks installed..."
else
    ok "skipped everyday tools.";
fi

if [[ $designerresponse =~ ^(y|yes|Y) ]];then

    action "install brew cask packages..."

    require_cask dropbox
    require_cask sketch
    require_cask skyfonts
    # require_cask adobe-creative-cloud


    ok "casks installed..."
else
    ok "skipped designer tools.";
fi

if [[ $developerresponse =~ ^(y|yes|Y) ]];then

    action "install brew cask packages..."

    require_cask intellij-idea
    require_cask pycharm
    require_cask atom
    require_cask sublime-text
    require_cask visual-studio-code
    require_cask google-chrome-canary
    require_cask whiskey
    require_cask macdown
    require_cask datagrip
    require_cask dash
    # require_cask opera

    require_cask iterm2
    require_cask vagrant
    require_cask virtualbox
    require_cask ngrok
    require_cask screenhero
    require_cask gitup
    require_cask sourcetree
    require_cask imagealpha
    require_cask imageoptim

    require_cask querious
    require_cask kaleidoscope
    # require_cask pgadmin3

    ok "IDE's, Git clients, Database Management Apps, Text Editors etc. All set!"
    ok  "Developer casks installed..."
else
    ok "skipped developer tools.";
fi

if [[ $quicklookresponse =~ ^(y|yes|Y) ]];then

    action "install brew cask packages..."

    require_cask qlcolorcode
    require_cask qlstephen
    require_cask qlmarkdown
    require_cask quicklook-json
    require_cask qlprettypatch
    require_cask quicklook-csv
    require_cask betterzipql
    require_cask webpquicklook
    require_cask suspicious-package
    require_cask epubquicklook

    ok "casks installed..."
else
    ok "skipped Quicklook plugins";
fi

if [[ $utilresponse =~ ^(y|yes|Y) ]];then

    action "install brew cask packages..."

    require_cask flux
    require_cask raindrop
    require_cask tunnelbear
    require_cask bartender
    require_cask superduper
    require_cask bitbar
    require_cask totalfinder
    require_cask cdock
    require_cask duet
    require_cask displaylink
    require_cask adguard
    require_cask bestres
    require_cask little-snitch
    require_cask revisions

    ok "Addtional System Utilities all set!"
    ok "Utilities Casks installed"
else
    ok "skipped Utility tools.";
fi
# Setup applications
###############################################################################
bot "Setting up apps..."
###############################################################################
bot "Atom "
action 'Symlinking Atom to [~/]'
running "Copying Atom settings.."
mv -f ~/.atom ~/.dotfiles_backup/
ln -s ./apps/atom ~/.atom; ok

running "Copying over Atom packages"
cp -r ./apps/atom/packages.list ~/.atom; ok

running "Installing Atom community packages"
apm list --installed # --bare  - get a list of installed packages
apm install --packages-file ~/.atom/packages.list; ok

bot 'iTerm 2'
source ./applications/iterm\ 2/install.sh

bot 'Sublime Text 3'
source ./applications/sublime\ text\ 3/install.sh
ok
bot "All done!"
