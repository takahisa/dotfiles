#!/bin/bash

# https://support.apple.com/en-us/HT208050
export BASH_SILENCE_DEPRECATION_WARNING="1"

# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"

# Add ~/bin and ~/.local/bin to PATH
export PATH="${HOME}/.local/bin:${HOME}/bin:${PATH}"
