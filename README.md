# 🏠 Agustin Lessa's Dotfiles

A clean and minimalist dotfiles configuration for macOS development environment, featuring terminal tools and productivity workflows.

## 📦 What's Included

This repository contains configurations for:

- **🖥️ Alacritty** - GPU-accelerated terminal emulator with Catppuccin Mocha theme
- **🐚 Zsh** - Shell configuration with Oh My Zsh, vi-mode, and custom keybindings
- **⚡ tmux** - Terminal multiplexer
- **📝 Git** - Enhanced Git configuration with modern diff algorithms and sensible defaults
- **🔐 SSH** - SSH client configuration for GitHub
- **🔧 Custom Scripts** - tmux-sessionizer for quick project navigation

## 🎨 Theme & Appearance

All configurations use the **Catppuccin Mocha** color scheme for a consistent dark theme across all tools

## 🚀 Quick Start

### Prerequisites

Install the required dependencies:

```bash
# macOS with Homebrew
brew install stow alacritty tmux fzf font-iosevka-nerd-font rbenv
```

### Installation

1. **Clone the repository:**
   ```bash
   git clone git@github.com:gstnlss/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Initialize and update submodules:**
   ```bash
   git submodule update --init --recursive
   ```

3. **Install configurations using GNU Stow:**
   ```bash
   make all
   ```

4. **Reload your shell:**
   ```bash
   source ~/.zshrc
   ```

### Uninstall

To remove all symlinks:
```bash
make delete
```

## 🔧 Configuration Details

### Alacritty Terminal
- **Font**: Iosevka Nerd Font Mono
- **Theme**: Catppuccin Mocha

### Zsh Shell
- **Framework**: Oh My Zsh with automatic installation
- **Theme**: robbyrussell
- **Plugins**: git, nvm, docker, docker-compose
- **Vi Mode**: Enabled with custom keybindings
- **Custom Keybindings**:
  - `Ctrl+P`: Launch tmux-sessionizer
  - `Ctrl+O`: Launch tmux-sessionizer in home directory

### tmux Configuration
- **Prefix**: `Ctrl+j` (instead of default `Ctrl+b`)
- **Theme**: Catppuccin Mocha
- **Features**:
  - Vi-mode for copy/paste
  - Fast key repetition (no escape delay)
  - Focus events enabled
  - RGB color support

### Git Configuration
- **Default Branch**: main
- **Diff Algorithm**: histogram with color-moved detection
- **Auto Features**: 
  - Auto-setup remote tracking
  - Auto-prune on fetch
  - Verbose commits
- **Merge**: zdiff3 conflict style

### tmux-sessionizer Script
A productivity script inspired by ThePrimeagen that:
- Searches for projects in `~/Code` directory
- Uses `fzf` for fuzzy project selection
- Creates or switches to tmux sessions based on project directories
- Handles tmux session management intelligently

## 📝 Notes

- Configurations are optimized for macOS development workflows
- Uses vi-mode keybindings throughout terminal applications
- Includes sensible defaults for Git workflows
- tmux-sessionizer expects projects in `~/Code` directory structure
