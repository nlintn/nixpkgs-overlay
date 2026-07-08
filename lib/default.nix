lib:

lib.fix (
  self:
  let
    lib' = lib // self;
  in
  import ./base.nix lib'
  // {
    conversions = import ./conversions.nix lib';
    hyprland = import ./hyprland lib';
    term = import ./term.nix lib';
  }
)
