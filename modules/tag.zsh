#!/usr/bin/env bash

river_dreams::tag() {
  local -r tag=$(git tag 2>/dev/null | tail -n 1)
  local -r tag_symbol=$(
    test ${RIVER_DREAMS_FALLBACK_TEXT} == true &&
    echo "TAG" ||
    echo ""
  )
  if [[ -n ${tag} ]]; then
    echo "%F{red}${tag_symbol} %f${tag}"
  fi
}

