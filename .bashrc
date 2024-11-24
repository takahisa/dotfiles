#!/bin/bash
# shellcheck disable=SC1090
# shellcheck disable=SC1091
# shellcheck disable=SC2139
export HISTSIZE="10000"
export HISTFILE="${XDG_CONFIG_STATE}/history"
export HISTFILESIZE="50000"
export HISTCONTROL="erasedups"

shopt -s no_empty_cmd_completion
shopt -s nullglob
shopt -s extglob
shopt -s extglob
shopt -s histappend
shopt -s histreedit
shopt -s histverify

if type eza >/dev/null 2>&1; then
  LS_COMMAND="LC_COLLATE=C eza --color=auto --group-directories-first"
elif type ls --group-directories-first >/dev/null 2>&1; then
  LS_COMMAND="LC_COLLATE=C ls --color=auto --group-directories-first"
else
  LS_COMMAND="LC_COLLATE=C ls --color=auto"
fi
alias ls="${LS_COMMAND}"
alias ll="${LS_COMMAND} -lhHF"
alias la="${LS_COMMAND} -lhHaF"

if type bat >/dev/null 2>&1; then
  alias bat="bat --theme Dracula"
  alias cat="bat -p"
fi

alias tree='tree -C'
alias diff='diff --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ..='cd ..'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias mosh='mosh --server "${SHELL} -lc mosh-server"'

alias r='exec ${SHELL} -l'

# Use neovim or neovim-remote instead of vim
if type nvim >/dev/null 2>&1; then
  if type nvr >/dev/null 2>&1; then
    alias vim='nvr -s'
  else
    alias vim='nvim'
  fi
fi

# Use starship
if type "starship" >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

# Use fzf
export FZF_DEFAULT_COMMAND='rg --hidden --no-heading --no-ignore -g '!.git' --files --sort path'
export FZF_DEFAULT_OPTS='-0 -1 --ansi --height 40% --reverse --border'
export FZF_CTRL_T_OPTS="--bind 'ctrl-T:toggle-preview' --preview-window down:10:hidden:wrap --preview 'head -n10 {}'"
export FZF_CTRL_R_OPTS="--bind 'ctrl-T:toggle-preview' --preview-window down:10:hidden:wrap --preview 'echo {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
