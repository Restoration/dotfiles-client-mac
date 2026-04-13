{ pkgs, ... }:
{
  imports = [
    ./homebrew
  ];
  system.primaryUser = "develop";
  nixpkgs.config.allowUnfree = true;
  nix.enable = false;
  system.defaults = {
    finder.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
  };
  system.stateVersion = 4;
}
