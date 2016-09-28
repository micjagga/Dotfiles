#############################################################
# Generic configuration that applies to all shells
#############################################################

source ~/.shellvars
source ~/.shellfn
source ~/.shellpaths
source ~/.shellaliases

# Private/Proprietary shell aliases (not to be checked into the public repo) :)
#source ~/Dropbox/Private/Boxes/osx/.shellaliases

for config_file in ($HOME/.dotfiles/**/*.zsh); do
  echo $config_file
  source $config_file
  read throwaway\?"Press return for next file"
done


