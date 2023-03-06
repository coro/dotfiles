return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    branch = "v2.x",
    keys = {
      { '<leader>t', '<cmd>Neotree toggle<cr>',  desc = 'Open up project [t]ree' },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "Telescope"
    },
    keys = {
      { '<leader>km', ':Telescope keymaps<CR>',  desc = '[k]ey[m]aps' },
      { '<leader>lg', ':Telescope live_grep<CR>',  desc = '[l]ive [g]rep' },
      { '<leader>ff', ':Telescope find_files<CR>', desc = '[f]ind [f]iles' },
    },
  },
}
