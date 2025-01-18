Getting Started
====

## Supported Platforms

This dotfiles configurations supports the following platforms and architectures:

### macOS

- [Must meet Homebrew requirements for macOS](https://docs.brew.sh/Installation#macos-requirements)

> [!NOTE]
> Functionality depends on Homebrew compatibility with your system.
> Please ensure your system meets the minimum requirements for Homebrew installation before proceeding.

### Linux

- [Must meet Homebrew requirements for Linux](https://docs.brew.sh/Homebrew-on-Linux#requirements).

> [!NOTE]
> Functionality depends on Homebrew compatibility with your system.
> Please ensure your system meets the minimum requirements for Homebrew installation before proceeding.

## Prerequisites

- Bash as your login shell
  - **This dotfiles configuration only supports bash.**
  - Other shells (zsh, fish, etc.) are not supported.  
- GNU Make 4.3 or later
  - Please use GNU Make. BSD Make may exhibit unintended behavior, **unsupported**.

## Installation

To install the dotfiles, run the following command:

```sh
git clone --depth=1 https://github.com/takahisa/dotfiles && make -C $_
```

> [!WARNING]
> This installation will overwrite any existing configuration files in your home directory.
> Please backup your existing configuration files before proceeding.

The installation process will automatically:

1. Clone the dotfiles repository into your current directory
1. Execute the setup procedures defined in the Makefile, which includes:
   - Installing Homebrew.
   - Installing Homebrew formulae and casks.
   - Deploying configuration files by creating symbolic links.


> [!NOTE]
> The installation process may require sudo privileges, particularly during the Homebrew installation step.
> You may be prompted for your password during the installation.


After the installation is complete, you'll need to reload your shell for all changes to take effect:

```sh
exec ${SHELL} -l
```

## Advanced Configurations

### Custom Homebrew Installation

You can customize the Homebrew installation location by using the `PORTABLE` and `HOMEBREW_REPOSITORY` make variables:

```sh
make PORTABLE=1 HOMEBREW_REPOSITORY=~/.homebrew setup
```

This command will:

- Enable portable mode with `PORTABLE=1`
- Install Homebrew to a custom location specified by `HOMEBREW_REPOSITORY`.
    - Use the specified path instead of the default system-wide installation path.


This is a custom configuration that can be conveniently used when using on a system where you do not have sudo privileges or when you do not want to affect the entire system.

> [!IMPORTANT]
> When installing Homebrew in a non-standard location, most binary packages (bottles) will not be available. This means:
>
> - Packages will need to be built from source
> - Installation times will be significantly longer
> - More system resources will be required for package installation
> - Some packages might require additional dependencies for compilation
>
> Consider this limitation carefully before choosing a custom installation path. If possible, using the standard Homebrew installation path is recommended for the best experience.
