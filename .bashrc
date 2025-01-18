#!/bin/bash
# shellcheck disable=SC1090
# shellcheck disable=SC1091
# shellcheck disable=SC2139
# shellcheck disable=SC2262
# shellcheck disable=SC2263
export HISTSIZE="10000"
export HISTFILE="${XDG_STATE_HOME}/history"
export HISTFILESIZE="50000"
export HISTCONTROL="erasedups"
export HISTIGNORE="ls:ll:la:pwd:exit:clear:history:h:c:r:q"

shopt -s no_empty_cmd_completion
shopt -s nullglob
shopt -s extglob
shopt -s dotglob
shopt -s histappend
shopt -s histreedit
shopt -s histverify
shopt -s checkwinsize

# Use eza instead of ls
if type eza >/dev/null 2>&1; then
  alias ls='LC_COLLATE=C eza --color=auto --group-directories-first'
elif ls --group-directories-first >/dev/null 2>&1; then
  alias ls='LC_COLLATE=C ls --color=auto --group-directories-first'
else
  alias ls='LC_COLLATE=C ls --color=auto'
fi

# Use bat instead of cat
if type bat >/dev/null 2>&1; then
  alias bat="bat --color=always --theme Dracula"
  alias cat="bat -p"
fi

alias tree='tree -C'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias la='ls -a'
alias ll='ls -alHF'

alias ..='cd ..'

alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'

alias h='history'
alias c='clear'
alias r='exec ${SHELL} -l'
alias q='exit'

alias fd='fd --hidden --follow --exclude .git'
alias rg='rg --hidden --follow --glob "!.git"'

# Use neovim or neovim-remote instead of vim
if type nvim >/dev/null 2>&1; then
  if type nvr >/dev/null 2>&1; then
    alias vim='nvr -s'
  else
    alias vim='nvim'
  fi
fi

# Load fzf shellenv
if type fzf >/dev/null 2>&1; then
  eval "$(fzf --bash)"
fi

# Load zoxide shellenv
if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

# Load starship shellenv
if type starship >/dev/null 2>&1; then
  export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"
  export STARSHIP_CACHE="${XDG_CACHE_HOME}/starship/"
  eval "$(starship init bash)"
fi
