#!/usr/bin/env bash
#
# Neovim 環境セットアップスクリプト
#
# 対応 OS:
#   - macOS (Homebrew 経由)
#   - Debian / Ubuntu / WSL2 (apt 経由)
#
# 使い方:
#   ./setup.sh           # 全部実行
#   ./setup.sh --no-lang # 言語ツール (go/python/node) のインストールをスキップ

set -euo pipefail

SKIP_LANG=0
for arg in "$@"; do
  case "$arg" in
    --no-lang) SKIP_LANG=1 ;;
    -h|--help)
      sed -n '3,12p' "$0"
      exit 0
      ;;
    *) echo "unknown option: $arg" >&2; exit 1 ;;
  esac
done

log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!! \033[0m %s\n' "$*"; }
err()  { printf '\033[1;31mXX \033[0m %s\n' "$*" >&2; }

have() { command -v "$1" >/dev/null 2>&1; }

detect_os() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux)
      if [ -f /etc/os-release ] && grep -qiE 'ubuntu|debian' /etc/os-release; then
        echo "debian"
      else
        echo "linux-other"
      fi
      ;;
    *) echo "unknown" ;;
  esac
}

check_nvim_version() {
  if ! have nvim; then
    return 1
  fi
  local v
  v=$(nvim --version | head -1 | sed -E 's/^NVIM v?([0-9]+\.[0-9]+).*/\1/')
  local major minor
  major=${v%.*}
  minor=${v#*.}
  if [ "$major" -gt 0 ] || { [ "$major" -eq 0 ] && [ "$minor" -ge 11 ]; }; then
    return 0
  fi
  return 1
}

install_macos() {
  if ! have brew; then
    err "Homebrew が見つかりません。https://brew.sh からインストールしてください。"
    exit 1
  fi
  log "brew bundle で Brewfile のパッケージをインストール"
  brew bundle --file="$(dirname "$0")/Brewfile"
}

install_debian() {
  log "apt update"
  sudo apt-get update -y

  log "ベースパッケージをインストール"
  sudo apt-get install -y \
    software-properties-common \
    build-essential \
    curl \
    git \
    unzip \
    ripgrep \
    fd-find \
    universal-ctags \
    tmux

  if ! check_nvim_version; then
    log "Neovim 0.11+ を PPA からインストール"
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt-get update -y
    sudo apt-get install -y neovim
  else
    log "Neovim 0.11+ はインストール済み (skip)"
  fi

  if [ "$SKIP_LANG" -eq 0 ]; then
    log "言語ランタイム (Go / Node / Python) をインストール"
    sudo apt-get install -y \
      golang-go \
      nodejs \
      npm \
      python3-pip \
      python3-venv
  fi
}

install_lang_tools() {
  [ "$SKIP_LANG" -eq 1 ] && { log "言語ツールをスキップ (--no-lang)"; return; }

  if have go; then
    log "Go ツール (gopls / gofumpt / goimports / delve)"
    GOBIN_DIR="${GOBIN:-$HOME/go/bin}"
    mkdir -p "$GOBIN_DIR"
    go install golang.org/x/tools/gopls@latest
    go install mvdan.cc/gofumpt@latest
    go install golang.org/x/tools/cmd/goimports@latest
    go install github.com/go-delve/delve/cmd/dlv@latest
    case ":$PATH:" in
      *":$GOBIN_DIR:"*) ;;
      *) warn "$GOBIN_DIR が PATH に含まれていません。シェル設定に追加してください。" ;;
    esac
  else
    warn "go が無いため Go ツールをスキップ"
  fi

  if have pip3; then
    log "Python ツール (pyright / black / ruff)"
    pip3 install --user --upgrade pyright black ruff || \
      warn "pip install に失敗。--break-system-packages や venv が必要かもしれません。"
  elif have pip; then
    log "Python ツール (pyright / black / ruff)"
    pip install --user --upgrade pyright black ruff
  else
    warn "pip が無いため Python ツールをスキップ"
  fi

  if have npm; then
    log "JS/TS ツール (biome)"
    if [ -w "$(npm prefix -g)/lib" ] 2>/dev/null; then
      npm install -g @biomejs/biome
    else
      sudo npm install -g @biomejs/biome
    fi
  else
    warn "npm が無いため biome をスキップ"
  fi
}

install_lazy_nvim() {
  local dest="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/lazy/lazy.nvim"
  if [ -d "$dest" ]; then
    log "lazy.nvim は既に存在 (skip): $dest"
    return
  fi
  log "lazy.nvim を clone: $dest"
  git clone --filter=blob:none --branch=stable \
    https://github.com/folke/lazy.nvim "$dest"
}

verify_config_location() {
  local cfg="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
  if [ ! -f "$cfg/lua/init.lua" ] && [ ! -f "$cfg/init.lua" ]; then
    warn "$cfg にこのリポジトリの設定が見つかりません。"
    warn "  git clone <this repo> $cfg  を実行してから再度このスクリプトを動かしてください。"
  fi
}

main() {
  local os
  os=$(detect_os)
  log "検出した OS: $os"

  case "$os" in
    macos)  install_macos ;;
    debian) install_debian ;;
    *)
      err "対応していない OS です。手動でセットアップしてください。"
      exit 1
      ;;
  esac

  install_lang_tools
  install_lazy_nvim
  verify_config_location

  log "完了。 'nvim' を起動するとプラグインの初回取得が始まります。"
  log "  確認コマンド: nvim --headless '+Lazy! sync' +qa  (ヘッドレスで一括取得)"
}

main "$@"
