-- ---------------------------------------------------------------------------
-- Claude Code Neovim IDE Extension (coder/claudecode.nvim)
-- https://github.com/coder/claudecode.nvim
--
-- VSCode拡張と同じWebSocket MCPプロトコルを実装したNeovimプラグイン。
-- Pure Lua・依存ゼロ。snacks.nvim があるとターミナルUIが強化される。
-- ---------------------------------------------------------------------------

require("claudecode").setup({
  -- -----------------------------------------------------------------
  -- Server
  -- -----------------------------------------------------------------
  port_range  = { min = 10000, max = 65535 },
  auto_start  = true,   -- Neovim起動時にWebSocketサーバーを自動開始
  log_level   = "info", -- "trace"|"debug"|"info"|"warn"|"error"

  -- claude CLIのパス（nixpkgsにない場合はフルパスを指定）
  -- terminal_cmd = vim.fn.expand("~/.claude/local/claude"),
  terminal_cmd = nil,   -- nilのとき PATH上の "claude" を使用

  -- -----------------------------------------------------------------
  -- 挙動
  -- -----------------------------------------------------------------
  focus_after_send         = true,  -- 送信後にClaudeターミナルにフォーカス
  track_selection          = true,  -- ビジュアル選択をClaudeに自動追跡
  visual_demotion_delay_ms = 50,

  -- -----------------------------------------------------------------
  -- ターミナルウィンドウ
  -- -----------------------------------------------------------------
  terminal = {
    split_side             = "right",  -- "left" | "right"
    split_width_percentage = 0.38,     -- 画面幅の38%
    provider               = "native", -- snacks.nvimがない環境ではnativeが安定
    auto_close             = true,     -- Claude終了時にウィンドウを閉じる
  },
})

-- -----------------------------------------------------------------
-- キーマップ（<leader>a プレフィックスで統一）
-- -----------------------------------------------------------------
local map = vim.keymap.set
local o   = { noremap = true, silent = true }

-- 起動・フォーカス
map("n", "<leader>ac", "<cmd>ClaudeCode<cr>",           vim.tbl_extend("force", o, { desc = "Toggle Claude" }))
map("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>",      vim.tbl_extend("force", o, { desc = "Focus Claude" }))

-- セッション継続
map("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   vim.tbl_extend("force", o, { desc = "Resume Claude" }))
map("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", vim.tbl_extend("force", o, { desc = "Continue Claude" }))

-- コンテキスト追加
map("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       vim.tbl_extend("force", o, { desc = "Add current buffer" }))
map("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>",        vim.tbl_extend("force", o, { desc = "Send selection" }))

-- nvim-tree上でファイルをClaudeに追加
map("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>",     vim.tbl_extend("force", o, { desc = "Add file (nvim-tree)" }))

-- モデル選択・ステータス確認
map("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", vim.tbl_extend("force", o, { desc = "Select model" }))
map("n", "<leader>aS", "<cmd>ClaudeCodeStatus<cr>",      vim.tbl_extend("force", o, { desc = "Claude status" }))

-- diff操作（Claudeがファイル変更を提案したとき）
-- :w  → 変更を承認 / da → 承認（専用）
-- :q  → 変更を却下 / dq → 却下（専用）
