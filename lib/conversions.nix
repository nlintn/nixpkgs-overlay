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
      "rgb(${toString r},${toString g},${toString b})";
  };
  decAToARGB =
    dec: a:
    let
      rgb = decToRGB dec;
    in
    rgb
    // {
      inherit a;
      __toString =
        self:
        let
          inherit (self)
            a
            r
            g
            b
            ;
        in
        "argb(${toString a},${toString r},${toString g},${toString b})";
    };
  decToARGB = dec: decToRGB (lib.bitAnd 16777215 dec) (dec / 16777216 / 255.0);
  decAToRGBA =
    dec: a:
    let
      rgb = decToRGB dec;
    in
    rgb
    // {
      inherit a;
      __toString =
        self:
        let
          inherit (self)
            r
            g
            b
            a
            ;
        in
        "rgba(${toString r},${toString g},${toString b},${toString a})";
    };
  decToRGBA = dec: decAToRGBA (dec / 256) (lib.bitAnd 255 dec / 255.0);

  hexToRGB = hex: decToRGB (lib.fromHexString hex);
  hexAToARGB = hex: decAToARGB (lib.fromHexString hex);
  hexToARGB = hex: decToARGB (lib.fromHexString hex);
  hexAToRGBA = hex: decAToRGBA (lib.fromHexString hex);
  hexToRGBA = hex: decToRGBA (lib.fromHexString hex);

  rgbToDec = rgb: (rgb.r or 0 * 65536 + rgb.g or 0 * 256 + rgb.b or 0);
  argbToDec = rgba: rgbToDec rgba + lib.floor (rgba.a or 0 * 255) * 16777216;
  rgbaToDec = rgba: rgbToDec rgba * 256 + lib.floor (rgba.a or 0 * 255);

  rgbToHex = rgb: toNByteHexString 3 (rgbToDec rgb);
  argbToHex = rgb: toNByteHexString 4 (argbToDec rgb);
  rgbaToHex = rgb: toNByteHexString 4 (rgbaToDec rgb);
}
