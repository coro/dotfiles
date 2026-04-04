require("lib.language").register({
	filetypes  = { "yaml" },
	treesitter = "yaml",
	lsp        = "yamlls",
	formatter  = "yamlfmt",
	linter     = "yamllint",
})
