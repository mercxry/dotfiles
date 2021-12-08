# dotfiles

I use [chezmoi](https://github.com/twpayne/chezmoi) to manage my dotfiles which allows me to store some private data inside my password manager by using [templates](https://github.com/twpayne/chezmoi/blob/master/docs/TEMPLATING.md), **I would recommend to just copy the bits and files that you're interested in**.

<p align="center">
  <img src="https://github.com/mercxry/dotfiles/blob/main/assets/neofetch-tokyo_night.png?raw=true" alt="iTerm with neofetch, Tokyo Night theme"/>
</p>

## Table of Contents

- [dotfiles](#dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Configuration](#configuration)
  - [Getting started](#getting-started)

## Configuration

- **OS:** macOS Monterey
- **Wallpaper:** [Students of War](https://cdnb.artstation.com/p/assets/images/images/025/563/925/large/stephen-zavala-rebel-camp-1-sz.jpg) by [Stephen Zavala](https://www.artstation.com/artwork/L2qQXA)
- **Terminal:** iTerm2
  - **Theme:** [Tokyo Night](https://github.com/mercxry/dotfiles/blob/main/private_Documents/iTerm2-Themes/tokyo-night.itermcolors)
  - **Font:** [Jetbrains Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf)
- **Terminal Multiplexer:** tmux
    - **Theme:** [Tokyo Night](https://github.com/mercxry/dotfiles/blob/main/dot_tmux.conf#L48-L61)
    - **Config:** [.tmux.conf](https://github.com/mercxry/dotfiles/blob/main/dot_tmux.conf)
- **Editors**
    1. **neovim**
        - **Theme:** [Tokyo Night](https://github.com/folke/tokyonight.nvim)
        - **Config:** [.config/nvim/](https://github.com/mercxry/dotfiles/tree/main/dot_config/nvim)
    2. **Visual Studio Code**
        - **Theme:** [Tokyo Night](https://marketplace.visualstudio.com/items?itemName=enkia.tokyo-night)
        - **Font:** [Jetbrains Mono](https://www.jetbrains.com/lp/mono/)

## Getting started

1. Clone repository

    ```sh
    chezmoi init mercxry
    ```

2. Install [Homebrew](https://brew.sh)

    ```sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

3. Install packages from Brewfile

    ```sh
    brew bundle install
    ```

    or just install chezmoi

    ```sh
    brew install chezmoi
    ```

4. Apply chezmoi dotfiles

    ```sh
    chezmoi apply
    ```
