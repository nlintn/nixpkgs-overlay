lib:

let
  toNByteHexString =
    n: dec:
    let
      hexSuffix = lib.toHexString dec;
    in
    lib.concatStrings (lib.genList (lib.const "0") (n * 2 - lib.stringLength hexSuffix)) + hexSuffix;
in
rec {
  decToRGB = dec: {
    r = lib.bitAnd 255 (dec / 65536);
    g = lib.bitAnd 255 (dec / 256);
    b = lib.bitAnd 255 dec;
    __toString =
      self:
      let
        inherit (self) r g b;
      in
      "${toString r},${toString g},${toString b}";
  };
  decToARGB =
    dec:
    let
      rgb = (decToRGB (lib.bitAnd 16777215 dec));
    in
    rgb
    // {
      a = dec / 16777216;
      __toString =
        self:
        let
          inherit (self) a;
        in
        "${toString a},${toString rgb}";
    };
  decToRGBA =
    dec:
    let
      rgb = (decToRGB (dec / 256));
    in
    rgb
    // {
      a = lib.bitAnd 255 dec;
      __toString =
        self:
        let
          inherit (self) a;
        in
        "${toString rgb},${toString a}";
    };

  hexToRGB = hex: decToRGB (lib.fromHexString hex);
  hexToARGB = hex: decToARGB (lib.fromHexString hex);
  hexToRGBA = hex: decToRGBA (lib.fromHexString hex);

  rgbToDec = rgb: (rgb.r or 0 * 65536 + rgb.g or 0 * 256 + rgb.b or 0);
  argbToDec = rgba: rgbToDec rgba + rgba.a or 0 * 16777216;
  rgbaToDec = rgba: rgbToDec rgba * 256 + rgba.a or 0;

  rgbToHex = rgb: toNByteHexString 3 (rgbToDec rgb);
  argbToHex = rgb: toNByteHexString 4 (argbToDec rgb);
  rgbaToHex = rgb: toNByteHexString 4 (rgbaToDec rgb);
}
