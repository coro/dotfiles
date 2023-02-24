return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")
    local mapping = cmp.mapping

    cmp.setup({
      mapping = {
        ["<Up>"] = mapping(mapping.select_prev_item(), { "i", "c" }),
        ["<Down>"] = mapping(mapping.select_next_item(), { "i", "c" }),
        ["<CR>"] = mapping.confirm({ select = false }),
      },
      sources = {
        { name = "buffer" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "snippy" },
      },
      snippet = {
        expand = function(args) require("snippy").expand_snippet(args.body) end,
      },
    })
  end,
  dependencies = {
    "dcampos/nvim-snippy",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
  },
}
