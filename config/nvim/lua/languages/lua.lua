vim.hl.priorities.semantic_tokens = 95

require("lib.language").register({
	filetypes  = { "lua" },
	treesitter = "lua",
	lsp        = "lua_ls",
	formatter  = "stylua",
	linter     = "luacheck",
})
