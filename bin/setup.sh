#!/usr/bin/env bash

# ===========================================================================================
# This script handles system binaries and other important CLI packages like homebrew, bash,
# zsh etc.
# ============================================================================================

source ./config/echos.sh
source ./config/requirers.sh

# ==========================================================================================
# install homebrew (CLI Packages)
# ==========================================================================================
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

# ==========================================================
# install brew cask (UI Packages)
# ===========================================================
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

# Disable Analytics sent to google
brew analytics off
# Ensure brew works well
brew doctor


# ============================================================================
#Install CLI tools using Homebrew
# =============================================================================

bot "installing command-line tools"

read -r -p "install the UNIX tools? (shells, wget, etc) [y|N] " unixresponse
if [[ $unixresponse =~ ^(y|yes|Y) ]];then
    ok "will install UNIX tools."
else
    ok "will skip UNIX tools.";
fi

read -r -p "install runtimes? (node, python, etc) [y|N] " runtimesresponse
if [[ $runtimesresponse =~ ^(y|yes|Y) ]];then
    ok "will install runtimes."
else
    ok "will skip runtimes.";
fi

read -r -p "install npm, gem, pip packages? [y|N] " packagesresponse
if [[ $packagesresponse =~ ^(y|yes|Y) ]];then
    ok "will install packages."
else
    ok "will skip packages.";
fi

if [[ $unixresponse =~ ^(y|yes|Y) ]];then
    action "install brew packages..."
    # Install GNU core utilities (those that come with OS X are outdated)
    require_brew coreutils
    require_brew moreutils
    # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
    require_brew findutils

    # Install Bash 4
    require_brew bash
    require_brew bash-completion

    # Install ZSH
    require_brew zsh
    require_brew zsh-completions

    # Install more recent versions of some OS X tools
    require_brew 'homebrew/dupes/grep'

    # Install Binaries
    require_brew git
    require_brew git-extras
    require_brew hub
    require_brew tree
    require_brew mackup
    require_brew trash
    require_brew fasd
    require_brew svn
    require_brew wget --enable-iri
    require_brew curl
    require_brew vim --override-system-vi
    require_brew nano
    require_brew whois
    require_brew unzip
    require_brew rsync
    require_brew cloc

    # Development tools
    require_brew ruby-install
    require_brew chruby
    require_brew mysql
    require_brew sqlite3
    require_brew mongodb
    require_brew ruby-build
    require_brew tmux
    require_brew screen
    require_brew mysql
    require_brew fontconfig
   #  require_brew fortune

    ok "packages installed..."
else
    ok "skipped command-line tools.";
fi

if [[ $runtimesresponse =~ ^(y|yes|Y) ]];then
    action "install brew packages..."
    # require_brew node
    # require_brew ruby
    require_brew nvm
    require_brew pyenv
    require_brew pyenv-virtualenv
    require_brew pyenv-virtualenvwrapper
    # require_brew python
    # require_brew python3

    ok "packages installed..."
else
    ok "skipped runtimes.";
fi

    # To list globally installed npm packages and version: npm list -g --depth=0
    # diff-so-fancy — sexy git diffs
    # git-recent — Type `git recent` to see your recent local git branches
    # git-open — Type `git open` to open the GitHub page or website for a repository
if [[ $packagesresponse =~ ^(y|yes|Y) ]];then
    action "install npm / gem / pip packages..."
    # require_npm bower
    # require_npm browser-sync
    # require_npm browserify
    # require_npm webpack
    # require_npm nodemon
    # require_npm sass-lint
    # require_npm grunt
    # require_npm gulp
    # require_npm jscs
    # require_npm jshint
    # require_npm eslint
    # require_npm eslint-plugin-react
    # require_npm babel-eslint
    # require_npm hyperlink
    # require_npm csscomb
    # require_npm disc
    # require_npm svgo
    # require_npm yo
    # require_npm flow-bin
    # require_npm flow-typed
    # require_npm servedir
    # require_npm npm-check-updates
     require_npm diff-so-fancy
     require_npm git-recent
     require_npm git-open
    # require_npm http-server
     require_gem bundler
     require_gem rake
     require_gem sass
     require_gem scss-lint
     require_pip requests
     require_pip beautifulsoup
     require_pip pillow
     require_pip sqlalchemy
     require_pip pygments
     require_pip flask
     require_pip flake8
     require_pip flake8-docstrings
     require_apm linter-flake8
    ok "packages installed..."
else
    ok "skipped packages."
fi
# ===========================================================================================
# Symlink binaries
# ===========================================================================================

ln -fs ./bin ~/

declare -a BINARIES=(
    'batcharge.py'
    'crlf'
    'dups'
    'git-delete-merged-branches'
    'nyan'
    'passive'
    'proofread'
    'ssh-key'
    'weasel'
)

for i in ${BINARIES[@]}; do
  action "Changing access permissions for binary script :: ${i##*/}"
  chmod +rwx $HOME/bin/${i##*/}
done
ok
unset BINARIES

bot "Woot! All done."


