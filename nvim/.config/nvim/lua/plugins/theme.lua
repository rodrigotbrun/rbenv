local function patch_popup_highlights()
	local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	local visual = vim.api.nvim_get_hl(0, { name = "Visual", link = false })

	local fg = normal.fg
	local bg = normal.bg
	local sel_bg = visual.bg or normal.bg

	local function hl(name, opts)
		vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", { fg = fg, bg = bg }, opts))
	end

	hl("NormalFloat", {})
	hl("Pmenu", {})
	hl("FloatBorder", { fg = bg })
	hl("FloatTitle", { bold = true })
	hl("FloatFooter", { bold = true })
	hl("PmenuSel", { bg = sel_bg })
	hl("PmenuSbar", { bg = bg })
	hl("PmenuThumb", { bg = sel_bg })

	local telescope_groups = {
		"TelescopeNormal",
		"TelescopeBorder",
		"TelescopePromptNormal",
		"TelescopePromptBorder",
		"TelescopeResultsNormal",
		"TelescopeResultsBorder",
		"TelescopePreviewNormal",
		"TelescopePreviewBorder",
		"TelescopeSelection",
		"TelescopeSelectionCaret",
	}

	for _, group in ipairs(telescope_groups) do
		vim.api.nvim_set_hl(0, group, { link = "NormalFloat" })
	end
end

return {
	"CosecSecCot/midnight-desert.nvim",
	lazy = false,
	priority = 1000,
	dependencies = {
		"rktjmp/lush.nvim",
	},
	config = function()
		vim.cmd.colorscheme("midnight-desert")
		patch_popup_highlights()

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "midnight-desert",
			callback = patch_popup_highlights,
		})
	end,
}
