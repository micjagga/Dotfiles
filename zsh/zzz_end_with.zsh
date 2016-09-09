# Load any custom end_with code

if [ -d $HOME/.home/.zsh.end_with/ ]; then
  if [ "$(ls -A $HOME/.home/.zsh.end_with/)" ]; then
    for config_file ($HOME/.home/.zsh.end_with/*.zsh) source $config_file
  fi
fi
