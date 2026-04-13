{
  description = "My macOS Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      treefmt-nix,
    }:
    let
      username = "develop";
      system = "aarch64-darwin";
      mkFormatter =
        sys:
        (treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${sys} {
          projectRootFile = "flake.nix";
          programs.nixfmt.enable = true;
        }).config.build.wrapper;
    in
    {
      formatter = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "x86_64-linux"
      ] mkFormatter;

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./modules/home-manager.nix ];
        extraSpecialArgs = { inherit username; };
      };
    };
}
