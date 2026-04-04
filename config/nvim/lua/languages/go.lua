require("lib.language").register({
	filetypes  = { "go", "gomod", "gosum" },
	treesitter = { "go", "gomod", "gosum" },
	lsp        = "gopls",
	formatter  = "gofumpt",
	linter     = "golangci-lint",
})
