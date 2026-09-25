return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	priority = 1000,
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local devicons = require("nvim-web-devicons")

		dashboard.section.header.val = {
			[[  ___     ___    ___   __  __   __    ___ ___    ]],
			[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
			[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
			[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
			[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
		}
		dashboard.section.header.opts.position = "center"
		dashboard.section.header.opts.hl = "AlphaHeader"

		local function create_button(sc, txt, keybind)
			local b = dashboard.button(sc, txt, keybind)
			b.opts.position = "center"
			b.opts.hl = "AlphaButton"
			b.opts.hl_shortcut = "AlphaShortcut"
			return b
		end

		local function get_mru(max_files)
			local files = {}
			local oldfiles = vim.v.oldfiles
			local count = 0
			local max_dir_width = 35

			for _, file in ipairs(oldfiles) do
				if count >= max_files then
					break
				end

				local is_valid = vim.fn.filereadable(file) == 1 and not file:match("COMMIT_EDITMSG$")
				if is_valid then
					count = count + 1

					local full_path = vim.fn.fnamemodify(file, ":~")
					local dir = vim.fn.fnamemodify(full_path, ":h")
					local filename = vim.fn.fnamemodify(full_path, ":t")

					if dir == "~" then
						dir = "~/"
					elseif dir ~= "" then
						dir = dir .. "/"
					end

					if #dir > max_dir_width then
						dir = vim.fn.pathshorten(dir)
						if #dir > max_dir_width then
							dir = "…" .. dir:sub(#dir - max_dir_width + 4)
						end
					end

					local ext = filename:match("^.+%.(.+)$") or ""
					local icon, icon_hl = devicons.get_icon(filename, ext, { default = true })
					icon = icon or "󰈙"
					icon_hl = icon_hl or "Comment"

					local shortcut = count == 10 and "0" or tostring(count)
					local txt = icon .. "  " .. dir .. filename
					local b = create_button(shortcut, txt, "e " .. vim.fn.fnameescape(file) .. "")

					local icon_len = #icon
					local dir_len = #dir
					local fn_len = #filename

					b.opts.hl = {
						{ icon_hl, 0, icon_len },
						{ "Comment", icon_len + 2, icon_len + 2 + dir_len },
						{ "String", icon_len + 2 + dir_len, icon_len + 2 + dir_len + fn_len },
					}

					table.insert(files, b)
				end
			end
			return files
		end
		dashboard.section.buttons.val = {
			create_button("f", "  Find File", "Telescope find_files"),
			create_button("g", "󰈭  Find Text", "Telescope live_grep"),
			create_button("n", "  New File", "ene | startinsert"),
			create_button("c", "  Configuration", "e $MYVIMRC | cd %:p:h"),
			create_button("l", "󰒲  Plugin Manager", "Lazy"),
			create_button("q", "󰅚  Quit Neovim", "qa"),
		}
		dashboard.section.buttons.opts.position = "center"
		dashboard.section.buttons.opts.spacing = 0

		local function footer()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			return string.format("⚡ %d/%d plugins loaded in %.2fms", stats.loaded, stats.count, ms)
		end

		dashboard.section.footer.val = footer()
		dashboard.section.footer.opts.position = "center"
		dashboard.section.footer.opts.hl = "AlphaFooter"

		vim.api.nvim_set_hl(0, "AlphaHeader", { link = "Title" })
		vim.api.nvim_set_hl(0, "AlphaButton", { link = "Normal" })
		vim.api.nvim_set_hl(0, "AlphaShortcut", { link = "Number" })
		vim.api.nvim_set_hl(0, "AlphaFooter", { link = "Comment" })

		dashboard.config.layout = {
			{ type = "padding", val = 2 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			{
				type = "text",
				val = "──  Recent Files  ──",
				opts = { position = "center", hl = "SpecialComment" },
			},
			{ type = "padding", val = 1 },
			{
				type = "group",
				val = function()
					return get_mru(7)
				end,
			},
			{ type = "padding", val = 1 },
			{
				type = "text",
				val = "──  Quick Actions  ──",
				opts = { position = "center", hl = "SpecialComment" },
			},
			{ type = "padding", val = 1 },
			dashboard.section.buttons,
			{ type = "padding", val = 2 },
			dashboard.section.footer,
		}

		alpha.setup(dashboard.config)
	end,
}
