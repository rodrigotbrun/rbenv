local function laravel_ready()
	local cwd = vim.fn.getcwd()
	return vim.fn.filereadable(cwd .. "/artisan") == 1
		and vim.fn.filereadable(cwd .. "/vendor/autoload.php") == 1
end

return {
	"adalessa/laravel.nvim",
	cond = laravel_ready,
	init = function()
		if laravel_ready() then
			vim.fn.mkdir("vendor/nvim-laravel", "p")
		end
	end,
	dependencies = {
		"tpope/vim-dotenv",
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-neotest/nvim-nio",
		"ravitemer/mcphub.nvim", -- optional
	},
	cmd = { "Laravel" },
	keys = {
		{
			"<leader>ll",
			function()
				Laravel.pickers.laravel()
			end,
			desc = "Laravel: Open Laravel Picker",
		},
		{
			"<c-g>",
			function()
				Laravel.commands.run("view:finder")
			end,
			desc = "Laravel: Open View Finder",
		},
		{
			"<leader>la",
			function()
				Laravel.pickers.artisan()
			end,
			desc = "Laravel: Open Artisan Picker",
		},
		{
			"<leader>lt",
			function()
				Laravel.commands.run("actions")
			end,
			desc = "Laravel: Open Actions Picker",
		},
		{
			"<leader>lr",
			function()
				Laravel.pickers.routes()
			end,
			desc = "Laravel: Open Routes Picker",
		},
		{
			"<leader>lh",
			function()
				Laravel.run("artisan docs")
			end,
			desc = "Laravel: Open Documentation",
		},
		{
			"<leader>lm",
			function()
				Laravel.pickers.make()
			end,
			desc = "Laravel: Open Make Picker",
		},
		{
			"<leader>lc",
			function()
				Laravel.pickers.commands()
			end,
			desc = "Laravel: Open Commands Picker",
		},
		{
			"<leader>lo",
			function()
				Laravel.pickers.resources()
			end,
			desc = "Laravel: Open Resources Picker",
		},
		{
			"<leader>lp",
			function()
				Laravel.commands.run("command_center")
			end,
			desc = "Laravel: Open Command Center",
		},
		{
			"gf",
			function()
				local ok, res = pcall(function()
					if Laravel.app("gf").cursorOnResource() then
						return "<cmd>lua Laravel.commands.run('gf')<cr>"
					end
				end)
				if not ok or not res then
					return "gf"
				end
				return res
			end,
			expr = true,
			noremap = true,
		},
	},
	-- load on demand (cmd/keys), not on every startup
	opts = function(_, opts)
		opts.lsp_server = "phpactor" -- "phpactor | intelephense"
		opts.features = vim.tbl_deep_extend("force", opts.features or {}, {
			pickers = {
				provider = "snacks", -- "snacks | telescope | fzf-lua | ui-select"
			},
		})

		opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
			diagnostic = { enable = false },
		})

		-- status provider crashes when artisan/php fails (upstream bug)
		opts.providers = vim.tbl_filter(function(provider)
			return provider.name ~= "laravel.providers.status_provider"
		end, require("laravel.options.default").providers)

		return opts
	end,
}
