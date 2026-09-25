return {
	"neanias/everforest-nvim",
	version = false,
	lazy = false,
	priority = 1000,
	config = function()
		require("everforest").setup({
			background = "hard",
			transparent_background_level = 1,
			ui_contrast = "high",
			dim_inactive_windows = false,
			colours_override = function(palette)
				palette.bg_dim = "#121212"
				palette.bg0 = "#181818"
				palette.bg1 = "#282828"
				palette.bg2 = "#32302f"
				palette.bg3 = "#32302f"
				palette.bg4 = "#45403d"
				palette.bg5 = "#45403d"
			end,
			on_highlights = function(hl, palette)
				hl.TelescopeBorder = { fg = palette.bg2, bg = "NONE" }
				hl.SnacksDashboardHeader = { fg = palette.green, bold = true }
				hl.TelescopeNormal = { fg = palette.fg, bg = "NONE" }
				hl.TelescopeTitle = { fg = palette.green, bold = true }
				hl.TelescopePromptBorder = { fg = palette.bg4, bg = "NONE" }
				hl.TelescopePromptNormal = { fg = palette.fg, bg = "NONE" }
				hl.TelescopePromptPrefix = { fg = palette.red, bold = true }
				hl.NormalFloat = { bg = palette.bg0, fg = palette.fg }
				hl.FloatBorder = { bg = palette.bg0, fg = palette.bg4 }
				hl.FloatTitle = { bg = palette.bg0, fg = palette.orange, bold = true }
				hl.Pmenu = { bg = palette.bg1, fg = palette.fg }
				hl.PmenuSel = { bg = palette.bg3, fg = palette.green, bold = true }
				hl.PmenuSbar = { bg = palette.bg1 }
				hl.PmenuThumb = { bg = palette.bg4 }
				hl.CursorLine = { bg = palette.bg1 }
				hl.CursorLineNr = { fg = palette.yellow, bold = true }
				hl.ColorColumn = { bg = palette.bg1 }
				hl.DiagnosticError = { fg = palette.red }
				hl.DiagnosticWarn = { fg = palette.yellow }
				hl.DiagnosticInfo = { fg = palette.blue }
				hl.DiagnosticHint = { fg = palette.aqua }
				hl.LeapMatch = { bg = palette.green, fg = palette.bg0, bold = true }
				hl.LeapLabel = { bg = palette.red, fg = palette.bg0, bold = true }
			end,
		})
		vim.cmd.colorscheme("everforest")
	end,
}
