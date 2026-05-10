-- ---------------------------------------------------------------------------
-- タグバー (tagbar)
-- ---------------------------------------------------------------------------

vim.g.tagbar_width = 30
vim.g.tagbar_autoshowtag = 1
vim.keymap.set("n", "<leader>tb", "<cmd>TagbarToggle<CR>", { noremap = true, silent = true })
