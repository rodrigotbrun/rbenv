local function patch_ui_highlights()
	local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	local visual = vim.api.nvim_get_hl(0, { name = "Visual", link = false })

	local fg = normal.fg
	local bg = normal.bg
	local sel_bg = visual.bg or normal.bg
	-- separators must use a dark fg; linking to Normal uses light text color
	local border = sel_bg

	local function hl(name, opts)
		vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", { fg = fg, bg = bg }, opts))
	end

	-- popups / pickers
	hl("NormalFloat", {})
	hl("NormalNC", {})
	hl("Pmenu", {})
	hl("FloatBorder", { fg = border, bg = bg })
	hl("FloatTitle", { bold = true })
	hl("FloatFooter", { bold = true })
	hl("PmenuSel", { bg = sel_bg })
	hl("PmenuSbar", { bg = bg })
	hl("PmenuThumb", { bg = sel_bg })

	-- window split lines (main source of bright UI lines)
	hl("WinSeparator", { fg = border, bg = bg })
	hl("VertSplit", { fg = border, bg = bg })

	-- editor guides
	hl("CursorLine", { bg = sel_bg })
	hl("CursorLineNr", { fg = fg, bg = sel_bg, bold = true })
	hl("ColorColumn", { bg = sel_bg })
	hl("LineNr", { fg = border, bg = bg })

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

	-- snacks sidebar / floating windows
	for _, group in ipairs({
		"SnacksNormal",
		"SnacksNormalNC",
		"SnacksWinSeparator",
		"SnacksPickerBorder",
		"SnacksPickerTitle",
		"SnacksPickerFooter",
	}) do
		vim.api.nvim_set_hl(0, group, { fg = border, bg = bg })
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
		patch_ui_highlights()

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "midnight-desert",
			callback = patch_ui_highlights,
		})
	end,
}
