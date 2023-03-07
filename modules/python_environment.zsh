#!/usr/bin/env zsh

river_dreams::python_environment() {
  local -r python_environment=$(
    echo ${VIRTUAL_ENV} |
    rev |
    cut -f 1 -d / |
    rev
  )
  
  if [[ -n ${python_environment} ]]; then
    echo "%F{red}󰚐 %f${python_environment}"
  fi
}
