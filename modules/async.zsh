#!/usr/bin/env zsh

RIVER_DREAMS_RIGHT_PROMPT_ASYNC_READY_MODULES_QUANTITY=0
RIVER_DREAMS_TOP_PROMPT_ASYNC_READY_MODULES_QUANTITY=0
RIVER_DREAMS_ASYNC_GIT_READY=false

river_dreams::async::refresh_prompt() {
  zle reset-prompt
  zle -R
}

river_dreams::async::callback() {
  local -r function_name="$1"
  local -r output="$3"
  case ${function_name} in
    river_dreams::clock)
      RIVER_DREAMS_CLOCK=${output}
      ((RIVER_DREAMS_TOP_PROMPT_ASYNC_READY_MODULES_QUANTITY++))
      ;;
    river_dreams::local_ip_address)
      RIVER_DREAMS_LOCAL_IP_ADDRESS=${output}
      ((RIVER_DREAMS_TOP_PROMPT_ASYNC_READY_MODULES_QUANTITY++))
      ;;
    river_dreams::disk_usage)
      RIVER_DREAMS_DISK_USAGE=${output}
      ((RIVER_DREAMS_TOP_PROMPT_ASYNC_READY_MODULES_QUANTITY++))
      ;;
    river_dreams::storage_devices)
      RIVER_DREAMS_STORAGE_DEVICES=${output}
      ((RIVER_DREAMS_TOP_PROMPT_ASYNC_READY_MODULES_QUANTITY++))
      ;;
    river_dreams::docker_containers)
      RIVER_DREAMS_DOCKER_CONTAINERS=${output}
      ((RIVER_DREAMS_TOP_PROMPT_ASYNC_READY_MODULES_QUANTITY++))
      ;;
    river_dreams::git)
      RIVER_DREAMS_GIT=${output}
      RIVER_DREAMS_ASYNC_GIT_READY=true
      ;;
    river_dreams::hidden_files)
      RIVER_DREAMS_HIDDEN_FILES=${output}
      ((RIVER_DREAMS_RIGHT_PROMPT_ASYNC_READY_MODULES_QUANTITY++))
      ;;
    river_dreams::executable_files)
      RIVER_DREAMS_EXECUTABLE_FILES=${output}
      ((RIVER_DREAMS_RIGHT_PROMPT_ASYNC_READY_MODULES_QUANTITY++))
      ;;
    river_dreams::symbolic_links)
      RIVER_DREAMS_SYMBOLIC_LINKS=${output}
      ((RIVER_DREAMS_RIGHT_PROMPT_ASYNC_READY_MODULES_QUANTITY++))
      ;;
    river_dreams::ignored_files)
      RIVER_DREAMS_IGNORED_FILES=${output}
      ((RIVER_DREAMS_RIGHT_PROMPT_ASYNC_READY_MODULES_QUANTITY++))
      ;;
    river_dreams::elapsed_time)
      RIVER_DREAMS_ELAPSED_TIME=${output}
      ((RIVER_DREAMS_RIGHT_PROMPT_ASYNC_READY_MODULES_QUANTITY++))
      ;;
  esac
  RIVER_DREAMS_RIGHT_PROMPT=(
    $(river_dreams::jobs)
    ${RIVER_DREAMS_HIDDEN_FILES}
    ${RIVER_DREAMS_EXECUTABLE_FILES}
    ${RIVER_DREAMS_SYMBOLIC_LINKS}
    ${RIVER_DREAMS_IGNORED_FILES}
    ${RIVER_DREAMS_ELAPSED_TIME}
  )
  RIVER_DREAMS_TOP_PROMPT=(
    ${RIVER_DREAMS_CLOCK}
    ${RIVER_DREAMS_LOCAL_IP_ADDRESS}
    ${RIVER_DREAMS_DISK_USAGE}
    ${RIVER_DREAMS_STORAGE_DEVICES}
    ${RIVER_DREAMS_DOCKER_CONTAINERS}
    $(river_dreams::python_environment)
  )
  local -r right_prompt_async_modules_quantity=5
  local -r top_prompt_async_modules_quantity=5
  if [[ ${RIVER_DREAMS_RIGHT_PROMPT_ASYNC_READY_MODULES_QUANTITY} -eq ${right_prompt_async_modules_quantity} ]]; then
    RIVER_DREAMS_RIGHT_PROMPT_ASYNC_READY_MODULES_QUANTITY=0
    river_dreams::async::refresh_prompt
  elif [[ ${RIVER_DREAMS_ASYNC_GIT_READY} == true ]]; then
    RIVER_DREAMS_ASYNC_GIT_READY=false
    river_dreams::async::refresh_prompt
  elif [[ ${RIVER_DREAMS_TOP_PROMPT_ASYNC_READY_MODULES_QUANTITY} -eq ${top_prompt_async_modules_quantity} ]]; then
    RIVER_DREAMS_TOP_PROMPT_ASYNC_READY_MODULES_QUANTITY=0
    river_dreams::async::refresh_prompt
  fi
}

river_dreams::async::restart_worker() {
  local elapsed_time=$(history -D | tail -n 1 | awk '{print $2}')
  RIVER_DREAMS_GIT=""
  RIVER_DREAMS_RIGHT_PROMPT=""

  async_start_worker RIVER_DREAMS_ASYNC_WORKER -n
  async_flush_jobs RIVER_DREAMS_ASYNC_WORKER
  async_worker_eval RIVER_DREAMS_ASYNC_WORKER cd ${PWD}
  async_worker_eval RIVER_DREAMS_ASYNC_WORKER export RIVER_DREAMS_USE_FALLBACK_TEXT=${RIVER_DREAMS_USE_FALLBACK_TEXT}
  async_register_callback RIVER_DREAMS_ASYNC_WORKER river_dreams::async::callback

  # Top Prompt Components
  async_job RIVER_DREAMS_ASYNC_WORKER river_dreams::local_ip_address
  async_job RIVER_DREAMS_ASYNC_WORKER river_dreams::clock
  async_job RIVER_DREAMS_ASYNC_WORKER river_dreams::disk_usage
  async_job RIVER_DREAMS_ASYNC_WORKER river_dreams::storage_devices
  async_job RIVER_DREAMS_ASYNC_WORKER river_dreams::docker_containers

  # Left Prompt Components
  async_job RIVER_DREAMS_ASYNC_WORKER river_dreams::git

  # Right Prompt Components
  async_job RIVER_DREAMS_ASYNC_WORKER river_dreams::hidden_files
  async_job RIVER_DREAMS_ASYNC_WORKER river_dreams::executable_files
  async_job RIVER_DREAMS_ASYNC_WORKER river_dreams::symbolic_links
  async_job RIVER_DREAMS_ASYNC_WORKER river_dreams::ignored_files
  async_job RIVER_DREAMS_ASYNC_WORKER river_dreams::elapsed_time "${elapsed_time}"
}