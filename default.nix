let
  recursiveExtend = base: override:
    builtins.mapAttrs (n: v: if base ? ${n} && base.${n} ? extend then base.${n}.extend (final: prev: recursiveExtend prev v) else v) override;
in final: prev: recursiveExtend prev (import ./packages { pkgs = prev; })
