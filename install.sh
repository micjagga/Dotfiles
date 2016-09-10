 #!/usr/bin/env bash

# ###########################
# This script installs the dotfiles and symlink better system defaults to the system
# ###########################

source ./config/echos.sh
source ./config/requirers.sh

# Warn user this script will overwrite current dotfiles
while true; do
  read -p "Warning: this will overwrite your current dotfiles. Continue? [y/n] " yn
  case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit;;
    * ) bot "Please answer yes or no.";;
  esac
done


grep 'user = GITHUBUSER' ./git/.gitconfig > /dev/null 2>&1
if [[ $? = 0 ]]; then
    read -r -p "What is your github.com username? " githubuser

  fullname=`osascript -e "long user name of (system info)"`

  if [[ -n "$fullname" ]];then
    lastname=$(echo $fullname | awk '{print $2}');
    firstname=$(echo $fullname | awk '{print $1}');
  fi

  if [[ -z $lastname ]]; then
    lastname=`dscl . -read /Users/$(whoami) | grep LastName | sed "s/LastName: //"`
  fi
  if [[ -z $firstname ]]; then
    firstname=`dscl . -read /Users/$(whoami) | grep FirstName | sed "s/FirstName: //"`
  fi
  email=`dscl . -read /Users/$(whoami)  | grep EMailAddress | sed "s/EMailAddress: //"`

  if [[ ! "$firstname" ]];then
    response='n'
  else
    echo -e "I see that your full name is $COL_YELLOW$firstname $lastname$COL_RESET"
    read -r -p "Is this correct? [Y|n] " response
  fi

  if [[ $response =~ ^(no|n|N) ]];then
    read -r -p "What is your first name? " firstname
    read -r -p "What is your last name? " lastname
  fi
  fullname="$firstname $lastname"

  bot "Great $fullname, "

  if [[ ! $email ]];then
    response='n'
  else
    echo -e "The best I can make out, your email address is $COL_YELLOW$email$COL_RESET"
    read -r -p "Is this correct? [Y|n] " response
  fi

  if [[ $response =~ ^(no|n|N) ]];then
    read -r -p "What is your email? " email
    if [[ ! $email ]];then
      error "you must provide an email to configure .gitconfig"
      exit 1
    fi
  fi


  running "replacing items in .gitconfig with your info ($COL_YELLOW$fullname, $email, $githubuser$COL_RESET)"

  # test if gnu-sed or osx sed

  sed -i "s/GITHUBFULLNAME/$firstname $lastname/" ./.home/.gitconfig > /dev/null 2>&1 | true
  if [[ ${PIPESTATUS[0]} != 0 ]]; then
    echo
    running "looks like you are using OSX sed rather than gnu-sed, accommodating"
    sed -i '' "s/GITHUBFULLNAME/$firstname $lastname/" ./git/.gitconfig;
    sed -i '' 's/GITHUBEMAIL/'$email'/' ./git/.gitconfig;
    sed -i '' 's/GITHUBUSER/'$githubuser'/' ./git/.gitconfig;
  else
    echo
    bot "looks like you are already using gnu-sed. woot!"
    sed -i 's/GITHUBEMAIL/'$email'/' ./git/.gitconfig;
    sed -i 's/GITHUBUSER/'$githubuser'/' ./git/.gitconfig;
  fi
fi

#####
# install homebrew (CLI Packages)
#####

running "checking homebrew install"
brew_bin=$(which brew) 2>&1 > /dev/null
if [[ $? != 0 ]]; then
  action "installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if [[ $? != 0 ]]; then
      error "unable to install homebrew, script $0 abort!"
      exit 2
  fi
else
  ok
  # Make sure we’re using the latest Homebrew
  running "updating homebrew"
  brew update
  ok
  bot "before installing brew packages, we can upgrade any outdated packages."
  read -r -p "run brew upgrade? [y|N] " response
  if [[ $response =~ ^(y|yes|Y) ]];then
      # Upgrade any already-installed formulae
      action "upgrade brew packages..."
      brew upgrade --all
      ok "brews updated..."
  else
      ok "skipped brew package upgrades.";
  fi
fi

#####
# install brew cask (UI Packages)
#####
running "checking brew-cask install" ok
output=$(brew tap | grep cask)
if [[ $? != 0 ]]; then
  action "installing brew-cask"
  require_brew caskroom/cask/brew-cask
fi
brew tap caskroom/versions > /dev/null 2>&1
ok

#####
# install brew cask (UI Packages)
#####
running " \xF0\x9f\x8d\xba  brewing your packages..." ok
running " \xF0\x9f\x8d\xba  casking your applications..." ok

# Ensure brew works well
brew doctor

action "Setting up your Mac..." ok
action "initialisaing home..." ok
mkdir -p ~/.home
mkdir -p ~/Documents/Temp
mkdir -p ~/Documents/Code
mkdir -p ~/Documents/Temp/Scratch

# install osk settings, app preferences and bin directories
source ./apps/apps.sh
source ./fonts/install.sh
ok

if [ -d $HOME/.dotfiles/zsh/ ] ; then
    export PATH="$HOME/.dotfiles/zsh/:$PATH"
    export PATH="$HOME/.dotfiles/:$PATH"
fi

