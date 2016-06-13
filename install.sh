#!/bin/bash

# Install & update all bundled vim plugins asynchronously

cd "$(dirname $0)"
BUNDLE_PATH="$(dirname $0)/bundle"

declare -a pids
declare -a plugins

dirList=$(grep '^ *Plugin' vimrc | grep -v "'pinned' *: *1" | sed "s/.*Plugin *'[^/]\+\/\([^']\+\)'.*/\1/")
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
for k in ${!pids[@]}; do
  plugin_path="${plugins[k]}"
  plugin="${plugin_path##${BUNDLE_PATH}/}"
  plugin="${plugin%/}"
  wait ${pids[k]}
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

