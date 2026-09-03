# Neovim Keymaps

**Leader:** `Space`

Press `<leader>kk` in Neovim to search all configured keymaps live.

---

## Custom keymaps (from your config)

### Core (`lua/core/keymap.lua`)

Tabs, splits, pane focus, and resize mirror tmux defaults, with `<leader>` in place of prefix (`Ctrl-b`). Windows map to tabs; panes map to splits. Your extra tmux binds `H` / `V` are included.

| Key | Mode | Action |
| --- | --- | --- |
| `K` | Visual | Move selected lines up |
| `J` | Visual | Move selected lines down |
| `J` | Normal | Join line below (keep cursor position) |
| `<` / `>` | Visual | Indent selection (keep selection) |
| `<leader>p` | Visual | Paste without yanking deleted text |
| `<leader>L` | Normal | Format buffer (see also Formatting) |
| `Q` | Normal | Disabled |
| `<leader>X` | Normal | Make current file executable (`chmod +x`) |
| `<leader>s` | Normal | Search/replace word under cursor in file |
| `<leader>c` | Normal | New tab (tmux `c`) |
| `<leader>n` | Normal | Next tab (tmux `n`) |
| `<leader>p` | Normal | Previous tab (tmux `p`) |
| `<leader>&` | Normal | Close current tab (tmux `&`) |
| `<leader>%` | Normal | Split vertically (tmux `%`) |
| `<leader>"` | Normal | Split horizontally (tmux `"`) |
| `<leader>x` | Normal | Close current split (tmux `x`) |
| `<leader>H` | Normal | Even horizontal layout (tmux `H`) |
| `<leader>V` | Normal | Even vertical layout (tmux `V`) |
| `<leader>o` | Normal | Next split (tmux `o`) |
| `<leader>;` | Normal | Last split (tmux `;`) |
| `<leader>↑/↓/←/→` | Normal | Focus split (tmux arrows) |
| `<leader>Ctrl+↑/↓/←/→` | Normal | Resize split by 1 (tmux `C-arrow`) |
| `<leader>Alt+↑/↓/←/→` | Normal | Resize split by 5 (tmux `M-arrow`) |
| `<leader>fp` | Normal | Copy file path to clipboard |
| `<C-s>yn` | Normal | Spotify: next track |
| `<C-s>yb` | Normal | Spotify: previous track |
| `<C-s>pp` | Normal | Spotify: play/pause |
| `jj` / `jk` | Insert | Exit insert mode |
| `<C-w>%` | Normal/Visual/Insert | Vertical split |
| `<C-w>"` | Normal/Visual/Insert | Horizontal split |
| `<C-d>` / `<C-u>` / `<C-f>` / `<C-b>` | Normal | Scroll half-page/page (cursor centered) |
| `<C-w>,` | Normal | Previous buffer |
| `<C-w>.` | Normal | Next buffer |
| `<C-w>x` | Normal | Close buffer |

### LSP (`lua/plugins/lsp/lspconfig.lua`)

Active on buffers with an attached LSP client.

| Key | Mode | Action |
| --- | --- | --- |
| `gR` | Normal | LSP references (Telescope) |
| `<leader>gt` | Normal/Visual | Go to type definition |
| `<leader>ca` | Normal/Visual | Code actions |
| `K` | Normal | Hover documentation |
| `<leader>rs` | Normal | Restart LSP |
| `<C-h>` | Insert | Signature help |

### Completion — nvim-cmp (`lua/plugins/nvim-cmp.lua`)

Insert mode, when the completion menu is open unless noted.

| Key | Action |
| --- | --- |
| `<C-Space>` | Trigger completion |
| `<Tab>` | Next item / expand snippet / smart indent |
| `<S-Tab>` | Previous item / jump snippet back / dedent |
| `<CR>` / `<C-y>` | Confirm selection |
| `<C-e>` | Close completion menu |
| `<C-j>` / `<C-n>` / `<Down>` | Next item |
| `<C-k>` / `<C-p>` / `<Up>` | Previous item |
| `<C-f>` / `<C-b>` | Scroll documentation |
| `<C-d>` | Close documentation popup |

### Snacks (`lua/plugins/snacks.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>1` | Normal | File explorer |
| `<leader>P` | Normal | Find files |
| `<leader>F` | Normal | Live grep |
| `<leader>kk` | Normal | Search all keymaps |
| `<leader>rN` | Normal | Rename current file |
| `<leader>dB` | Normal | Delete/close buffer (confirm) |
| `<leader>lg` | Normal | LazyGit |
| `<leader>gl` | Normal | LazyGit logs |
| `<leader>gbr` | Normal | Git branch picker |
| `<leader>th` | Normal | Colorscheme picker |
| `<leader>vh` | Normal | Neovim help picker |
| `<C-t>` | Normal | Toggle terminal |

### Telescope (`lua/plugins/telescope.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>pr` | Normal | Recent files |
| `<leader>pWs` | Normal | Grep word under cursor |
| `<leader>ths` | Normal | Theme switcher |
| `<C-k>` / `<C-j>` | Insert (Telescope prompt) | Previous/next result |

