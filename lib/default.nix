lib:

let
  main = {
    capitalizeString = str: (
      (lib.toUpper (lib.substring 0 1 str))
      +
      (lib.substring 1 ((lib.stringLength str) - 1) str)
    );
  };
  lib' = lib // main;
in main // {
  hyprland = import ./hyprland lib';
}
