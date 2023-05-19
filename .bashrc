#!/bin/bash
# shellcheck disable=SC1090
# shellcheck disable=SC1091

# Load ~/.bash_aliases
if [[ -r "${HOME}/.bash_aliases" ]]; then
    if [[ $- == *i* ]]; then
	source "${HOME}/.bash_aliases"
    else
	source "${HOME}/.bash_aliases" >/dev/null 2>&1
    fi
fi
