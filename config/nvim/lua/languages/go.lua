require("lib.language").register({
	filetypes  = { "go" },
	treesitter = "go",
	lsp        = "gopls",
	formatter  = "gofumpt",
	linter     = "golangci-lint",
})
