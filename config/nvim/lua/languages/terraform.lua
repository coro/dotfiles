return require("lib.language")({
	filetypes  = { "terraform", "tf" },
	treesitter = "terraform",
	lsp        = "terraformls",
	formatter  = { install = "terraform", name = "terraform_fmt" },
	linter     = "tflint",
})
