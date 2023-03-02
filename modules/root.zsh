#!/usr/bin/env zsh

river_dreams::root() {
  local -r user=$(whoami)
  if [[ ${user} == root ]]; then
    echo "%F{yellow}[%F{blue}󰠥%F{yellow}]%F{normal}"
  fi
}
