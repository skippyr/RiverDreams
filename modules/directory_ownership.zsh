#!/usr/bin/env zsh

river_dreams::directory_ownership() {
  local -r user=$(whoami)
  local -r directory_owner=$(ls -ld | awk '{print $3}')
  local -r directory_ownership_symbol=$(
    test $(tput colors) -eq 8 &&
    echo "*" ||
    echo ""
  )

  if [[ ${user} != root && ${user} != ${directory_owner} ]]; then
    echo "%F{red} ${directory_ownership_symbol}%f"
  fi
}
