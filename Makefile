#!/usr/bin/env make
MAKEFILE_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

# Define the XDG base directory.
XDG_CONFIG_HOME := $(HOME)/.config
XDG_CACHE_HOME	:= $(HOME)/.cache
XDG_STATE_HOME	:= $(HOME)/.local/state
XDG_DATA_HOME	:= $(HOME)/.local/share

# Define the Homebrew installation configuration.
OS_TYPE = $(shell uname -s | tr 'A-Z' 'a-z')
OS_ARCH = $(shell uname -m | tr 'A-Z' 'a-z' | sed 's/x86_64/amd64/g')
# For linux
ifeq ($(PORTABLE)$(OS_TYPE),linux)
	HOMEBREW_REPOSITORY := /home/linuxbrew/.linuxbrew
	HOMEBREW_PREFIX     := /home/linuxbrew/.linuxbrew
	HOMEBREW_CELLAR     := $(HOMEBREW_REPOSITORY)/Cellar
	HOMEBREW            := $(HOMEBREW_REPOSITORY)/bin/brew
# For macOS [amd64]
else ifeq ($(PORTABLE)$(OS_TYPE)_$(OS_ARCH),darwin_amd64)
	HOMEBREW_REPOSITORY := /usr/local/Homebrew
	HOMEBREW_PREFIX     := /usr/local
	HOMEBREW_CELLAR     := $(HOMEBREW_REPOSITORY)/Cellar
	HOMEBREW            := $(HOMEBREW_REPOSITORY)/bin/brew
# For macOS [arm64]
else ifeq ($(PORTABLE)$(OS_TYPE)_$(OS_ARCH),darwin_arm64)
	HOMEBREW_REPOSITORY := /opt/homebrew
	HOMEBREW_PREFIX     := /opt/homebrew
	HOMEBREW_CELLAR     := $(HOMEBREW_REPOSITORY)/Cellar
	HOMEBREW            := $(HOMEBREW_REPOSITORY)/bin/brew
# For portable install
else
	HOMEBREW_REPOSITORY ?= $(XDG_DATA_HOME)/homebrew
	HOMEBREW_PREFIX     ?= $(XDG_DATA_HOME)/homebrew
	HOMEBREW_CELLAR     := $(HOMEBREW_REPOSITORY)/Cellar
	HOMEBREW            := $(HOMEBREW_REPOSITORY)/bin/brew
endif

# Define the list of files and directories to be installed by dotfiles.
define INSTALL
$(HOME)/.bash_profile
$(HOME)/.bashrc

$(abspath \
	$(patsubst $(MAKEFILE_DIR)/%, $(HOME)/%, \
		$(shell \find 2>/dev/null $(MAKEFILE_DIR)/.config -type f -print)))
endef

# Extra newline characters in multi-line strings defined using macro need to be removed.
TARGETS := $(strip $(INSTALL))
SOURCES := $(abspath $(shell git -C $(MAKEFILE_DIR) ls-files -oc --exclude-standard))

AQUA_ROOT_DIR = $(XDG_DATA_HOME)/aquaproj-aqua
AQUA = $(HOMEBREW_PREFIX)/bin/aqua

.PHONY: all setup clean link lint test

all: setup lint test link

setup: $(HOMEBREW)
	$(HOMEBREW) bundle --file $(MAKEFILE_DIR)/Brewfile --force
	$(AQUA) -v
	$(AQUA) update && $(AQUA) install

clean:
	rm -f $(TARGETS)

lint:

test:
	$(HOMEBREW_PREFIX)/bin/emacs -Q --batch --no-init-file --no-site-file --eval '(load-file "$(MAKEFILE_DIR)/.config/emacs/init.el")'
	$(HOMEBREW_PREFIX)/bin/nvim --headless -c 'quit' -u $(MAKEFILE_DIR)/.config/nvim/init.vim
	$(HOMEBREW_PREFIX)/bin/nvim --headless -c 'quit' -u $(MAKEFILE_DIR)/.config/nvim-vscode/init.vim

link: $(TARGETS)

$(HOMEBREW_REPOSITORY): SUDO ?= $(shell test -w $(HOMEBREW_REPOSITORY) || echo "sudo")
$(HOMEBREW_REPOSITORY):
	$(SUDO) /bin/bash -c "mkdir -p $@ && chown -R $(shell id -un):$(shell id -gn) $@"

$(HOMEBREW): | $(HOMEBREW_REPOSITORY)
	curl -sSL "https://github.com/Homebrew/brew/tarball/master" | tar xz --strip 1 -C "$(HOMEBREW_REPOSITORY)"

$(XDG_CONFIG_HOME)/homebrew/homebrew.bash: $(MAKEFILE_DIR)/.config/homebrew/homebrew.bash | $(HOMEBREW)
	mkdir -p $(@D)
	$(HOMEBREW) shellenv | cat $< - > $@

$(HOME)/% : $(MAKEFILE_DIR)/%
	mkdir -p $(@D)
	ln -snf $< $@
