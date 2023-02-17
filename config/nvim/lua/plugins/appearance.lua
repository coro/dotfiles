return {
	{
		"EdenEast/nightfox.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			require('nightfox').setup({ options = { transparent = true } })
			vim.cmd([[colorscheme nightfox]])
		end,
	},
	{ 
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			char = '┊',
			show_trailing_blankline_indent = false,
		}

	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{
		'lewis6991/gitsigns.nvim',
		tag = 'release'
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config=function()
			-- Set lualine as statusline
			-- See `:help lualine.txt`
			require('nvim-treesitter.configs').setup {
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'vim' },

				highlight = { enable = true },
				indent = { enable = true, disable = { 'python' } },
				incremental_selection = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = true,
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
					},
					swap = {
						enable = true,
					},
				},
			}
		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
	},

}
