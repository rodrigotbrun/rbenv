# Install and update

Clone into `~/.brun` (required — `rbrc.sh` hard-codes that path):

```bash
git clone git@github.com:rodrigotbrun/rbenv.git ~/.brun
cd ~/.brun
bash ./install.sh
```

`install.sh` runs `install-macos.sh` on Darwin. Linux is not implemented yet.

## macOS installer

Steps are checkpointed in `~/.brun/.install-state`. Re-run `bash ./install.sh` after a failure to skip completed steps. File backups go to `~/.brun/.install-backups`.

Order:

1. Xcode Command Line Tools  
2. Homebrew  
3. Oh My Zsh  
4. Homebrew taps (`FelixKratz/formulae`, `borgbackup/tap`, `shopify/shopify`)  
5. `brew bundle` from `Brewfile`  
6. npm / Composer globals  
7. TPM + plugin install  
8. Xcode, iOS runtime  
9. macOS defaults  
10. Append `source ~/.brun/rbrc.sh` to `~/.zshrc`  
11. `stow.sh`  
12. Login items, Dock, Cursor agent, brew cleanup  
13. Verification (always runs, not checkpointed)

Full redo:

```bash
INSTALL_RESET=1 bash ./install.sh
```

## Dotfiles only

If packages are already installed:

```bash
# end of ~/.zshrc
source ~/.brun/rbrc.sh
```

```bash
cd ~/.brun
bash ./stow.sh
```

`stow.sh` links `tmux`, `zsh`, and `nvim` into `$HOME` and runs TPM `install_plugins`.

## Homebrew only

```bash
brew tap FelixKratz/formulae
brew trust FelixKratz/formulae
brew bundle --file=~/.brun/Brewfile
```

## Update

```bash
cd ~/.brun && git pull
bash ./stow.sh
```

Re-run `install.sh` if you need new Brewfile packages or installer steps. Completed checkpoints are skipped unless you reset.
