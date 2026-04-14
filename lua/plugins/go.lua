-- ---------------------------------------------------------------------------
-- Go開発 (go.nvim + nvim-dap + nvim-dap-go + nvim-dap-ui)
-- ---------------------------------------------------------------------------

-- go.nvim
require("go").setup({
  go              = "go",
  goimports       = "gopls",
  gofmt           = "gofumpt",
  lsp_cfg         = false,  -- lsp.lua側のlspconfigで管理
  lsp_gofumpt     = true,
  lsp_on_attach   = false,
  dap_debug       = true,
  dap_debug_gui   = true,
  test_runner     = "go",
  run_in_floaterm = false,
  lsp_document_formatting = true,
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>gr",  "<cmd>GoRun<CR>",        opts)
vim.keymap.set("n", "<leader>gt",  "<cmd>GoTest<CR>",       opts)
vim.keymap.set("n", "<leader>gtf", "<cmd>GoTestFunc<CR>",   opts)
vim.keymap.set("n", "<leader>gb",  "<cmd>GoBuild<CR>",      opts)
vim.keymap.set("n", "<leader>gi",  "<cmd>GoImpl<CR>",       opts)
vim.keymap.set("n", "<leader>gfs", "<cmd>GoFillStruct<CR>", opts)
vim.keymap.set("n", "<leader>gat", "<cmd>GoAddTag<CR>",     opts)
vim.keymap.set("n", "<leader>grt", "<cmd>GoRmTag<CR>",      opts)
vim.keymap.set("n", "<leader>ga",  "<cmd>GoAlt<CR>",        opts)
vim.keymap.set("n", "<leader>gc",  "<cmd>GoCoverage<CR>",   opts)

-- 保存時に goimports 自動実行
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern  = "*.go",
  callback = function()
    require("go.format").goimports()
  end,
})

-- ---------------------------------------------------------------------------
-- nvim-dap (デバッガ基盤)
-- ---------------------------------------------------------------------------

local dap  = require("dap")

vim.keymap.set("n", "<F5>",       dap.continue,          opts)
vim.keymap.set("n", "<F10>",      dap.step_over,         opts)
vim.keymap.set("n", "<F11>",      dap.step_into,         opts)
vim.keymap.set("n", "<F12>",      dap.step_out,          opts)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opts)
vim.keymap.set("n", "<leader>dr", dap.repl.open,  opts)
vim.keymap.set("n", "<leader>dl", dap.run_last,   opts)

-- ---------------------------------------------------------------------------
-- nvim-dap-go (delveアダプター)
-- ---------------------------------------------------------------------------

require("dap-go").setup({
  dap_configurations = {
    {
      type    = "go",
      name    = "Debug (current file)",
      request = "launch",
      program = "${file}",
    },
    {
      type    = "go",
      name    = "Debug (test file)",
      request = "launch",
      mode    = "test",
      program = "${file}",
    },
  },
})

vim.keymap.set("n", "<leader>dgt", function() require("dap-go").debug_test() end,      opts)
vim.keymap.set("n", "<leader>dgl", function() require("dap-go").debug_last_test() end, opts)

-- ---------------------------------------------------------------------------
-- nvim-dap-ui
-- ---------------------------------------------------------------------------

local dapui = require("dapui")
dapui.setup()

-- デバッグ開始/終了でUIを自動開閉
dap.listeners.after.event_initialized["dapui_config"]  = function() dapui.open()  end
dap.listeners.before.event_terminated["dapui_config"]  = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"]      = function() dapui.close() end

vim.keymap.set("n", "<leader>du", dapui.toggle, opts)
