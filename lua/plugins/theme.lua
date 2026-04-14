-- ---------------------------------------------------------------------------
-- UI / テーマ (nord-vim + vim-airline)
-- ---------------------------------------------------------------------------

vim.cmd("colorscheme nord")
vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1
vim.g.nord_uniform_status_lines = 1
vim.g.nord_uniform_diff_background = 1

-- 背景透過
local transparent_groups = {
  "Normal", "NormalNC", "NormalFloat", "SignColumn",
  "EndOfBuffer", "LineNr", "CursorLineNr", "FoldColumn", "Folded"
}
for _, g in ipairs(transparent_groups) do
  vim.api.nvim_set_hl(0, g, { bg = "none", ctermbg = "none" })
end
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    for _, g in ipairs(transparent_groups) do
      vim.api.nvim_set_hl(0, g, { bg = "none", ctermbg = "none" })
    end
  end
})

-- vim-airline
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = "nord"
vim.g["airline#extensions#branch#enabled"] = 1
vim.g["airline#extensions#branch#displayed_head_limit"] = 20
