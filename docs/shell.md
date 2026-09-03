# Shell

`install-macos.sh` appends `source ~/.brun/rbrc.sh` to `~/.zshrc`. `rbrc.sh` sets PATH and tools, then sources aliases, functions, zplug, fzf, and zoxide.

## Environment

| Variable / path | Value |
| --- | --- |
| `RB_HOME` | `~/.brun` |
| `ZPLUG_HOME` | Homebrew zplug |
| `JAVA_HOME` | Zulu 17 |
| `ANDROID_HOME` | `~/Library/Android/sdk` |
| `TERM` | `xterm` |

Android emulator, platform-tools, cmdline-tools, and Homebrew `mysql-client` are added to `PATH`.

## `dmux`

If you are not already inside tmux, attach to session `dev` or create it.

## Aliases (`rbaliases.sh`)

| Alias | Command |
| --- | --- |
| `ll` | `ls -lah` |
| `t` / `tree` | `tree` (depth 3, hidden files, skip `.git`) |
| `dtree` | directories only |
| `vim` / `nano` | `nvim` |
| `a` | `php artisan` |
| `zi` / `zu` | zplug install / update |
| `gt` | `git` |
| `ga` | `git add .` |
| `gs` | `git status -s` |
| `gc` | `git commit -m` |
| `glog` | one-line graph log |
| `gp` | `git push` |
| `lg` | `lazygit` |
| `rb` | `ssh rb` |
| `rbdev` | `cd ~/.brun && nvim` |
| `znano` | edit `~/.zshrc` |
| `zsource` | `source ~/.zshrc` |
| `pest` | `./vendor/bin/pest` |

## Functions (`rbfunctions.sh`)

| Function | Usage |
| --- | --- |
| `towebp` | `towebp file.png [quality]` — ImageMagick WebP (default quality 77) |
| `convert_all_png_to_webp` | `convert_all_png_to_webp [dir]` — convert `*.png` in that folder |
| `csvdb` | `csvdb name file.csv` — import CSV into SQLite `name.db` and open it |

## zsh plugins (`zsh/.zsh-plugins`)

Loaded via zplug:

- Dracula theme
- `jessarcher/zsh-artisan`

Homebrew `zsh-autosuggestions` and `zsh-syntax-highlighting` are in the Brewfile; wire them from `~/.zshrc` if they are not already loaded by Oh My Zsh.