# set zsh as the user login shell
CURRENTSHELL=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')
if [[ "$CURRENTSHELL" != "/usr/local/bin/zsh" ]]; then
  bot "setting newer homebrew zsh (/usr/local/bin/zsh) as your shell (password required)"
  # sudo bash -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
  # chsh -s /usr/local/bin/zsh
  sudo dscl . -change /Users/$USER UserShell $SHELL /usr/local/bin/zsh > /dev/null 2>&1
  ok
fi

bot "Creating directories for your customizations"
mkdir -p $HOME/.home/.zsh.start_with
mkdir -p $HOME/.home/.zsh.end_with
mkdir -p $HOME/.home/.zsh.prompts
ok

bot "creating symlinks for shell dotfiles..."
pushd home > /dev/null 2>&1
now=$(date +"%Y.%m.%d.%H.%M.%S")

for file in .*; do
  if [[ $file == "." || $file == ".." ]]; then
    continue
  fi
  running "~/$file"
  # if the file exists:
  if [[ -e ~/$file ]]; then
      mkdir -p ~/.dotfiles_backup/$now
      mv ~/$file ~/.dotfiles_backup/$now/$file
      echo "backup saved as ~/.dotfiles_backup/$now/$file"
  fi
  # symlink might still exist
  unlink ~/$file > /dev/null 2>&1
  # create the link
  ln -s ~/.dotfiles/shell/$file ~/$file
  echo -en '\tlinked';ok
done
popd > /dev/null 2>&1


bot "Installing Prezto (ZSH Enhancements)..."
ln -nfs ~/.dotfiles/zsh/prezto ${ZDOTDIR:-$HOME}/.zprezto
action "creating symlinks for prezto files..."

pushd  ~/.zprezto/runcoms > /dev/null 2>&1
now=$(date +"%Y.%m.%d.%H.%M.%S")
for file in *; do
  if [[ $file == "." || $file == ".." ]]; then
    continue
  fi
  running "~/$file"
  # if the file exists:
  if [[ -e ~/$file ]]; then
      mkdir -p ~/.zsh_backup/$now
      mv ~/$file ~/.zsh_backup/$now/$file
      echo "backup saved as ~/.zsh_backup/$now/$file"
  fi
  # symlink might still exist
  unlink ~/$file > /dev/null 2>&1
  # create the link
  # shopt -s extglob
  ln -s ~/.zprezto/runcoms/$file ${ZDOTDIR:-$HOME}/.${file:t}
  echo -en '\tlinked';ok
done
rm ~/.README.md
popd > /dev/null 2>&1

action "Overriding prezto ~/.zpreztorc with custom zpreztorc to enable additional modules..."
ln -nfs ~/.dotfiles/zsh/zpreztorc  ${ZDOTDIR:-$HOME}/.zpreztorc
action 'activating zsh enhancements'
echo 'for config_file ($HOME/.dotfiles/zsh/*.zsh) source $config_file ' >> ~/.zshrc  ok
# Symlink online-check.sh
ln -fs ./config/online-check.sh  ~/online-check.sh

action "Write out current crontab"
crontab -l > mycron
# Echo new cron into cron file
echo "0 1 * * * ~/online-check.sh" >> mycron
echo "0 2 * * *  gem update -V -y" >> mycron
echo "# brew nightly updates" >> mycron
echo "0 3 * * *  brew update" >> mycron
echo "0 4 * * *  brew upgrade" >> mycron
echo "# npm" >> mycron
echo "0 5 * * *  npm update npm -g" >> mycron
echo "0 6 * * *  npm update -g" >> mycron
# Install new cron file
crontab mycron
rm mycron

bot "Installing a stable version of Node..."
sourceNVM
# Install the latest stable version of node
nvm install stable
# Switch to the installed version
nvm use node
# # Use the stable version of node by default
nvm alias default node

bot "Installing a stable version of python..."
# Installing python 2
pyenv install 2.7.12
# Installing Python 3
ok
bot "Installing the dev version of python 3 & miniconda..."
pyenv install 3.5.
pyenv install miniconda-latest
ok
# Setting python 3 globally
pyenv global miniconda-latest
# update pip
easy_install pip

running "cleanup homebrew"
brew cleanup > /dev/null 2>&1
ok

sh ./macos/osx-defaults.sh

###############################################################################
# Kill affected applications                                                  #
###############################################################################
bot "OK. Note that some of these changes require a logout/restart to take effect. Killing affected applications (so they can reboot)...."
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Mail" "Messages" "Safari" "SizeUp" "SystemUIServer" \
  "iCal" "iterm 2"; do
  killall "${app}" > /dev/null 2>&1
done
ok

# bot "I will now back up your configurations and setting to Dropbox (\n make sure you're logged in)"
# action "Backing Up "
# mackup backup
# ok

bot "Woot! All done."

# Wait a bit before moving on...
sleep 1

# ...and then.
bot "Success! Defaults are set."
bot "Some changes will not take effect until you reboot your machine."

# See if the user wants to reboot.
function reboot() {
 read -p "Do you want to reboot your computer now? (y/N)" choice
 case "$choice" in
   y | Yes | yes ) echo "Yes"; exit;; # If y | yes, reboot
   n | N | No | no) echo "No"; exit;; # If n | no, exit
   * ) warn "Invalid answer. Enter \"y/yes\" or \"N/no\"" && return;;
 esac
}

# Call on the function
if [[ "Yes" == $(reboot) ]]
then
 action "Rebooting."
 sudo reboot
 exit 0
else
 exit 1
fi
