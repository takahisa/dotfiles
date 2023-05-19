.PHONY: all setup clean install test lint
LOGLEVEL_INFO  := "\033[36m%s\033[m\n"
LOGLEVEL_WARN  := "\033[33m%s\033[m\n"
LOGLEVEL_FATAL := "\033[31m%s\033[m\n"

HOMEBREW_PREFIX ?= $(HOME)/.homebrew
HOMEBREW := $(HOMEBREW_PREFIX)/bin/brew

setup:
	@printf $(LOGLEVEL_INFO) "stage0: Install homebrew"
	@mkdir -p "$(HOMEBREW_PREFIX)"
	@curl -sSL "https://github.com/Homebrew/brew/tarball/master" | tar xz --strip 1 -C "$(HOMEBREW_PREFIX)"
	$(HOMEBREW) -v
	$(HOMEBREW) update && $(HOMEBREW) upgrade

	@printf $(LOGLEVEL_INFO) "stage1: Install homebrew formulae"
	$(HOMEBREW) bundle
