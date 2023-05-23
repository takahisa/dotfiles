[@takahisa/dotfiles](http://github.com/takahisa/dotfiles/)
====

*dotfiles* is a repository that centrally manages the [@takahisa](https://github.com/takahisa)'s configuration files and their setup.


## Prerequisites
*dotfiles* supports GNU/Linux on `amd64` architecture and macOS on `amd64` or `arm64` (`aarch64`) architecture.
Windows is not directly supported, but will work with a supported Linux system running on WSL2.

Due to linuxbrew limitations, we do not support Linux on the `arm64` architecture.

### Linux
We have tested it on Ubuntu 20.04 and 22.04.

If you use Ubuntu, please run the following commands to install build tools.

```bash
sudo apt-get update
sudo apt-get install -y --no-install-recommends build-essential procps curl wget make file git tar
```

If you use CentOS, please run the following commands to install build tools.

```bash
sudo yum update
sudo yum groupinstall 'Development Tools'
sudo yum install procps-ng curl wget make file git tar
```

### macOS

We have tested it on macOS 12 (Monterey) on Apple M1 Pro edition.

### Windows

It will work with a supported Linux system running on WSL2.


## Installation

1. See [Prerequisites](#prerequisites) section.
1. Clone the repository:

    ```bash
    git clone --depth=1 https://github.com/takahisa/dotfiles.git dotfiles
    ```
1. Change to the cloned directory:

    ```bash
    cd dotfiles
    ```

1. Install dotfiles and dependencies

    ```bash
    make setup
    ```

## Customize

*dotfiles* provides several customization points to introduce your configurations.
If you place the configuration files in the following path(s), it will be automatically loaded from dotfiles.

| Item     | Path                                    | Description                                     |
| -------- | --------------------------------------- | ----------------------------------------------- |
| Bash     | `${XDG_CONFIG_HOME}/profile`            | Place additional `.bash_profile` to be loaded.  |
| Bash     | `${XDG_CONFIG_HOME}/aliases`            | Place additional `.bash_aliases` to be loaded.  |
| Bash     | `${XDG_CONFIG_HOME}/init`               | Place additional `.bashrc` to be loaded.        |
| Git      | `${XDG_CONFIG_HOME}/git/config.private` | Place additional `.gitconfig`.                  |
| Git      | `${XDG_CONFIG_HOME}/git/config.private` | Place additional `.gitignore`.                  |

## License

This project is licensed under the [MIT License](https://raw.githubusercontent.com/takahisa/dotfiles/master/LICENSE).
