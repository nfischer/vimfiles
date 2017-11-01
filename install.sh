#!/bin/bash

VIMPLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

link_if_missing() {
  local ORIGIN="$1"
  local DEST="$2"
  test -L "$DEST" || ln -s "$ORIGIN" "$DEST"
}

# Always start in the current directory
readonly BASE_DIR="$(dirname "$0")"
cd "$BASE_DIR"

# Create spelling directories, etc.
mkdir -p tmp/ spell/ undodir/

# Add the directory for neovim
NVIM_DIR="$HOME/.config/nvim"
mkdir -p "$(dirname "$NVIM_DIR")"
link_if_missing "$PWD" "$NVIM_DIR"

# Symlink vimrc into home directory
link_if_missing "$PWD/vimrc" "$HOME/.vimrc"

# Install vim-plug
if [ ! -f 'autoload/plug.vim' ]; then
  echo 'installing vim-plug'
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs $VIMPLUG_URL ||
    { echo 'curl failed'; exit 1; }
fi
