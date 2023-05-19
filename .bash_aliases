#!/bin/bash
# shellcheck disable=SC1090
# shellcheck disable=SC1091
# shellcheck disable=SC2139

# Load user-defined .bash_aliases from XDG base directory
if [[ -r  "${XDG_CONFIG_HOME}/bash/aliases" ]]; then
    if [[ $- == *i* ]]; then
	source "${XDG_CONFIG_HOME}/bash/aliases"
    else
	source "${XDG_CONFIG_HOME}/bash/aliases" >/dev/null 2>&1
    fi
fi
