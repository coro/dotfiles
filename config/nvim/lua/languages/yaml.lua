return require("lib.language")({
	filetypes  = { "yaml" },
	treesitter = "yaml",
	lsp        = "yamlls",
	formatter  = "yamlfmt",
	linter     = "yamllint",
})