### Flash (`lua/plugins/flash.nvim`)

| Key | Mode | Action |
| --- | --- | --- |
| `s` | Normal/Visual/Operator | Flash jump |
| `S` | Normal/Visual/Operator | Flash Treesitter |
| `r` | Operator | Remote Flash |
| `R` | Operator/Visual | Treesitter search |
| `<C-s>` | Command-line | Toggle Flash search |

### Git — Fugitive & Gitsigns (`lua/plugins/gitstuff.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>gg` | Normal | Open Fugitive `:Git` |
| `<leader>t` | Normal | In Fugitive buffer: `Git push -u origin ` |
| `]h` | Normal | Next hunk |
| `[h` | Normal | Previous hunk |
| `<leader>gs` | Normal/Visual | Stage hunk |
| `<leader>gr` | Normal/Visual | Reset hunk |
| `<leader>gS` | Normal | Stage buffer |
| `<leader>gR` | Normal | Reset buffer |
| `<leader>gu` | Normal | Undo stage hunk |
| `<leader>gp` | Normal | Preview hunk |
| `<leader>gbl` | Normal | Blame line (full) |
| `<leader>gB` | Normal | Toggle line blame |
| `<leader>gd` | Normal | Diff this |
| `<leader>gD` | Normal | Diff against `~` |
| `ih` | Operator/Visual | Gitsigns hunk text object |

### Git worktree (`lua/plugins/gitworktree.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>wl` | Normal | List git worktrees |
| `<leader>wc` | Normal | Create git worktree |

### Laravel (`lua/plugins/lsp/laravel.lua`)

Only loaded in Laravel projects (`artisan` + `vendor/autoload.php` present).

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>ll` | Normal | Laravel picker |
| `<leader>la` | Normal | Artisan picker |
| `<leader>lt` | Normal | Actions picker |
| `<leader>lr` | Normal | Routes picker |
| `<leader>lh` | Normal | Open Laravel docs |
| `<leader>lm` | Normal | Make picker |
| `<leader>lc` | Normal | Commands picker |
| `<leader>lo` | Normal | Resources picker |
| `<leader>lp` | Normal | Command center |
| `<C-g>` | Normal | View finder |
| `gf` | Normal | Go to Laravel resource (when on one) |

### Formatting & lint (`lua/plugins/formatting.lua`, `lua/plugins/lint.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>L` | Normal/Visual | Format file or selection (Conform) |
| `<leader>l` | Normal | Run linter on current file |

### Trouble (`lua/plugins/trouble.nvim`)

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>xw` | Normal | Workspace diagnostics |
| `<leader>xd` | Normal | Buffer diagnostics |
| `<leader>xq` | Normal | Quickfix list |
| `<leader>xl` | Normal | Location list |
| `<leader>xt` | Normal | Todo list |

### Todo comments (`lua/plugins/todo-comments.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `]t` | Normal | Next todo comment |
| `[t` | Normal | Previous todo comment |

### Treesitter (`lua/plugins/treesitter.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `<C-Space>` | Normal/Visual | Expand Treesitter selection |

### Mini (`lua/plugins/mini.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `sa` | Normal/Visual | Add surrounding |
| `sd` | Normal/Visual | Delete surrounding |
| `sf` / `sF` | Normal/Visual | Find surrounding (right/left) |
| `sh` | Normal/Visual | Highlight surrounding |
| `sr` | Normal/Visual | Replace surrounding |
| `sn` | Normal/Visual | Update `n_lines` |
| `<leader>cw` | Normal | Trim trailing whitespace |
| `sj` | Normal/Visual | Join function arguments |
| `sk` | Normal/Visual | Split function arguments |

### Sessions, undo, docker, images

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>wr` | Normal | Restore session for cwd |
| `<leader>ws` | Normal | Save session |
| `<leader>ww` | Normal | Search saved sessions |
| `<leader>u` | Normal | Toggle undotree |
| `<leader>ld` | Normal/Terminal | Toggle LazyDocker |
| `<leader>pi` | Normal | Paste image from clipboard |

### Folding — nvim-ufo (`lua/plugins/nvim-ufo.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `zR` | Normal | Open all folds |
| `zM` | Normal | Close all folds |

### Oil file explorer (`lua/plugins/oil.nvim`)

Active inside Oil buffers.

| Key | Action |
| --- | --- |
| `Alt+h` | Open selection in horizontal split |
| `q` | Close Oil |

### Markdown — buffer-local (`after/ftplugin/markdown.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `tn` | Normal/Visual | Toggle numbered list |
| `tb` | Normal/Visual | Toggle bullet list |
| `tc` | Normal/Visual | Toggle checkbox |
| `tt` | Normal/Visual | Toggle task state |
| `tl` | Normal/Visual | Smart list toggle |
| `<leader>tc` | Normal | Mark all tasks done |
| `<leader>tu` | Normal | Mark all tasks undone |

