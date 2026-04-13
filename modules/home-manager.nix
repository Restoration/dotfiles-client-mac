{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./pkgs
  ];

  home.username = username;
  home.homeDirectory = lib.mkForce "/Users/${username}";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
  };

  home.packages = with pkgs; [
    lazydocker
    lazygit
    lazysql
    gcc
    vim
    neovim
    tmux
    google-cloud-sdk
    awscli2
    ranger
  ];
}
