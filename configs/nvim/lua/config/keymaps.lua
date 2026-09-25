local map = vim.keymap.set

map("n", "", "ggVG", { desc = "Select all text" })

map("i", "jk", "", { desc = "Exit to normal mode" })

map("n", "h", "nohlsearch", { desc = "Clear search highlights" })

map("n", "ss", "split", { desc = "Horizontal split" })
map("n", "sd", "vsplit", { desc = "Vertical split" })
map("n", "sq", "q", { desc = "Close file" })

map("n", "", "h", { desc = "Window left" })
map("n", "", "j", { desc = "Window down" })
map("n", "", "k", { desc = "Window up" })
map("n", "", "l", { desc = "Window right" })

map("n", "", "bprevious", { desc = "Previous buffer" })
map("n", "", "bnext", { desc = "Next buffer" })

map("n", "bd", function()
	local ok, snacks = pcall(require, "snacks")
	if ok then
		snacks.bufdelete()
	else
		vim.cmd("bp | bd #")
	end
end, { desc = "Close current buffer without breaking splits" })

map("v", "J", ":m '>+1gv=gv", { desc = "Move block down" })
map("v", "K", ":m '<-2gv=gv", { desc = "Move block up" })

map("v", "<", "", ">gv", { desc = "Indent and keep selection" })

map("v", "p", '"_dP', { desc = "Paste without overwriting register" })

map("n", "", "zz", { desc = "Scroll down centered" })
map("n", "", "zz", { desc = "Scroll up centered" })
map("n", "n", "nzzzv", { desc = "Next search result centered" })
map("n", "N", "Nzzzv", { desc = "Previous search result centered" })

map("n", "cq", vim.diagnostic.setloclist, { desc = "Diagnostics list to loclist" })
