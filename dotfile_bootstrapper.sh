#!/bin/bash

function config {
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME "$@"
}

# WARNING: this will try to checkout dotfiles into $HOME. Conflicting files will be backed up.
git clone --bare https://github.com/jugheadny/dotfiles.git $HOME/.cfg
mkdir -p $HOME/.config-backup

config checkout || {
  echo "Backing up pre-existing dotfiles to ~/.config-backup"
  config checkout 2>&1 | egrep "^\s+" | awk '{print $1}' | \
    xargs -I{} mv {} ~/.config-backup/ 2>/dev/null || true
  config checkout
}

config config --local status.showUntrackedFiles no

echo "Bare repo set up. Use: alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'"