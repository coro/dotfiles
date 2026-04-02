return require("lib.language")({
	filetypes  = { "go" },
	treesitter = "go",
	lsp        = "gopls",
	formatter  = "gofumpt",
	linter     = "golangci-lint",
})
