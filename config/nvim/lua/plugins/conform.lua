return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre", "BufNewFile" },
		config = function(_, opts)
			-- TODO: add toggle keymap for auto-save on/off by leveraging a vim.g variable and:
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({
						bufnr = args.buf,
						timeout_ms = 5000,
						lsp_format = "fallback",
					})
				end,
			})

			require("conform").setup(opts)
		end,
	},
}
