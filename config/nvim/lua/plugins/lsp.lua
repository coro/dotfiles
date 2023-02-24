return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local opts = { capabilities = require("cmp_nvim_lsp").default_capabilities() }
      require'lspconfig'.gopls.setup(opts)
      require'lspconfig'.terraformls.setup(opts)
      require'lspconfig'.clojure_lsp.setup(opts)
      require'lspconfig'.lua_ls.setup(opts)
      require'lspconfig'.lua_ls.setup {
        opts,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      }
    end,
  },
}
