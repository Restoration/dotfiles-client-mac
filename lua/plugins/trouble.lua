-- ---------------------------------------------------------------------------
-- 診断パネル (trouble.nvim)
-- プロジェクト全体のエラー・警告を一覧表示
-- ---------------------------------------------------------------------------

require("trouble").setup({
  modes = {
    diagnostics = { auto_close = true },
  },
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>xx",
  "<cmd>Trouble diagnostics toggle<CR>",
  vim.tbl_extend("force", opts, { desc = "Trouble: Toggle diagnostics" }))
vim.keymap.set("n", "<leader>xX",
  "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
  vim.tbl_extend("force", opts, { desc = "Trouble: Buffer diagnostics" }))
vim.keymap.set("n", "<leader>xq",
  "<cmd>Trouble qflist toggle<CR>",
  vim.tbl_extend("force", opts, { desc = "Trouble: Quickfix list" }))
vim.keymap.set("n", "[d",
  function() require("trouble").prev({ skip_groups = true, jump = true }) end,
  vim.tbl_extend("force", opts, { desc = "Trouble: Prev diagnostic" }))
vim.keymap.set("n", "]d",
  function() require("trouble").next({ skip_groups = true, jump = true }) end,
  vim.tbl_extend("force", opts, { desc = "Trouble: Next diagnostic" }))
