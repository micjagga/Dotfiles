## What Is This?

A repository for setting up and maintaining  an OSX machine. With technological advances and bleeding edge technology, This project aims to help adapt an OSX machine to theses changes. This is an opinionated setup for development on an OSX environment.  Feel free to explore, learn and copy parts for your own dotfiles. Enjoy! :smile:

## `[(^_^)]` - Hi, I'm buxbot - leonrds OSX bot

I will set-up your OSX machine with Better™ system defaults, preferences, software configuration and even auto-install some handy development tools and apps that my developer friends find helpful.

You only need a to follow a few basic install options and you’re good to go. I can work with a brand-new system from the factory as well as an existing machine that you've been working with for years.

## Installation

```zsh
# Clone the repository,
git clone --recursive https://github.com/micjagga/b-dotfiles.git  ~/.dotfiles
# Give permisions and enter dotfiles directory
cd ~/.dotfiles; chmod +x install.sh
# Run the shell script
./install.sh
```

Alternatively, you can install this into ~/.dotfiles remotely without Git using curl:

sh -c "`curl -fsSL https://raw.github.com/micjagga/dotfiles/master/remote-setup.sh`"
Or, using wget:

sh -c "`wget -O - --no-check-certificate https://raw.githubusercontent.com/micjagga/dotfiles/master/remote-setup.sh`"


### Dotfiles.todo
- [x] ~~sort out git aliases from `.gitconfig` and `aliases.zsh`~~ @todo
- [ ]  leave `vim` & `vimrc` for last @low
- [x] ~~look into  [`dirpersist.plugin.zsh`](https://github.com/reenhanced/zsh-config/blob/master/plugins/dirpersist/dirpersist.plugin.zsh)~~
- [x] ~~look into the last few `z*rc’s` form [automantic](https://github.com/atomantic/dotfiles/tree/master/homedir)~~ @todo
- [x] ~~`"EditorConfig"` plugin to be added to sublime plugin list~~ @todo @done(2016-07-12)
- [ ] `.gitignore` - vim options @low
- [x] ~~work on osx installs -adapt to bot~~ @done(2016-07-12)
- [x] ~~edit `zshrc` to allow other zsh enhancements work~~ @im @done(2016-07-12)
- [x] ~~find a way to overide  `.zpreztorc & zshrc` while installing dotfiles.~~ @done(2016-07-12)
- [x] ~~Fix git template bugs~~ @bugs @done(2016-07-12)
- [x] ~~Fix sublime 3~~ @done(2016-07-12)
- [x] ~~Look into osx file from [mathias bynens](https://github.com/mathiasbynens/dotfiles/blob/master/.osx)~~ @im
- [x] ~~Note down application paid for and licenses~~ @im


###  Optional.todo
- ~~`.eslintrc` javascript~~ @low @done(2016-07-15) {>>Don't need to till i start java script<<}
- ~~look  up `fasd`~~ @done(2016-07-15)
- ~~Study about regex and `grep`~~ {>>globally search for a regular expression and print<<}
-  ~~Look into [cowboys dotfiles](https://github.com/cowboy/dotfiles/blob/1d26c50/bin/dotfiles#L164-165) for guide~~ @done(2016-07-15)
- ~~ask what this means `if sudo grep -q "# %wheel\tALL=(ALL) NOPASSWD: ALL" "/etc/sudoers"; then`~~ @done(2016-07-13)
-  ~~look up `ctags` @now  @p4~~ {>>Would install if vim is installed<<}  @done(2016-07-15)
- ~~Look up [permission and ownership](http://askubuntu.com/questions/409025/permission-denied-when-running-sh-scripts)~~ @low @done(2016-07-15)
- ~~Fix alfed 3~~ @done(2016-07-15)
- ~~Look into integrating with nodejs from [atomantion](https://github.com/atomantic/dotfiles)~~ @low @now @done(2016-07-15) {>>I don't really know JavaScript unfortunately :sad}<<}
-  Write out documentation @p7
- ~~Look into paul millir’s git extras & git templates @now and his OS X setup file.~~ @im @done(2016-07-15)
- create a nice theme for prezto @high @todo

## Acknowledgements

Firstly I’d like to give recognition to  the [Unoffical Github Dotfiles] (https://dotfiles.github.io/) for being a point of reference while i undertook this project. Thanks to [Dries Vints](https://driesvints.com/blog/getting-started-with-dotfiles/)  and [Adam Eivy]( https://github.com/atomantic/dotfiles) work for guiding me through the project . [Sourabh Bajaj](https://twitter.com/sb2nov/)'s [Mac OS X Setup Guide](http://sourabhbajaj.com/mac-setup/) proved to be indispensable. In addition, Thanks to  [Nick Plekhanov's](https://github.com/nicksp/dotfiles) dotfiles i was able to finalise the project.

 Acknowledgements to everyone  who believes in the spirit of open-sources. I’d like to thank each and everyone of you for the contributions made to the open source community, most especially those who open-sourced thier dotfiles :earth_africa: :heart:


## License
ISC License (ISC)

**Copyright (c) 2015, Enoc Leonrd <leonrdenoc@gmail.com>**

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.
