# Repo layout

Clone this repo to `~/.brun`. Shell config (`rbrc.sh`) always looks there, even if you run the installer from another path.

| Path | Role |
| --- | --- |
| `install.sh` | Detects OS and runs the platform installer |
| `install-macos.sh` | Full macOS bootstrap (Homebrew, Xcode, Dock, stow, …) |
| `install-linux.sh` | Linux installer (stub) |
| `Brewfile` | Homebrew formulae and casks |
| `stow.sh` | Symlinks `tmux`, `zsh`, and `nvim` into `$HOME`; installs TPM plugins |
| `rbrc.sh` | Sourced from `~/.zshrc`: PATH, aliases, functions, zplug, fzf, zoxide |
| `rbaliases.sh` | Shell aliases |
| `rbfunctions.sh` | Shell functions |
| `tmux/` | Stow package → `~/.tmux.conf` |
| `zsh/` | Stow package → `~/.zprofile`, `~/.zsh-plugins` |
| `nvim/` | Stow package → `~/.config/nvim` |
| `iterm2/` | iTerm2 profile export (not stowed automatically) |

GNU Stow maps package roots onto `$HOME`. A file at `tmux/.tmux.conf` becomes `~/.tmux.conf`.
