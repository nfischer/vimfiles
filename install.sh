#!/bin/bash

# Install & update all bundled vim plugins asynchronously

readonly BASE_DIR="$(dirname "$0")"
cd "$BASE_DIR"

# First, make sure we have the .vim subdirectories
mkdir -p tmp/ spell/ undodir/

# Link this directory to the neovim directory
NVIM_DIR="$HOME/.config/nvim"
mkdir -p "$(dirname "$NVIM_DIR")"
test -L "$NVIM_DIR" || ln -s "$PWD" "$NVIM_DIR"
echo "ln -s $NVIM_DIR $PWD"

# Install vim-plug
if [ ! -f 'autoload/plug.vim' ]; then
  echo 'installing vim-plug'
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ||
    { echo 'curl failed'; exit 1; }
fi

BUNDLE_PATH="$BASE_DIR/plugged"

declare -a pids
declare -a plugins
declare -a dirList

IFS='
'
readarray -t dirList <<<"$(grep '^ *Plug' vimrc |
  egrep -v "'(pinned|frozen)' *: *1" |
  sed "s/.*Plug\(in\)\? *'\([^/]\+\/[^']\+\)'.*/\2/")"
echo "Updating/installing ${#dirList[@]} plugins"

# Launch everything asynchronously
mkdir -p "$BUNDLE_PATH"
cd "$BUNDLE_PATH"
for plugin in "${dirList[@]}"; do
  dir="${plugin#*/}"
  if [[ ! -e "${dir}" ]]; then
    (
      git clone --recursive "https://github.com/${plugin}.git"
    ) &>/dev/null &
    pids+=($!)
  elif [[ -d "${dir}" ]]; then
    # echo "Downloading ${plugin}"
    (
      git -C "${dir}" pull &&
      git -C "${dir}" submodule update --init --recursive
    ) &>/dev/null &
    pids+=($!)
  fi
  plugins+=(${plugin})
done

ret=0
# Wait for processes to finish
for k in "${!pids[@]}"; do
  plugin="${plugins[k]}"
  wait "${pids[k]}"
  rval=$?
  if [[ $rval -eq 0 ]]; then
    echo "Success: installed ${plugin}"
  else
    echo -en "\033[1;31m"
    echo "Error installing ${plugin}" >&2
    echo -en "\033[0m"
    ret=$rval
  fi
done

echo "Your plugins have been installed"
exit ${ret}

