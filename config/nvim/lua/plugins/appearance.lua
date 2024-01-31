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
    main = "ibl",
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true
  },
  {
    'lewis6991/gitsigns.nvim',
    tag = 'release',
    config = true
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config=function()
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
          'go',
          'gomod',
          'gosum',
          'lua',
          'python',
          'rust',
          'typescript',
          'vim',
          'terraform',
          'clojure',
        },

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
