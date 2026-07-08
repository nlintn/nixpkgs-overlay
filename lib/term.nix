lib:

let
  codeColBase = {
    fg = 30;
    bg = 40;
  };
  codeColBrightBase = {
    fg = 90;
    bg = 100;
  };
  codeColCustom = {
    fg = 38;
    bg = 48;
  };
  codeCol256 = 5;
  codeColRgb = 2;

  colCodeOffsets = {
    black = 0;
    red = 1;
    green = 2;
    yellow = 3;
    blue = 4;
    magenta = 5;
    cyan = 6;
    white = 7;
    default = 9;
  };

  modCodes = {
    reset = 0;
    bold = 1;
    dim = 2;
    italic = 3;
    underline = 4;
    blinking = 5;
    inverse = 7;
    hidden = 8;
    strikethrough = 9;
  };

  modeTemplate = codes: "\\e[${lib.concatStringsSep ";" (lib.map toString codes)}m";

  genColCodes = lib.genAttrs [ "fg" "bg" ] (
    x: col_arg:
    let
      inherit
        (
          if lib.isAttrs col_arg then
            {
              type = col_arg.type or (throw "missing key 'type'");
              val = col_arg.val or (throw "missing key 'val'");
            }
          else
            {
              type =
                if lib.isString col_arg then
                  if lib.elem col_arg (lib.attrNames colCodeOffsets) then "normal" else "hex"
                else if lib.isInt col_arg then
                  "256"
                else
                  throw "cannot convert ${toString col_arg} of type ${lib.typeOf col_arg} to color";
              val = col_arg;
            }
        )
        type
        val
        ;
    in
    if type == "normal" || type == "bright" then
      [
        (
          (if type == "normal" then codeColBase.${x} else codeColBrightBase.${x})
          + (colCodeOffsets.${val} or (throw "no color ${val}"))
        )
      ]
    else if type == "256" then
      [
        codeColCustom.${x}
        codeCol256
        val
      ]
    else if type == "hex" then
      let
        inherit (lib.conversions.hexToRGB val) r g b;
      in
      [
        codeColCustom.${x}
        codeColRgb
        r
        g
        b
      ]
    else if type == "rgb" then
      let
        inherit (val) r g b;
      in
      [
        codeColCustom.${x}
        codeColRgb
        r
        g
        b
      ]
    else
      throw "unknown type ${type}"
  );
in
{
  set =
    {
      fg ? null,
      bg ? null,
      mods ? [ ],
    }:
    modeTemplate (
      (lib.map (mod: modCodes.${mod}) mods)
      ++ lib.optionals (fg != null) (genColCodes.fg fg)
      ++ lib.optionals (bg != null) (genColCodes.bg bg)
    );
  fg = col: lib.term.set { fg = col; };
  bg = col: lib.term.set { bg = col; };
  fgBold =
    col:
    lib.term.set {
      fg = col;
      mods = [ "bold" ];
    };
  bgBold =
    col:
    lib.term.set {
      bg = col;
      mods = [ "bold" ];
    };
  mod = lib.mapAttrs (_: v: modeTemplate [ v ]) modCodes;
  reset = lib.term.mod.reset;
}
