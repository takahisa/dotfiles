#!/bin/bash
# shellcheck disable=SC1090
# shellcheck disable=SC1091
# shellcheck disable=SC2139

# https://support.apple.com/en-us/HT208050
export BASH_SILENCE_DEPRECATION_WARNING="1"

# Set XDG base directory
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_DATA_HOME="${HOME}/.local/share"

# Add ~/bin and ~/.local/bin to PATH
export PATH="${HOME}/.local/bin:${HOME}/bin${PATH+:$PATH}"

# Set homebrew shellenv
if [[ -r "${XDG_CONFIG_HOME}/homebrew/homebrew.bash" ]]; then
  source "${XDG_CONFIG_HOME}/homebrew/homebrew.bash"

  # Add libexec/gnubin to PATH 
  for GNUBIN_PATH in "${HOMEBREW_PREFIX}"/opt/*/libexec/gnubin; do
    export PATH="${GNUBIN_PATH}:${PATH}"
  done

  # Add libexec/gnuman to MANPATH
  for GNUMAN_PATH in "${HOMEBREW_PREFIX}"/opt/*/libexec/gnuman; do
    export MANPATH="${GNUMAN_PATH}:${MANPATH}"
  done
fi

# Set aqua shellenv
if [[ -r "${XDG_CONFIG_HOME}/aqua/aqua.bash" ]]; then
  source "${XDG_CONFIG_HOME}/aqua/aqua.bash"
fi

# Set asdf shellenv
if [[ -r "${XDG_CONFIG_HOME}/asdf/asdf.bash" ]]; then
  source "${XDG_CONFIG_HOME}/asdf/asdf.bash"
fi

# Load ~/.bashrc
if [[ -r "${HOME}/.bashrc" ]]; then
  source "${HOME}/.bashrc"
fi
