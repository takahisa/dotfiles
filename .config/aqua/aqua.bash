#!/bin/bash
export AQUA_ROOT_DIR="${AQUA_ROOT_DIR:-${XDG_DATA_HOME}/aquaproj-aqua}"
export AQUA_LOG_COLOR="always"
export AQUA_LOG_LEVEL="info"

export PATH="${AQUA_ROOT_DIR}/bin${PATH+:$PATH}"
