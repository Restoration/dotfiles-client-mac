{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.zsh-history-substring-search;
        file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
      }
    ];

    shellAliases = {
      check_nodem = "find . -name 'node_modules' -type d -prune -print | xargs du -chs";
      clean_dsstore = "sudo find . -name '.DS_Store' -print -delete";
      clean_nodem = "find . -name 'node_modules' -type d -prune -print -exec rm -rf '{}' \\;";
      ldocker = "lazydocker";
      lgit = "lazygit";
      ll = "ls -l";
      lsql = "lazysql";
      r = "ranger";
      nix-rebuild = "home-manager switch --flake ~/.config/nix";
      v = "vim";
    };

    sessionVariables = {
      PYENV_ROOT = "$HOME/.pyenv";
      BUN_INSTALL = "$HOME/.bun";
      PATH = "$HOME/.local/bin:$BUN_INSTALL/bin:$GOPATH/bin:$PATH";
    };

    initContent = ''
      eval "$(pyenv init -)"
    '';
  };
}
