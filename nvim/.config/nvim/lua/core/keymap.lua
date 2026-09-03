local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- move lines --
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move lines up in visual selection" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move lines down in visual selection" })

vim.keymap.set("n", "J", "mzJ`z")

-- indent in visual mode --
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- delete without copy --
vim.keymap.set("x", "<leader>p", '"_dP')

-- indent with LSP
vim.keymap.set("n", "<leader>L", vim.lsp.buf.format)

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- highlight yank/copy
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- tmux-style: <leader> stands in for prefix (Ctrl-b)
-- windows → tabs, panes → splits
vim.keymap.set("n", "<leader>c", "<cmd>tabnew<CR>", { desc = "new tab (tmux c)" })
vim.keymap.set("n", "<leader>n", "<cmd>tabn<CR>", { desc = "next tab (tmux n)" })
vim.keymap.set("n", "<leader>p", "<cmd>tabp<CR>", { desc = "previous tab (tmux p)" })
vim.keymap.set("n", "<leader>&", "<cmd>tabclose<CR>", { desc = "close tab (tmux &)" })

vim.keymap.set("n", "<leader>%", "<C-w>v", { desc = "split vertically (tmux %)" })
vim.keymap.set("n", '<leader>"', "<C-w>s", { desc = 'split horizontally (tmux ")' })
vim.keymap.set("n", "<leader>x", "<cmd>close<CR>", { desc = "close split (tmux x)" })
vim.keymap.set("n", "<leader>H", function()
	vim.cmd("windo wincmd H")
	vim.cmd("wincmd =")
end, { desc = "even horizontal layout (tmux H)" })
vim.keymap.set("n", "<leader>V", function()
	vim.cmd("windo wincmd K")
	vim.cmd("wincmd =")
end, { desc = "even vertical layout (tmux V)" })
vim.keymap.set("n", "<leader>o", "<C-w>w", { desc = "next split (tmux o)" })
vim.keymap.set("n", "<leader>;", "<C-w>p", { desc = "last split (tmux ;)" })

vim.keymap.set("n", "<leader><Left>", "<C-w>h", { desc = "focus split left (tmux Left)" })
vim.keymap.set("n", "<leader><Down>", "<C-w>j", { desc = "focus split down (tmux Down)" })
vim.keymap.set("n", "<leader><Up>", "<C-w>k", { desc = "focus split up (tmux Up)" })
vim.keymap.set("n", "<leader><Right>", "<C-w>l", { desc = "focus split right (tmux Right)" })

-- tmux: prefix + Ctrl-arrow resizes by 1, prefix + Alt-arrow by 5
vim.keymap.set("n", "<leader><C-Up>", "<cmd>resize +1<CR>", { desc = "increase split height (tmux C-Up)" })
vim.keymap.set("n", "<leader><C-Down>", "<cmd>resize -1<CR>", { desc = "decrease split height (tmux C-Down)" })
vim.keymap.set("n", "<leader><C-Right>", "<cmd>vertical resize +1<CR>", { desc = "increase split width (tmux C-Right)" })
vim.keymap.set("n", "<leader><C-Left>", "<cmd>vertical resize -1<CR>", { desc = "decrease split width (tmux C-Left)" })
vim.keymap.set("n", "<leader><A-Up>", "<cmd>resize +5<CR>", { desc = "increase split height (tmux M-Up)" })
vim.keymap.set("n", "<leader><A-Down>", "<cmd>resize -5<CR>", { desc = "decrease split height (tmux M-Down)" })
vim.keymap.set("n", "<leader><A-Right>", "<cmd>vertical resize +5<CR>", { desc = "increase split width (tmux M-Right)" })
vim.keymap.set("n", "<leader><A-Left>", "<cmd>vertical resize -5<CR>", { desc = "decrease split width (tmux M-Left)" })

-- copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
	local filePath = vim.fn.expand("%:~")
	vim.fn.setreg("+", filePath)
	print("File path copied to clipboard: " .. filePath)
end, { desc = "copy file path to clipboard" })

-- Spotify controls
vim.keymap.set("n", "<C-s>yn", "<cmd>!spotify next<CR>", { desc = "Next music on Spotify" })
vim.keymap.set("n", "<C-s>yb", "<cmd>!spotify back<CR>", { desc = "Previous music on Spotify" })
vim.keymap.set("n", "<C-s>pp", "<cmd>!spotify p<CR>", { desc = "Toggle play/pause" })

vim.keymap.set("i", "jj", "<Esc>", { noremap = false })
vim.keymap.set("i", "jk", "<Esc>", { noremap = false })

vim.keymap.set({ "x", "n", "i" }, "<C-w>%", ":vsplit<CR>")
vim.keymap.set({ "x", "n", "i" }, '<C-w>"', "<C-w>s")

-- file nav

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- tabs nav

vim.keymap.set("n", "<C-w>,", "<cmd>BufferPrevious<CR>", opts)
vim.keymap.set("n", "<C-w>.", "<cmd>BufferNext<CR>", opts)
vim.keymap.set("n", "<C-w>x", "<cmd>BufferClose<CR>", opts)
