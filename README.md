# dotfiles

<p align="center">
  <img src="https://github.com/mercxry/dotfiles/blob/main/neofetch.png?raw=true" alt="Neofetch"/>
</p>

I use [chezmoi](https://github.com/twpayne/chezmoi) to manage my dotfiles which allows me to store some private data inside my password manager by using [templates](https://github.com/twpayne/chezmoi/blob/master/docs/TEMPLATING.md), **I would recommend to just copy the bits and files that you're interested in**.

## Table of Contents

- [dotfiles](#dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Getting started on a new machine](#getting-started-on-a-new-machine)

## Getting started on a new machine

1. Clone repository

    ```sh
    git clone git@github.com:mercxry/dotfiles.git && cd dotfiles
    ```

2. Install [Homebrew](https://brew.sh)

    ```sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

3. Install packages from Brewfile

    ```sh
    brew bundle install
    ```

4. Login to 1Password CLI

    ```sh
    op signin my.1password.com <EMAIL>
    ```

5. Apply chezmoi dotfiles

    ```sh
    chezmoi apply
    ```
