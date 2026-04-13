# macOS / Linux Dotfiles

Nix Flakes + Home Manager を使った macOS および Linux (Intel PC) 環境設定。

## セットアップ

### 1. Nix のインストール

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

この公式インストーラは Intel Mac / Apple Silicon の両方に対応しています。Intel Mac でも同じコマンドで実行できます。

インストール後、ターミナルを再起動する。

### 2. Homebrew のインストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 3. リポジトリのクローン

```bash
git clone git@github.com:Restoration/dotfiles-client-mac.git ~/.config/nix
cd ~/.config/nix
```

### 4. username の変更

`flake.nix` の以下の箇所を自分の環境に合わせて変更する。

```nix
let
  username = "develop";  # Linux / macOS のログインユーザー名
in
```

### 5. 初回設定反映

```bash
home-manager switch --flake ~/.config/nix
```

### 6. 以降の設定反映

```bash
home-manager switch --flake ~/.config/nix
```

## HHKB

HHKB Professional の設定ファイルは `HHKB/` に格納。ドライバは以下からダウンロード。

https://happyhackingkb.com/jp/download/macdownload.html
