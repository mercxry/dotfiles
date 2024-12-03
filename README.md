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

- **Operating System:** macOS (Apple Silicon)
- **Terminal:** Ghostty
  - **Font:** JetBrains Mono
    - Nerd font patched
    - With ligatures
  - **Theme:** Kanagawa(bones)
  - **Shell:** Fish
    - **Prompt:** Starship
    - **History:** Atuin
  - **Editor:** Neovim
  - **Multiplexer:** Zellij

## Getting started

1. Install chezmoi

   ```sh
   brew install chezmoi
   ```

2. Clone repository

   ```sh
   chezmoi init mercxry
   ```

3. Apply chezmoi dotfiles

   ```sh
   chezmoi apply
   ```
