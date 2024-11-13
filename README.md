# dotfiles

<p align="center">
  <img src="https://github.com/mercxry/dotfiles/blob/main/assets/full_setup.png?raw=true" alt="Showoff image of a full size setup"/>
</p>

## Table of Contents

- [dotfiles](#dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Configuration](#configuration)
  - [Getting started](#getting-started)

## Configuration

- **OS:** macOS
- **Terminal:** Ghostty
  - **Theme:** Kanagawabones
  - **Font:** JetBrains Mono
- **Terminal Multiplexer:** tmux (currently trying zellij)
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
