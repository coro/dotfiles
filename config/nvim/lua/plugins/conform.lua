vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local lang = require("lib.language")

require("conform").setup({
	formatters_by_ft = lang.formatters_by_ft,
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = { timeout_ms = 500 },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set("", "<leader>f", function()
	require("conform").format({ async = true })
end, { desc = "Format buffer" })
