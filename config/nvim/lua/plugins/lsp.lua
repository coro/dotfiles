return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local opts = { capabilities = require("cmp_nvim_lsp").default_capabilities() }
      require'lspconfig'.gopls.setup(opts)
      require'lspconfig'.terraformls.setup(opts)
    end,
    keys = {
      { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
  },

}
