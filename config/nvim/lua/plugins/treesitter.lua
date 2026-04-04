vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

local lang = require("lib.language")

require("nvim-treesitter").setup({
	ensure_installed = lang.treesitter_grammars,
})
