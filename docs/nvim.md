# Neovim

Stow maps `nvim/.config/nvim` to `~/.config/nvim`. Plugin manager is [lazy.nvim](https://github.com/folke/lazy.nvim).

Leader is **Space**.

Full keymap list: [`nvim/.config/nvim/KEYMAPS.md`](../nvim/.config/nvim/KEYMAPS.md). In the editor, `<leader>kk` searches configured maps.

## Layout

| Path | Role |
| --- | --- |
| `init.lua` | Entry |
| `lua/core/` | Options, keymaps, lazy bootstrap |
| `lua/plugins/` | Plugin specs |
| `lua/plugins/lsp/` | LSP, Mason, Laravel |
| `after/ftplugin/` | Filetype tweaks |

## Sessions

`auto-session` is enabled in Neovim. That is separate from tmux resurrect: tmux restores windows/panes; Neovim restores editor session state inside a pane when that plugin runs.
