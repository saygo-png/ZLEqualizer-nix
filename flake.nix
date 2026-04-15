{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    forEachSystem = function:
      nixpkgs.lib.genAttrs ["x86_64-linux"] (system: function nixpkgs.legacyPackages.${system});
  in {
    packages = forEachSystem (pkgs: rec {
      zlequalizer = pkgs.callPackage ./package.nix {};
      default = zlequalizer;
    });
  };
}
