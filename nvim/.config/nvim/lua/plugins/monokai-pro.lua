return {
	"loctvl842/monokai-pro.nvim",
	config = function()
		require("monokai-pro").setup({
			dim_inactive = false,
			-- Optional: customize the scheme (example uses "classic" filter)
			-- filter = "ristretto", -- Options: "pro", "classic", "machine", "octagon", "ristretto", "spectrum"
			styles = {
				sidebars = "transparent",
			},

			-- Other configuration options can be added here
		})
		-- vim.cmd("colorscheme monokai-pro")
	end,
}
