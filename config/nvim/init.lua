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

-- Register languages first (populates shared tables)
require("languages.lua")
require("languages.go")
require("languages.python")
require("languages.clojure")
require("languages.yaml")
require("languages.terraform")

-- Then configure plugins (reads from shared tables)
require("plugins.colourscheme")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.conform")
require("plugins.lint")
require("plugins.telescope")
require("plugins.gitsigns")
require("plugins.yazi")
require("plugins.indent-blankline")
require("plugins.surround")

-- No-config plugins
vim.pack.add({ "https://github.com/tpope/vim-sleuth" })
