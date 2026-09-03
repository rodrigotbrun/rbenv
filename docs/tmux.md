# tmux

Config lives in `tmux/.tmux.conf` and is stowed to `~/.tmux.conf`. Plugins are managed by [TPM](https://github.com/tmux-plugins/tpm) under `~/.tmux/plugins`.

Prefix is the tmux default: **Ctrl-b**.

## Plugins

| Plugin | Purpose |
| --- | --- |
| `tmux-plugins/tpm` | Plugin manager |
| `tmux-plugins/tmux-resurrect` | Save / restore sessions, windows, and panes |
| `tmux-plugins/tmux-continuum` | Auto-save every 15 minutes; restore when the tmux **server** starts |
| `loichyan/tmux-toggle-popup` | Scratch popup |
| `tassaron/tmux-df` | Disk-free status helper |
| `akohlbecker/aw-watcher-tmux` | ActivityWatch |

`stow.sh` and the macOS installer clone TPM (if needed) and run `install_plugins`. The conf also clones TPM on first tmux start if the directory is missing.

Install or update plugins inside tmux: **prefix + I**.

## Resurrect and Continuum

Automatic restore is on (`@continuum-restore 'on'`). Continuum saves via a script injected into `status-right`. Status-bar options in `.tmux.conf` must stay **above** `run '~/.tmux/plugins/tpm/tpm'`; setting `status-right` after TPM wipes the save hook.

The right status shows `#{continuum_status}` (save interval in minutes when auto-save is on).

| Action | How |
| --- | --- |
| Manual save | prefix + **Ctrl-s** |
| Manual restore | prefix + **Ctrl-r** |
| Auto-save | every 15 minutes while the server is running |
| Auto-restore | when the tmux server starts (not when you attach to an existing server) |

Snapshots: `~/.local/share/tmux/resurrect/` (`last` points at the newest file).

Disable auto-restore for one boot: `touch ~/tmux_no_auto_restore`.

`rbrc.sh` defines `dmux`, which attaches to (or creates) a session named `dev`. Continuum restore still only runs on a **new** tmux server.

## Other bindings

| Key | Action |
| --- | --- |
| prefix + `r` | Reload `~/.tmux.conf` |
| prefix + `"` / `%` | Split, inheriting the current pane path |
| prefix + `H` / `V` | Even horizontal / vertical layout |
| prefix + **Ctrl-a** | Toggle 95% scratch popup |
| Mouse | Enabled |
