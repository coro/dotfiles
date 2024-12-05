return {
	{
		"stevearc/conform.nvim",
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
				"williamboman/mason.nvim",
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					vim.list_extend(opts.ensure_installed, { "pylint" })
				end,
			},
		},
		opts = {
			linters_by_ft = {
				python = { "pylint" },
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				dependencies = {
					{
						"williamboman/mason.nvim",
					},
				},
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					vim.list_extend(opts.ensure_installed, { "pyright" })
				end,
			},
		},
		opts = {
			servers = {
				pyright = {},
			},
		},
	},
}