---

## Popular Neovim / Vim shortcuts

Built-in defaults and widely used conventions not overridden in your config.

### Modes & essentials

| Key | Action |
| --- | --- |
| `i` / `a` / `o` | Enter insert mode (before / after / new line) |
| `I` / `A` / `O` | Insert at line start / end / above line |
| `v` / `V` / `<C-v>` | Visual character / line / block |
| `Esc` / `<C-[>` | Return to normal mode |
| `u` | Undo |
| `<C-r>` | Redo |
| `.` | Repeat last change |
| `@:` | Repeat last command-line command |

### Motion

| Key | Action |
| --- | --- |
| `h` `j` `k` `l` | Left / down / up / right |
| `w` / `b` / `e` | Next word / previous word / end of word |
| `W` / `B` / `E` | WORD motions (ignore punctuation) |
| `0` / `$` / `^` | Start of line / end of line / first non-blank |
| `gg` / `G` | First line / last line |
| `{` / `}` | Previous / next paragraph |
| `%` | Matching bracket |
| `f{char}` / `F{char}` / `t{char}` / `T{char}` | Find character on line |
| `;` / `,` | Repeat / reverse last f/F/t/T |
| `*` / `#` | Search word under cursor forward / backward |

### Scrolling & search

| Key | Action |
| --- | --- |
| `<C-d>` / `<C-u>` | Half page down / up (yours recenters with `zz`) |
| `<C-f>` / `<C-b>` | Page down / up (yours recenters with `zz`) |
| `zz` / `zt` / `zb` | Center / top / bottom cursor line |
| `/pattern` / `?pattern` | Search forward / backward |
| `n` / `N` | Next / previous search match |
| `:noh` | Clear search highlight |

### Editing

| Key | Action |
| --- | --- |
| `x` / `X` | Delete char / delete before cursor |
| `d{motion}` / `dd` | Delete motion / line |
| `c{motion}` / `cc` | Change motion / line |
| `y{motion}` / `yy` | Yank motion / line |
| `p` / `P` | Paste after / before |
| `>>` / `<<` | Indent / dedent line |
| `==` | Auto-indent line |
| `~` | Toggle case |
| `r{char}` | Replace character |
| `R` | Replace mode |
| `gc` / `gcc` | Toggle comment (with mini.comment) |

### Visual mode

| Key | Action |
| --- | --- |
| `o` / `O` | Move to other end of selection |
| `>` / `<` | Indent / dedent selection |
| `y` / `d` / `c` | Yank / delete / change selection |

### Windows & tabs

| Key | Action |
| --- | --- |
| `<C-w>h/j/k/l` | Move to split left/down/up/right |
| `<C-w>w` | Cycle windows |
| `<C-w>o` | Close other windows |
| `<C-w>v` / `<C-w>s` | Vertical / horizontal split |
| `<C-w>q` / `<C-w>c` | Close window |
| `<C-w>=` | Equalize split sizes |
| `gt` / `gT` | Next / previous tab |
| `:tabnew` / `:tabclose` | New tab / close tab |

### Buffers & files

| Key | Action |
| --- | --- |
| `:e {file}` | Edit file |
| `:w` / `:wq` / `:q` / `:q!` | Save / save & quit / quit / force quit |
| `:bn` / `:bp` | Next / previous buffer |
| `:bd` | Delete buffer |
| `<C-^>` | Alternate buffer |

### Registers & marks

| Key | Action |
| --- | --- |
| `"{reg}y` | Yank to register |
| `"{reg}p` | Paste from register |
| `m{a-z}` | Set mark |
| `` `{a-z} `` | Jump to exact mark position |
| `'{a-z}` | Jump to mark line |

### Macros

| Key | Action |
| --- | --- |
| `q{a-z}` | Record macro |
| `@{a-z}` | Play macro |
| `@@` | Repeat last macro |

### Command line

| Key | Action |
| --- | --- |
| `:` | Command mode |
| `/` / `?` | Search |
| `<C-r>{reg}` | Insert register in command line |
| `<C-a>` / `<C-e>` | Beginning / end of command line |
| `<Tab>` | Command completion |

### Terminal (built-in)

| Key | Action |
| --- | --- |
| `:terminal` | Open terminal buffer |
| `<C-\><C-n>` | Exit terminal insert mode |
| `<C-w>` | Window commands from terminal |

### LSP (common defaults — some overridden above)

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | References |
| `K` | Hover (yours) |
| `<leader>rn` | Rename symbol |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>ca` | Code action (yours) |

### Useful Ex commands

| Command | Action |
| --- | --- |
| `:checkhealth` | Run health checks |
| `:LspInfo` | Show active LSP clients |
| `:Mason` | Open Mason package manager |
| `:Telescope find_files` | Find files |
| `:Telescope live_grep` | Project-wide grep |
| `:Lazy` | Plugin manager |
| `:so %` | Reload current file (after editing config) |
