vim.scriptencoding = "utf-8"

local opt = vim.opt
opt.number       = true
opt.mouse        = "a"
opt.ambiwidth    = "double"
opt.tabstop      = 2
opt.expandtab    = true
opt.shiftwidth   = 2
opt.smartindent  = true
opt.list         = true
opt.listchars    = { tab = "»-", trail = "-", extends = "»", precedes = "«", nbsp = "%" }
opt.nrformats    = { "bin", "octal", "hex" }
opt.virtualedit  = "block"
opt.whichwrap:append("b,s,[,],<,>")
opt.backspace    = { "indent", "eol", "start" }
opt.wrapscan     = true
opt.showmatch    = true
opt.wildmenu     = true
opt.formatoptions:append("mM")
opt.cursorline   = true
opt.clipboard    = "unnamedplus"
opt.backup       = false
opt.wrap         = true

vim.g.mapleader = " "

local map = vim.keymap.set
map("n", ":tn",        "<cmd>tabnew<CR>",           { noremap = true })
map("n", ":ex",        "<cmd>exit<CR>",              { noremap = true })
map("n", ":ps",        "<cmd>split<CR>",             { noremap = true })
map("n", ":vs",        "<cmd>vsplit<CR>",            { noremap = true })
map("n", ":te",        "<cmd>terminal<CR>",          { noremap = true })
map("n", "<Esc><Esc>", "<cmd>nohlsearch<CR><Esc>",  { noremap = true, silent = true })
map("n", "j",          "gj",                         { noremap = true })
map("n", "k",          "gk",                         { noremap = true })
map("n", "<Down>",     "gj",                         { noremap = true })
map("n", "<Up>",       "gk",                         { noremap = true })

-- プラグイン設定を読み込む
require("plugins.theme")
require("plugins.tree")
require("plugins.lsp")
require("plugins.cmp")
require("plugins.telescope")
require("plugins.tagbar")
require("plugins.go")
require("plugins.typescript")
require("plugins.lint")
require("plugins.format")
require("plugins.trouble")
require("plugins.claude")
