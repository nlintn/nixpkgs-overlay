lib:

lib.fix (
  self:
  let
    lib' = lib // self;
  in
  import ./base.nix lib'
  // {
    hyprland = import ./hyprland lib';
  }
)
