require("lib.language").register({
	filetypes  = { "terraform", "tf" },
	treesitter = "terraform",
	lsp        = "terraformls",
	formatter  = "terraform_fmt",
	linter     = "tflint",
})
