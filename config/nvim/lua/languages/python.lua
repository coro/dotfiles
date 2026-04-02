return require("lib.language")({
	filetypes  = { "python" },
	treesitter = "python",
	lsp        = "pyright",
	formatter  = "black",
	linter     = "pylint",
})
