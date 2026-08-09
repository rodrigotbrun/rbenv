# Brun env

Personal dev environment: tools, aliases, functions, and dotfiles.

Focused on macOS for now. Linux installer is stubbed. Always a work in progress.

## Installing

Clone into `~/.brun` and run the installer:

```bash
git clone git@github.com:rodrigotbrun/rbenv.git ~/.brun
cd ~/.brun
bash ./install.sh
```

`install.sh` detects the OS and runs the matching script:

- macOS → `install-macos.sh`
- Linux → `install-linux.sh` (not implemented yet)

The macOS installer will:

- Install Homebrew packages and apps
- Append `source ~/.brun/rbrc.sh` to `~/.zshrc`
- Run `stow.sh` to symlink tmux, zsh, and nvim configs into your home

### Failed?

Run a full reset

```bash
INSTALL_RESET=1 bash ./install.sh
```

### Already installed?

If tools are already set up and you only need the shell config, append this to the end of `~/.zshrc`:

```bash
source ~/.brun/rbrc.sh
```

Then link dotfiles:

```bash
cd ~/.brun
bash ./stow.sh
```

### Brew packages only

If you only want Homebrew formulae/casks (no Xcode, Dock, shell wiring, etc.):

```bash
brew tap FelixKratz/formulae
brew trust FelixKratz/formulae
brew bundle --file=~/.brun/Brewfile
```

## Update env

1. Pull the latest changes: `cd ~/.brun && git pull`
2. Re-run stow if new/changed dotfiles appeared: `bash ./stow.sh`
