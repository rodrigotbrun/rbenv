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
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- indent with LSP
vim.keymap.set("n", "<leader>L", vim.lsp.buf.format)

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- highlight yank/copy
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- tabs
vim.keymap.set("n", "<leader>t", "<cmd>tabnew<CR>", { desc = "open new tab" })
vim.keymap.set("n", "<leader>w", "<cmd>tabclose<CR>", { desc = "close current tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "go to next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "go to previous tab" })

vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "make split equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "close current split" })

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
