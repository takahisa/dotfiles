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

alias tree='tree -C'
alias diff='diff --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ..='cd ..'
alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias mosh='mosh --server "${SHELL} -lc mosh-server"'

alias r='exec ${SHELL} -l'

# Use neovim (neovim-remote) instead of vim
if type nvr >/dev/null 2>&1 && type nvim >/dev/null 2>&1; then
  alias vim='nvr -s'
fi

# Load user-defined .bash_aliases from XDG base directory
if [[ -r  "${XDG_CONFIG_HOME}/bash/aliases" ]]; then
  if [[ $- == *i* ]]; then
    source "${XDG_CONFIG_HOME}/bash/aliases"
  else
    source "${XDG_CONFIG_HOME}/bash/aliases" >/dev/null 2>&1
  fi
fi
