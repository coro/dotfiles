local function autosave_formatting_magic(bufnr)
  local augroup = vim.api.nvim_create_augroup("CoroLspFormatting", {clear = true})
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
      params.context = { only = { "source.organizeImports" } }

      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
      for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
          else
            vim.lsp.buf.execute_command(r.command)
          end
        end
      end
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local opts = { capabilities = require("cmp_nvim_lsp").default_capabilities() }

      require 'lspconfig'.gopls.setup {
        opts,
        on_attach = function(_, bufnr)
          autosave_formatting_magic(bufnr)
        end

      }
      require 'lspconfig'.terraformls.setup(opts)
      require 'lspconfig'.clojure_lsp.setup(opts)
      require 'lspconfig'.pyright.setup(opts)
      require 'lspconfig'.lua_ls.setup {
        opts,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
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
