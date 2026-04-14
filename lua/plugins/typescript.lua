-- ---------------------------------------------------------------------------
-- TypeScript開発 (typescript-tools.nvim + nvim-ts-autotag)
-- ---------------------------------------------------------------------------

-- typescript-tools.nvim
-- ts_ls (tsserver LSP) より高速な直接通信プロトコル実装
require("typescript-tools").setup({
  settings = {
    -- コード補完でimportを自動追加
    complete_function_calls                  = true,
    include_completions_with_insert_text     = true,

    -- tsserver のメモリ上限 (MB)
    tsserver_max_memory                      = "auto",

    -- expose_as_code_action で使える追加アクション
    expose_as_code_action = {
      "fix_all",
      "add_missing_imports",
      "remove_unused",
      "remove_unused_imports",
      "organize_imports",
    },
  },

  -- LSP keymapは lsp.lua の LspAttach に委譲
  on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- TypeScript 固有のコードアクション
    vim.keymap.set("n", "<leader>to",
      "<cmd>TSToolsOrganizeImports<CR>",
      vim.tbl_extend("force", opts, { desc = "TS: Organize imports" }))
    vim.keymap.set("n", "<leader>ta",
      "<cmd>TSToolsAddMissingImports<CR>",
      vim.tbl_extend("force", opts, { desc = "TS: Add missing imports" }))
    vim.keymap.set("n", "<leader>tu",
      "<cmd>TSToolsRemoveUnusedImports<CR>",
      vim.tbl_extend("force", opts, { desc = "TS: Remove unused imports" }))
    vim.keymap.set("n", "<leader>tf",
      "<cmd>TSToolsFixAll<CR>",
      vim.tbl_extend("force", opts, { desc = "TS: Fix all" }))
    vim.keymap.set("n", "<leader>tr",
      "<cmd>TSToolsRenameFile<CR>",
      vim.tbl_extend("force", opts, { desc = "TS: Rename file" }))
    vim.keymap.set("n", "<leader>td",
      "<cmd>TSToolsGoToSourceDefinition<CR>",
      vim.tbl_extend("force", opts, { desc = "TS: Go to source definition" }))
  end,
})

-- ---------------------------------------------------------------------------
-- nvim-ts-autotag
-- JSX / TSX のタグ自動補完・自動リネーム
-- ---------------------------------------------------------------------------

require("nvim-ts-autotag").setup({
  opts = {
    enable_close          = true,   -- タグ自動クローズ
    enable_rename         = true,   -- 開/閉タグの同時リネーム
    enable_close_on_slash = true,   -- </... で閉じタグ補完
  },
})
