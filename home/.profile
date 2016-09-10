#############################################################
# Generic configuration that applies to all shells
#############################################################

source ~/.shellvars
source ~/.shellfn
source ~/.shellpaths
source ~/.shellaliases
source ~/.bin/path
source ~/shell_config

# Private/Proprietary shell aliases (not to be checked into the public repo) :)
#source ~/Dropbox/Private/Boxes/osx/.shellaliases

if [ -d $HOME/.dotfiles/zsh/ ]; then
  if [ "$(ls -A $HOME/.dotfiles/zsh/)" ]; then
    for config_file ($HOME/.dotfiles/zsh/*.zsh) source $config_file
  fi
fi

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi
