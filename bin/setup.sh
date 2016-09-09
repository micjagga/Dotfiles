#!/usr/bin/env bash
source ./config/echos.sh

###############################################################################
#Install CLI tools using Homebrew                                             #
###############################################################################

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
    brew 'homebrew/dupes/grep'

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
    require_brew rbenv
    require_brew mysql
    require_brew sqlite3
    require_brew mongodb
    require_brew ruby-build
    require_brew tmux
    require_brew screen
    require_brew mysql
    require_brew fontconfig

    ok "packages installed..."
else
    ok "skipped command-line tools.";
fi

if [[ $runtimesresponse =~ ^(y|yes|Y) ]];then
    action "install brew packages..."

    require_brew node
    require_brew ruby
    require_brew python
    require_brew python3

    ok "packages installed..."
else
    ok "skipped runtimes.";
fi

if [[ $packagesresponse =~ ^(y|yes|Y) ]];then
    action "install npm / gem / pip packages..."

    function require_gem() {
        running "gem $1"
        if [[ $(gem list --local | grep "$1" | head -1 | cut -d' ' -f1) != "$1" ]];
            then
                action "gem install $1"
                gem install "$1"
        fi
        ok
    }

    function require_pip() {
        running "pip $1"
        if [[ $(pip list --local | grep "$1" | head -1 | cut -d' ' -f1) != "$1" ]];
            then
                action "pip install $1"
                pip install "$1"
        fi
        ok
    }

    npmlist=$(npm list -g)
    function require_npm() {
        running "npm $1"
        echo "$npmlist" | grep "$1@" > /dev/null
        if [[ $? != 0 ]]; then
            action "npm install -g $1"
            npm install -g "$1"
        fi
        ok
    }

    require_npm bower
    require_npm browser-sync
    require_npm browserify
    require_npm webpack
    require_npm nodemon
    require_npm sass-lint
    require_npm grunt
    require_npm gulp
    require_npm jscs
    require_npm jshint
    require_npm eslint
    require_npm eslint-plugin-react
    require_npm babel-eslint
    require_npm sitespeed.io
    require_npm hyperlink
    require_npm csscomb
    require_npm disc
    require_npm svgo
    require_npm yo
    require_npm flow-bin
    require_npm flow-typed
    require_npm servedir
    require_npm npm-check-updates

    # Globally install with npm
    # To list globally installed npm packages and version: npm list -g --depth=0
    #
    # Some descriptions:
    #
    # diff-so-fancy — sexy git diffs
    # git-recent — Type `git recent` to see your recent local git branches
    # git-open — Type `git open` to open the GitHub page or website for a repository
    require_npm diff-so-fancy
    require_npm git-recent
    require_npm git-open
    require_npm http-server

    require_gem bundler
    require_gem rake
    require_gem sass
    require_gem scss-lint

    require_pip virtualenv

    ok "packages installed..."
else
    ok "skipped packages.";
fi
# Copy binaries
ln -fs ./bin $HOME

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


