# dotfiles (macOS)

macOS 向け開発環境の設定ファイル。Neovim 設定は Lua で記述。

> **必要環境:** Neovim 0.11 以上（`vim.lsp.config` / `vim.lsp.enable` API を使用）

## ディレクトリ構成

```
lua/
├── init.lua              # 基本設定・キーマップ
└── plugins/
    ├── theme.lua         # カラースキーム (nord) + vim-airline
    ├── tree.lua          # ファイルツリー (nvim-tree)
    ├── lsp.lua           # LSP 設定 (nvim-lspconfig)
    ├── cmp.lua           # 補完エンジン (nvim-cmp + LuaSnip)
    ├── telescope.lua     # ファジーファインダー (telescope.nvim)
    ├── tagbar.lua        # タグバー (tagbar)
    ├── go.lua            # Go 開発 (vim-go)
    ├── typescript.lua    # TypeScript 開発 (typescript-tools.nvim)
    ├── lint.lua          # Linter (nvim-lint)
    ├── format.lua        # フォーマッター (conform.nvim)
    ├── trouble.lua       # 診断リスト (trouble.nvim)
    └── claude.lua        # Claude Code 連携 (claudecode.nvim)
```

## セットアップ

### 1. 設定ファイルのクローン

```bash
git clone git@github.com:Restoration/dotfiles-client-mac.git ~/.config/nvim
cd ~/.config/nvim
```

### 2. セットアップスクリプトの実行 (推奨)

macOS / Debian・Ubuntu / WSL2 に対応した一括セットアップスクリプトを用意している。OS を自動検出して、必要なパッケージ・言語ツール・lazy.nvim をまとめて導入する。

```bash
./setup.sh
```

オプション:

| オプション | 動作 |
|---|---|
| `--no-lang` | 言語ツール (Go / Python / Node) のインストールをスキップ |
| `--help`    | ヘルプを表示 |

スクリプトが行う処理:

- OS を自動検出 (macOS / Debian 系)
- macOS: `brew bundle` で Brewfile のパッケージを導入
- Debian 系: `apt` で基本パッケージ + Neovim 0.11+ (PPA から)
- 言語ツール: `gopls` / `gofumpt` / `goimports` / `delve` / `pyright` / `black` / `ruff` / `biome`
- `lazy.nvim` を `~/.local/share/nvim/lazy/lazy.nvim` にクローン

既にインストール済みのものは自動的にスキップされる (冪等)。

### 手動セットアップ (macOS)

スクリプトを使わない場合は以下を順に実行する。

```bash
brew bundle
go install golang.org/x/tools/cmd/goimports@latest
```

### 3. Neovim を起動してプラグインをインストール

```bash
nvim
```

lazy.nvim が自動で全プラグインをインストールする。ヘッドレスで一括取得したい場合は以下も使える。

```bash
nvim --headless '+Lazy! sync' +qa
```

### Windows での利用 (WSL2)

Windows でこの設定を使いたい場合は、まず WSL2 上に Linux 環境 (Ubuntu 推奨) を構築してから利用すること。WSL2 内で上記の `./setup.sh` を実行すれば、Neovim 本体・依存ツール・lazy.nvim まで一括でセットアップできる。

このリポジトリは macOS 向けの設定を想定しているため、Windows ネイティブ環境よりも WSL2 上での利用のほうが安定して動作しやすい。

### Brewfile に含まれるパッケージ (macOS)

| パッケージ | 用途 |
|---|---|
| neovim | エディタ本体 (0.11+) |
| go | Go 開発環境 |
| gopls | Go LSP サーバー |
| gofumpt | Go フォーマッター |
| delve | Go DAP デバッガー |
| pyright | Python LSP サーバー |
| black | Python フォーマッター |
| ruff | Python Linter |
| node | JavaScript / TypeScript ランタイム |
| biome | JS / TS / JSON フォーマッター・Linter |
| universal-ctags | タグバー用タグ生成 |
| lazygit | Git TUI クライアント |
| lazydocker | Docker TUI クライアント |
| lazysql | SQL TUI クライアント |
| pyenv | Python バージョン管理 |
| yazi | ターミナルファイルマネージャー |
| glow | Markdown ターミナルレンダラー |
| zsh | シェル |
| docker | コンテナランタイム |
| tmux | ターミナルマルチプレクサ |
| claude-code | Claude Code CLI |

## 主なプラグイン

| カテゴリ | プラグイン |
|---|---|
| UI | nord-vim, vim-airline |
| ファイルツリー | nvim-tree |
| ファジーファインダー | telescope.nvim |
| LSP | nvim-lspconfig (gopls, pyright) |
| 補完 | nvim-cmp, LuaSnip |
| フォーマット | conform.nvim |
| Lint | nvim-lint |
| Go | vim-go |
| TypeScript | typescript-tools.nvim |
| 診断 | trouble.nvim |
| AI | claudecode.nvim |

## キーマップ

`<leader>` は `Space`。

### 基本操作

| キー | 動作 |
|---|---|
| `<leader>tn` | 新しいタブ |
| `<leader>ex` | 終了 |
| `<leader>ps` | 水平分割 |
| `<leader>vs` | 垂直分割 |
| `<leader>te` | ターミナル |
| `<Esc><Esc>` | 検索ハイライト消去 |

### ファイルツリー

| キー | 動作 |
|---|---|
| `<leader>nt` | nvim-tree トグル |
| `<leader>e` | nvim-tree フォーカス |

### Telescope

| キー | 動作 |
|---|---|
| `<leader>ff` | ファイル検索 |
| `<leader>fg` | grep 検索 |
| `<leader>fb` | バッファ一覧 |
| `<leader>fh` | ヘルプタグ |
| `<leader>fd` | 診断一覧 |

### LSP

| キー | 動作 |
|---|---|
| `gd` | 定義へジャンプ |
| `gr` | 参照一覧 |
| `K` | ホバー表示 |
| `gi` | 実装へジャンプ |
| `<C-k>` | シグネチャヘルプ |
| `<leader>rn` | リネーム |
| `<leader>ca` | コードアクション |
| `<leader>f` | フォーマット |

### Claude Code

| キー | 動作 |
|---|---|
| `<leader>ac` | Claude トグル |
| `<leader>af` | Claude フォーカス |
| `<leader>ar` | セッション再開 |
| `<leader>aC` | セッション継続 |
| `<leader>ab` | 現在バッファを追加 |
| `<leader>as` | 選択範囲を送信 / nvim-tree からファイル追加 |
| `<leader>am` | モデル選択 |
| `<leader>aS` | ステータス確認 |

## フォーマッター対応言語

| 言語 | ツール |
|---|---|
| Go | goimports, gofumpt |
| JavaScript / TypeScript | biome |
| Python | black |
