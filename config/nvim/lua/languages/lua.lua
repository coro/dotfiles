vim.hl.priorities.semantic_tokens = 95

return require("lib.language")({
	filetypes  = { "lua" },
	treesitter = "lua",
	lsp        = "lua_ls",
	formatter  = "stylua",
	linter     = "luacheck",
})
