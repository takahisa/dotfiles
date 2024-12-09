#!/bin/bash
# shellcheck disable=SC1090
# shellcheck disable=SC1091
export ASDF_ROOT_DIR="${ASDF_ROOT_DIR:-${HOMEBREW_PREFIX}/opt/asdf}"

if [[ -r "${ASDF_ROOT_DIR}/libexec/asdf.sh" ]]; then
  source "${ASDF_ROOT_DIR}/libexec/asdf.sh"
fi

if [[ -r "${ASDF_ROOT_DIR}/etc/bash_completion.d/asdf.bash" ]]; then
  source "${ASDF_ROOT_DIR}/etc/bash_completion.d/asdf.bash"
fi
