local parsers = {
	"json",
	"javascript",
	"typescript",
	"tsx",
	"go",
	"yaml",
	"html",
	"css",
	"python",
	"http",
	"prisma",
	"markdown",
	"markdown_inline",
	"svelte",
	"graphql",
	"bash",
	"lua",
	"vim",
	"dockerfile",
	"gitignore",
	"query",
	"vimdoc",
	"c",
	"java",
	"rust",
	"ron",
	"php",
	"blade",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- main branch does not support lazy-loading
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup()
			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			-- incremental selection (built into Neovim 0.12)
			vim.keymap.set({ "n", "x" }, "<C-space>", function()
				if vim.fn.mode() == "n" then
					vim.cmd("normal! van")
				else
					vim.cmd("normal! an")
				end
			end, { desc = "Treesitter incremental selection" })
		end,
	},
	-- NOTE: js,ts,jsx,tsx Auto Close Tags
	{
		"windwp/nvim-ts-autotag",
		enabled = true,
		ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
				per_filetype = {
					["html"] = {
						enable_close = true,
					},
					["typescriptreact"] = {
						enable_close = true,
					},
				},
			})
		end,
	},
}
