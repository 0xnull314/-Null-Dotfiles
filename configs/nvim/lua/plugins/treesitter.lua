return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSUpdate", "TSInstall", "TSBufEnable", "TSModuleInfo" },
	config = function()
		local ok, configs = pcall(require, "nvim-treesitter.configs")
		if not ok then
			return
		end

		configs.setup({
			ensure_installed = {
				"c",
				"cpp",
				"python",
				"lua",
				"luadoc",
				"vim",
				"vimdoc",
				"query",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"json",
			},
			sync_install = false,
			auto_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = function(_, buf)
					local max_filesize = 100 * 1024
					local ok_stat, stats = pcall((vim.uv or vim.loop).fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok_stat and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			indent = {
				enable = false,
			},
			incremental_selection = {
				enable = false,
			},
		})
	end,
}
