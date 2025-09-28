return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		explorer = {
			enabled = true,
			layout = {
				cycle = false,
			},
		},
		quickfile = {
			enabled = true,
			exclude = { "latex" },
		},
		picker = {
			enabled = true,
			matchers = {
				frecency = true,
				cwd_bonus = true,
			},
			formatters = {
				file = {
					filename_first = false,
					filename_only = false,
					icon_width = 2,
				},
			},
			layout = {
				preset = "telescope",
				cycle = false,
			},
			layouts = {
				select = {
					preview = false,
					layout = {},
				},
				telescope = {},
			},
		},
		image = {
			enabled = true,
			doc = {
				float = true, -- show image on cursor hover
				inline = false, -- show image inline
				max_width = 50,
				max_height = 30,
				wo = {
					wrap = false,
				},
			},
			convert = {
				notify = true,
				command = "magick",
			},
			img_dirs = {
				"img",
				"images",
				"assets",
				"static",
				"public",
				"media",
				"attachments",
				"Archives/All-Vault-Images/",
				"~/Library",
				"~/Downloads",
			},
		},
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
				--{
				--	section = "terminal",
				--	cmd = "ascii-image-converter PATH_TO_IMAGE_HERE -C -c",
				--	random = 10,
				--	pane = 2,
				--	indent = 4,
				--	height = 30,
				--},
			},
		},
	},
	keys = {
		{
			"<leader>lg",
			function()
				require("snacks").lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gl",
			function()
				require("snacks").lazygit.log()
			end,
			desc = "Lazygit logs",
		},
		{
			"<leader>1",
			function()
				require("snacks").explorer()
			end,
			desc = "Open snacks explorer",
		},
		{
			"<leader>rN",
			function()
				require("snacks").rename.rename_file()
			end,
			desc = "Rename current file",
		},
		{
			"<leader>dB",
			function()
				require("snacks").bufdelete()
			end,
			desc = "Delete or close buffer (confirm)",
		},

		{
			"<leader>P",
			function()
				require("snacks").picker.files({ layout = "ivy" })
			end,
			desc = "Find files",
		},
		{
			"<leader>F",
			function()
				require("snacks").picker.grep({ layout = "ivy" })
			end,
			desc = "Grep word",
		},
		--		{ "<leader>WF", function() require("snacks").picker.grep_word({ layout = "ivy" }) end, desc = "Grep word from selection", mode = { "n", "x" } },
		--		{ "<leader>wf", function() require("snacks").picker.grep_word({ layout = "ivy" }) end, desc = "Grep word from selection" , mode = { "n", "x" } },
		{
			"<leader>kk",
			function()
				require("snacks").picker.keymaps({ layout = "ivy" })
			end,
			desc = "Show keybindings",
		},

		{
			"<leader>gbr",
			function()
				require("snacks").picker.git_branches({ layout = "select" })
			end,
			desc = "Pick and preview git branches",
		},
		{
			"<leader>th",
			function()
				require("snacks").picker.colorschemes({ layout = "ivy" })
			end,
			desc = "Pick theme",
		},

		{
			"<leader>vh",
			function()
				require("snacks").picker.help()
			end,
			desc = "Open nvim help docs",
		},
	},
}
