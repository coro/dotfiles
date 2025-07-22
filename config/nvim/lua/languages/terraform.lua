return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "terraform" })
		end,
		ft = { "terraform" },
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "terraform-ls" })
		end,
		ft = { "terraform" },
	},
	{
		"stevearc/conform.nvim",
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = function(_, opts)
					opts.mason_installations = opts.mason_installations or {}
					vim.list_extend(opts.mason_installations, { "terraform" })
				end,
			},
		},
		ft = { "terraform" },
		opts = {
			formatters_by_ft = {
				terraform = { "terraform_fmt" },
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
					vim.list_extend(opts.mason_installations, { "tflint" })
				end,
			},
		},
		ft = { "terraform" },
		opts = {
			linters_by_ft = {
				terraform = { "tflint" },
			},
		},
	},
}
