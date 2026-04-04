require("core.vimoptions")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Build hooks (must be registered before any vim.pack.add calls)
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
		if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
			local path = vim.fn.stdpath("data") .. "/site/pack/core/opt/telescope-fzf-native.nvim"
			vim.fn.system({ "make", "-C", path })
		end
	end,
})

vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, { desc = "Update all plugins" })

local require_dir = require("lib.require_dir")

-- Register languages first (populates shared tables), then configure plugins
require_dir("languages")
require_dir("plugins")
