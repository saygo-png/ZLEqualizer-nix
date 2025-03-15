{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
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
