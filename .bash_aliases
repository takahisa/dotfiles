#!/bin/bash
# shellcheck disable=SC1090
# shellcheck disable=SC1091
# shellcheck disable=SC2139

if \ls "${HOME}" --group-directories-first >/dev/null 2>&1; then
    LS_COMMAND="LC_COLLATE=C ls --color=auto --group-directories-first"
else
    LS_COMMAND="LC_COLLATE=C ls --color=auto"
fi
alias ls="${LS_COMMAND}"
alias ll="${LS_COMMAND} -lhFH"
alias la="${LS_COMMAND} -lhFHa"

# Load user-defined .bash_aliases from XDG base directory
if [[ -r  "${XDG_CONFIG_HOME}/bash/aliases" ]]; then
    if [[ $- == *i* ]]; then
	source "${XDG_CONFIG_HOME}/bash/aliases"
    else
	source "${XDG_CONFIG_HOME}/bash/aliases" >/dev/null 2>&1
    fi
fi
