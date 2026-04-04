require("lib.language").register({
	filetypes  = { "python" },
	treesitter = "python",
	lsp        = "pyright",
	formatter  = "black",
	linter     = "pylint",
})
