# dotfiles

I use [chezmoi](https://github.com/twpayne/chezmoi) to manage my dotfiles which allows me to store some private data inside my password manager by using [templates](https://github.com/twpayne/chezmoi/blob/master/docs/TEMPLATING.md), **I would recommend to just copy the bits and files that you're interested in**.

<p align="center">
  <img src="https://github.com/mercxry/dotfiles/blob/main/assets/neofetch.png?raw=true" alt="Neofetch"/>
</p>

## Table of Contents

- [dotfiles](#dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Configuration](#configuration)
  - [Getting started on a new machine](#getting-started-on-a-new-machine)

## Configuration

- **OS:** macOS Big Sur
- **Wallpaper:** [Students of War](https://cdnb.artstation.com/p/assets/images/images/025/563/925/large/stephen-zavala-rebel-camp-1-sz.jpg) by [Stephen Zavala](https://www.artstation.com/artwork/L2qQXA)
- **Terminal:** iTerm2
  - **Theme:** [Gruvbox Dark](https://github.com/mercxry/dotfiles/blob/main/private_Documents/iTerm2-Themes/Gruvbox%20Dark.itermcolors)
  - **Font:** [Jetbrains Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf)
- **Editors**
  - **Visual Studio Code**
    - **Theme:** [Gruvbox Material Dark](https://marketplace.visualstudio.com/items?itemName=sainnhe.gruvbox-material)
    - **Font:** [Jetbrains Mono](https://www.jetbrains.com/lp/mono/)
    - **Extensions:** Coming Soon
  - **Neovim**
    - Coming Soon

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
