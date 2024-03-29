.PHONY: all setup clean install test lint
LOGLEVEL_INFO  := "\033[36m%s\033[m\n"
LOGLEVEL_WARN  := "\033[33m%s\033[m\n"
LOGLEVEL_FATAL := "\033[31m%s\033[m\n"
MAKE := make -e --no-print-directory

HOMEBREW_PREFIX ?= $(HOME)/.homebrew
HOMEBREW := $(HOMEBREW_PREFIX)/bin/brew

SOURCE_DIRECTORY := $(abspath .)
TARGET_DIRECTORY := $(abspath $(HOME))

SOURCES := $(abspath $(shell find . -mindepth 1 -type f -path './.*' \
     -not -path './.git*'                   \
     -not -path './.git*/*'                 \
))
TARGETS := $(abspath $(patsubst $(SOURCE_DIRECTORY)/%, $(TARGET_DIRECTORY)/%, $(SOURCES)))


$(TARGET_DIRECTORY)/% : $(SOURCE_DIRECTORY)/%
	@mkdir -p $(dir $@)
	ln -snf $< $@

setup:
	@printf $(LOGLEVEL_INFO) "stage0: Install homebrew"
	@mkdir -p "$(HOMEBREW_PREFIX)"
	@curl -sSL "https://github.com/Homebrew/brew/tarball/master" | tar xz --strip 1 -C "$(HOMEBREW_PREFIX)"
	$(HOMEBREW) -v
	$(HOMEBREW) update && $(HOMEBREW) upgrade

	@printf $(LOGLEVEL_INFO) "stage1: Install homebrew formulae"
	$(HOMEBREW) bundle --no-lock --file "Brewfile"
	$(HOMEBREW) bundle --no-lock --file "Caskfile"

	@printf $(LOGLEVEL_INFO) "stage2: Install dotfiles"
	@$(MAKE) install

clean:
	rm -f $(TARGETS)

install: $(TARGETS)
