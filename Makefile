#!/usr/bin/make -f
MAKEFILE_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
MAKEFILE := $(MAKEFILE_LIST)

XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_CACHE_HOME  ?= $(HOME)/.cache
XDG_STATE_HOME  ?= $(HOME)/.local/state
XDG_DATA_HOME   ?= $(HOME)/.local/share

HOMEBREW_PREFIX ?= /opt/homebrew
HOMEBREW = $(HOMEBREW_PREFIX)/bin/brew

CACHE_FILES = $(shell git -C $(MAKEFILE_DIR) ls-files -c)
OTHER_FILES = $(shell git -C $(MAKEFILE_DIR) ls-files -o --exclude-standard)
TARGETS = $(shell git -C $(MAKEFILE_DIR) check-attr export-ignore $(CACHE_FILES) $(OTHER_FILES) | grep -v 'export-ignore: set' | cut -d: -f1)

INSTALL_PREFIX ?= $(HOME)
INSTALL = $(abspath $(addprefix $(INSTALL_PREFIX)/, $(TARGETS)))

.SECONDEXPANSON:
.PHONY: all setup clean archive install link

all: setup install

setup: $(HOMEBREW) $(MAKEFILE_DIR)/Brewfile.lock.json $(MAKEFILE_DIR)/Brewfile

clean:
	@printf "%s\n" $(INSTALL) dotfiles.tar.gz | xargs -I{} -tr rm -f {}

install:
	@git -C $(MAKEFILE_DIR) archive --format=tar.gz --worktree-attributes HEAD | tar -C $(INSTALL_PREFIX) -zxvf -

archive:
	@git -C $(MAKEFILE_DIR) archive --format=tar.gz -o dotfiles.tar.gz --worktree-attributes HEAD && tar -tzf dotfiles.tar.gz

link: $(INSTALL)

$(HOMEBREW_PREFIX):
	mkdir -p $@

$(HOMEBREW): | $(HOMEBREW_PREFIX)
	curl -sSL "https://github.com/Homebrew/brew/tarball/master" | tar xz --strip 1 -C $(HOMEBREW_PREFIX)

$(MAKEFILE_DIR)/Brewfile.lock.json: $(MAKEFILE_DIR)/Brewfile | $(HOMEBREW)
	$(HOMEBREW) bundle --file $<

$(MAKEFILE_DIR)/Brewfile:
	$(HOMEBREW) bundle dump

$(MAKEFILE):
	git -C $(MAKEFILE_DIR) rev-parse --is-inside-work-tree || git -C $(MAKEFILE) clone --depth=1 https://github.com/takahisa/dotfiles

$(INSTALL): $(INSTALL_PREFIX)/% : $(MAKEFILE_DIR)/%
	@mkdir -p $(@D) && ln -snf $< $@ && echo $@
