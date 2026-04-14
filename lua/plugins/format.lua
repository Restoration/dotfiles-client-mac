-- ---------------------------------------------------------------------------
-- 保存時フォーマット (conform.nvim) - 全言語統合
-- ---------------------------------------------------------------------------

require("conform").setup({
  formatters_by_ft = {
    go              = { "goimports", "gofumpt" },
    javascript      = { "biome" },
    javascriptreact = { "biome" },
    typescript      = { "biome" },
    typescriptreact = { "biome" },
    json            = { "biome" },
    python          = { "black" },
  },
  format_on_save = {
    timeout_ms   = 1000,
    lsp_fallback = true,
  },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { noremap = true, silent = true, desc = "Format buffer" })
