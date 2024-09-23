return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  event = "VeryLazy",
  keys = {
    { '<leader>t', '<cmd>Neotree toggle<cr>',  desc = 'Open up project [t]ree' },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  }
}
