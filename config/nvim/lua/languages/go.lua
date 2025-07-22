return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "go" })
		end,
		ft = { "go" },
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "gopls" })
		end,
		ft = { "go" },
	},
	{
		"stevearc/conform.nvim",
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = function(_, opts)
					opts.mason_installations = opts.mason_installations or {}
					vim.list_extend(opts.mason_installations, { "gofumpt" })
				end,
			},
		},
		ft = { "go" },
		opts = {
			formatters_by_ft = {
				go = { "gofumpt" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = function(_, opts)
					opts.mason_installations = opts.mason_installations or {}
					vim.list_extend(opts.mason_installations, { "golangci-lint" })
				end,
			},
		},
		ft = { "go" },
		opts = {
			linters_by_ft = {
				lua = { "golangci-lint" },
			},
		},
	},
}
