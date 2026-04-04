require("lib.language").register({
	filetypes  = { "clojure", "edn" },
	treesitter = "clojure",
	lsp        = "clojure_lsp",
	formatter  = "cljfmt",
	linter     = "clj-kondo",
})
