# Load any user customizations prior to load
#
if [ -d $HOME/.home/.zsh.start_with/ ]; then
  if [ "$(ls -A $HOME/.home/.zsh.start_with/)" ]; then
    for config_file ($HOME/.home/.zsh.start_with/*.zsh) source $config_file
  fi
fi

