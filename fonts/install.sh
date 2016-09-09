#!/bin/sh
source ./configurations/bot/echos.sh

bot "Installing fonts..."


# Set source and target directories
powerline_fonts_dir=$( cd "$( dirname "$0" )" && pwd )
action "Locating indexed/patched fonts..."
find_command="find \"$powerline_fonts_dir\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"; ok

if [[ `uname` == 'Darwin' ]]; then
  # MacOS
  font_dir="$HOME/Library/Fonts"
else
  # Linux
  font_dir="$HOME/.local/share/fonts"
  mkdir -p $font_dir
fi

# Copy all fonts to user fonts directory
action "Copying fonts..."
eval $find_command | xargs -0 -I % cp "%" "$font_dir/"; ok

# Reset font cache on Linux
if command -v fc-cache @>/dev/null ; then
    action "Resetting font cache, this may take a moment..."
    fc-cache -f $font_dir
fi
ok
bot "All Powerline fonts installed to $font_dir"

brew tap caskroom/fonts

require_cask font-sauce-code-powerline
require_cask font-fontawesome
require_cask font-open-sans
require_cask font-pt-sans
require_cask font-source-sans-pro

bot "Woot! All done."
