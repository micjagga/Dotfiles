# path, adding 0 to filename to ensure it starts first
path=(
  "/usr/bin"
  "/usr/local/sbin"
  "/usr/local/git/bin"
  "/usr/local/"
  "/usr/local/mysql/bin"
  "/sw/bin/"
  "$HOME/dotfiles/bin"
  "$HOME/bin"
  "$HOME/.rvm/bin"
  "$(brew --prefix ruby)/bin"
  "$(brew --prefix coreutils)/libexec/gnubin" # Add brew-installed GNU core utilities bin
  "$(brew --prefix)/share/npm/bin" # Add npm-installed package bin
)

PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
