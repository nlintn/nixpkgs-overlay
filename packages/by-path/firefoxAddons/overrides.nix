{
  fetchSources,
  lib,
}:

final: prev:

{
  zen-internet = prev.zen-internet.overrideAttrs (p: {
    passthru = p.passthru // {
      styles = lib.strings.fromJSON (
        lib.readFile "${fetchSources "https://github.com/sameerasw/my-internet"}/styles.json"
      );
    };
  });
}
