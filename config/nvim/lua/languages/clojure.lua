return require("lib.language")({
	filetypes  = { "clojure", "edn" },
	treesitter = "clojure",
	lsp        = "clojure_lsp",
	formatter  = "cljfmt",
	linter     = "clj-kondo",
})
