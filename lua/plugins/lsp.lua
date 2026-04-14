-- ---------------------------------------------------------------------------
-- LSP (nvim-lspconfig)
-- ---------------------------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { noremap = true, silent = true, buffer = ev.buf }
    vim.keymap.set("n", "gd",         vim.lsp.buf.definition,     opts)
    vim.keymap.set("n", "gr",         vim.lsp.buf.references,     opts)
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,          opts)
    vim.keymap.set("n", "gi",         vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>",      vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,         opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,    opts)
    vim.keymap.set("n", "<leader>f",  function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses           = { unusedparams = true, shadow = true },
      staticcheck        = true,
      gofumpt            = true,
      usePlaceholders    = true,
      completeUnimported = true,
    },
  },
})

vim.lsp.config("pyright", {})
vim.lsp.enable({ "gopls", "pyright" })
-- ts_ls は typescript-tools.nvim (typescript.lua) が管理

vim.diagnostic.config({
  virtual_text     = true,
  signs            = true,
  underline        = true,
  update_in_insert = false,
})
