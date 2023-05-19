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

# Load portable homebrew
HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-${HOME}/.homebrew}"
HOMEBREW="${HOMEBREW_PREFIX}/bin/brew"
if [[ -x "${HOMEBREW}" ]]; then
    export HOMEBREW_PREFIX
    export HOMEBREW
    eval "$("${HOMEBREW}" shellenv)"

    for GNUBIN_PATH in "${HOMEBREW_PREFIX}"/opt/*/libexec/gnubin; do
	export PATH="${GNUBIN_PATH}:${PATH}"
    done
    for GNUMAN_PATH in "${HOMEBREW_PREFIX}"/opt/*/libexec/gnuman; do
	export MANPATH="${GNUMAN_PATH}:${MANPATH}"
    done
else
    unset HOMEBREW_PREFIX
    unset HOMEBREW
fi

# Load direnv shellenv
if type "direnv" >/dev/null 2>&1; then
    eval "$(direnv hook "${SHELL}")"
fi
