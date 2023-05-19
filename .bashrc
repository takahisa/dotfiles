#!/bin/bash
# shellcheck disable=SC1090
# shellcheck disable=SC1091

# fzf settings
export FZF_DEFAULT_COMMAND='rg --hidden --no-heading --no-ignore -g '!.git' --files --sort path'
export FZF_DEFAULT_OPTS='-0 -1 --ansi --height 40% --reverse --border'
export FZF_CTRL_T_OPTS="--bind 'ctrl-T:toggle-preview' --preview-window down:10:hidden:wrap --preview 'head -n10 {}'"
export FZF_CTRL_R_OPTS="--bind 'ctrl-T:toggle-preview' --preview-window down:10:hidden:wrap --preview 'echo {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

for f in "${HOME}/fzf.bash" "${XDG_CONFIG_HOME}/fzf/fzf.bash"; do
    if [[ -r "${f}" ]]; then
	if [[ $- == *i* ]]; then
	    source "${f}"
	else
	    source "${f}" >/dev/null 2>&1
	fi
    fi
done
unset f


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
