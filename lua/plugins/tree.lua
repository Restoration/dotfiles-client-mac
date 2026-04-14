-- ---------------------------------------------------------------------------
-- ファイルツリー (nvim-tree)
-- ---------------------------------------------------------------------------

require("nvim-tree").setup({
  view     = { width = 30 },
  renderer = { group_empty = true },
  filters  = { dotfiles = false },
})

vim.keymap.set("n", ":nt",       "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>",  { noremap = true, silent = true })
