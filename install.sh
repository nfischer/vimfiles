#!/bin/bash

# Install & update all bundled vim plugins asynchronously

readonly BASE_DIR="$(dirname "$0")"
cd "$BASE_DIR"

# First, make sure we have the .vim/tmp & .vim/spell folders
mkdir -p tmp/ spell/

# Install vim-plug
if [ ! -f 'autoload/plug.vim' ]; then
  echo 'installing vim-plug'
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

BUNDLE_PATH="$BASE_DIR/plugged"

declare -a pids
declare -a plugins

IFS='
'
dirList=$(grep '^ *Plug' vimrc | grep -v "'pinned' *: *1" | sed "s/.*Plug\(in\)\? *'[^/]\+\/\([^']\+\)'.*/\2/")
# Launch everything asynchronously
cd "$BUNDLE_PATH"
for dir in ${dirList[@]}; do
  if [[ -d "${dir}" ]]; then
    plugin="${dir##${BUNDLE_PATH}/}"
    plugin="${plugin%/}"
    # echo "Downloading ${plugin}"
    (
      git -C "${dir}" pull &&
      git -C "${dir}" submodule update --init --recursive
    ) &>/dev/null &
    pids+=($!)
    plugins+=(${dir})
  fi
done

ret=0
# Wait for processes to finish
for k in "${!pids[@]}"; do
  plugin_path="${plugins[k]}"
  plugin="${plugin_path##${BUNDLE_PATH}/}"
  plugin="${plugin%/}"
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

