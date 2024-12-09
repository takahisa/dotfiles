dotfiles
====
[![.github/workflows/lint-and-test.yaml](https://github.com/takahisa/dotfiles/actions/workflows/lint-and-test.yaml/badge.svg)](https://github.com/takahisa/dotfiles/actions/workflows/lint-and-test.yaml)

## What's Inside

This dotfiles repository includes configurations for:

- bash (login shell)
- git
- ssh
- emacs
- neovim
- alacritty

It uses [dracula theme](https://draculatheme.com/) across all software for a unified dark mode experience.

## Installation

> [!WARNING]
> This installation will overwrite any existing configuration files in your home directory.
> Please backup your existing configuration files before proceeding.

1. Clone this repository:

```sh
mkdir -p ~/workspace
git clone https://github.com/takahisa/dotfiles ~/workspace/dotfiles
```

2. Run the installation:

```sh
make -C ~/workspace/dotfiles all
```

The installation process will:

- Install Homebrew
- Install Homebrew formulae defined in [Brewfile](https://github.com/takahisa/dotfiles/blob/main/Brewfile)
- Deploy all configuration files to their appropriate installation paths under the home directory.

See [INSTALL.md](https://github.com/takahisa/dotfiles/blob/main/INSTALL.md) for more details.


## License

[MIT License](https://github.com/takahisa/dotfiles/blob/main/LICENSE.md)
