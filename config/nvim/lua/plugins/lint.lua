vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local lang = require("lib.language")
local lint = require("lint")

lint.linters_by_ft = lang.linters_by_ft

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
	group = vim.api.nvim_create_augroup("lint", { clear = true }),
	callback = function()
		lint.try_lint()
	end,
})
