return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  tag = "0.1.8",
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
}

