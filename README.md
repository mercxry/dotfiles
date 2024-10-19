# dotfiles

<p align="center">
  <img src="https://github.com/mercxry/dotfiles/blob/main/assets/neofetch.png?raw=true" alt="iTerm with neofetch"/>
</p>

## Table of Contents

- [dotfiles](#dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Configuration](#configuration)
  - [Getting started](#getting-started)

## Configuration

- **OS:** macOS 15 Sequoia
- **Terminal:** iTerm2
  - **Theme:** [Kanagawa](https://github.com/mercxry/dotfiles/blob/main/private_Documents/iTerm2-Themes/kanagawa.itermcolors)
  - **Font:** [Jetbrains Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono/Ligatures/Regular)
- **Terminal Multiplexer:** tmux
  - **Config:** [.tmux.conf](https://github.com/mercxry/dotfiles/blob/main/dot_tmux.conf)
- **Editor**
  - **neovim**
    - **Theme:** [Kanagawa](https://github.com/rebelot/kanagawa.nvim)
    - **Config:** [.config/nvim](https://github.com/mercxry/dotfiles/tree/main/dot_config/nvim)

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
