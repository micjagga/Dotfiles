#!/usr/bin/env bash
###
# some colorized echo helpers
 #Thanks to Adam Eivy https://github.com/atomantic/dotfiles
###

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

function ok() {
    echo -e "$COL_GREEN[DONE]$COL_RESET "$1
}

function bot() {
    echo -e "\n$COL_GREEN\[(^_^)]/$COL_RESET - "$1
}

function running() {
    echo -en "$COL_YELLOW ⇒ $COL_RESET"$1": "
}

function action() {
    echo -e "\n$COL_YELLOW[action]:$COL_RESET\n ⇒ $1..."
}

function warn() {
    echo -e "$COL_YELLOW[warning]:$COL_RESET "$1
}

function error() {
    echo -e "$COL_RED[error]$COL_RESET "$1
}

function awesome_header() {
    echo -en "\n$COL_GREEN          ██            ██     ████ ██  ██ $COL_RESET"
    echo -en "\n$COL_GREEN         ░██           ░██    ░██░ ░░  ░██ $COL_RESET"
    echo -en "\n$COL_GREEN         ░██  ██████  ██████ ██████ ██ ░██  █████   ██████ $COL_RESET"
    echo -en "\n$COL_GREEN      ██████ ██░░░░██░░░██░ ░░░██░ ░██ ░██ ██░░░██ ██░░░░ $COL_RESET"
    echo -en "\n$COL_GREEN     ██░░░██░██   ░██  ░██    ░██  ░██ ░██░███████░░█████ $COL_RESET"
    echo -en "\n$COL_GREEN    ░██  ░██░██   ░██  ░██    ░██  ░██ ░██░██░░░░  ░░░░░██ $COL_RESET"
    echo -en "\n$COL_GREEN    ░░██████░░██████   ░░██   ░██  ░██ ███░░██████ ██████ $COL_RESET"
    echo -en "\n$COL_GREEN     ░░░░░░  ░░░░░░     ░░    ░░   ░░ ░░░  ░░░░░░ ░░░░░░ $COL_RESET"
    echo -en "\n$COL_GREEN  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓$COL_RESET"
    echo -en "\n$COL_GREEN  ░▓ Software Installation, Configuration and Preferences for OS ▓$COL_RESET"
    echo -en "\n$COL_GREEN  ░▓ https://github.com/micjagga/dotfiles                        ▓$COL_RESET"
    echo -en "\n$COL_GREEN  ░▓ Enoc Leonrd - http://leonrdenoc.me                          ▓$COL_RESET"
    echo -en "\n$COL_GREEN  ░▓ For more help add -h or --help to install script            ▓$COL_RESET"
    echo -en "\n$COL_GREEN  ░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓$COL_RESET"
    echo -en "\n"
}
