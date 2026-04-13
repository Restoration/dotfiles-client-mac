{pkgs, ...}: {
  home.packages = with pkgs; [
    yarn
    pnpm
    bun
    pkgs.typescript
    pkgs.nodemon
    pkgs.serve
    pkgs.eslint
    pkgs.eas-cli
    # LSPツールのインストール
    pkgs.typescript-language-server
    # Playwright用
    playwright-driver.browsers
  ];
}