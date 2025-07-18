{ pkgs ? import <nixpkgs> {}, self ? builtins.getFlake (builtins.toString ./..) }:

let
    inputs = self.inputs;
in {
  nixln-edit = inputs.nixln-edit.packages.${pkgs.system}.nixln-edit;
  
  vimPlugins.battery-nvim = pkgs.callPackage ./vimPlugins/battery-nvim.nix { };
  vimPlugins.isabelle-syn-nvim = pkgs.callPackage ./vimPlugins/isabelle-syn-nvim.nix { };
  vimPlugins.telescope-tabs = pkgs.callPackage ./vimPlugins/telescope-tabs.nix { };
}
