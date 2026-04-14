-- ---------------------------------------------------------------------------
-- 非同期 Lint (nvim-lint)
-- Biome (JS/TS/JSON) + ruff (Python)
-- ---------------------------------------------------------------------------

local lint = require("lint")

lint.linters_by_ft = {
  javascript      = { "biomejs" },
  javascriptreact = { "biomejs" },
  typescript      = { "biomejs" },
  typescriptreact = { "biomejs" },
  json            = { "biomejs" },
  python          = { "ruff" },
}

-- 保存時・InsertLeave 時に lint 実行
vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufEnter" }, {
  pattern  = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.json", "*.py" },
  callback = function() lint.try_lint() end,
})

vim.keymap.set("n", "<leader>tl",
  function() lint.try_lint() end,
  { noremap = true, silent = true, desc = "Run lint" })
