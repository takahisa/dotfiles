#!/bin/bash
# shellcheck disable=SC1090
# shellcheck disable=SC1091

# Load user-defined .bashrc from XDG base directory
if [[ -r "${XDG_CONFIG_HOME}/bash/init" ]]; then
    if [[ $- == *i* ]]; then
	source "${XDG_CONFIG_HOME}/bash/init"
    else
	source "${XDG_CONFIG_HOME}/bash/init" >/dev/null 2>&1
    fi
fi

# Load ~/.bash_aliases
if [[ -r "${HOME}/.bash_aliases" ]]; then
    if [[ $- == *i* ]]; then
	source "${HOME}/.bash_aliases"
    else
	source "${HOME}/.bash_aliases" >/dev/null 2>&1
    fi
fi
