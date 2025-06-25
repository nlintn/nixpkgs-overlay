{ pkgs ? import <nixpkgs> {}, self ? builtins.getFlake (builtins.toString ./.) }:

let
    inputs = self.inputs;
in {
  nixln-edit = inputs.nixln-edit.packages.${pkgs.system}.nixln-edit;
  
  vimPlugins.battery-nvim = pkgs.callPackage ./packages/vimPlugins/battery-nvim.nix { };
  vimPlugins.isabelle-syn-nvim = pkgs.callPackage ./packages/vimPlugins/isabelle-syn-nvim.nix { };
  vimPlugins.telescope-tabs = pkgs.callPackage ./packages/vimPlugins/telescope-tabs.nix { };
}
