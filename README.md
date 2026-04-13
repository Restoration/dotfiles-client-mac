# macOS / Linux Dotfiles

Nix Flakes + Home Manager を使った macOS (Apple Silicon / Intel) および Linux (Intel PC) 環境設定。

## セットアップ

### 1. Nix のインストール

Apple Silicon と Linux では以下のインストールコマンドが使えます。

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Intel Mac (x86_64-darwin) は上記の Determinate Systems インストーラでは未サポートです。その場合は公式インストーラを使ってください。

```bash
curl -L https://nixos.org/nix/install | sh
```

インストール後、ターミナルを再起動する。

### 2. リポジトリのクローン

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
