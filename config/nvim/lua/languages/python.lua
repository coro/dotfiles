return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "python" })
		end,
		ft = { "python" },
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "pyright" })
		end,
		ft = { "python" },
	},
	{
		"stevearc/conform.nvim",
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = function(_, opts)
					opts.mason_installations = opts.mason_installations or {}
					vim.list_extend(opts.mason_installations, { "black" })
				end,
			},
		},
		ft = { "python" },
		opts = {
			formatters_by_ft = {
				python = { "black" },
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
					vim.list_extend(opts.mason_installations, { "pylint" })
				end,
			},
		},
		ft = { "python" },
		opts = {
			linters_by_ft = {
				python = { "pylint" },
			},
		},
	},
}
