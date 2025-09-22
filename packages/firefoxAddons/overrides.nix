{ fetchSources
}:

final: prev:

{
  zen-internet = prev.zen-internet.overrideAttrs (p: {
    passthru = p.passthru // {
      styles = builtins.fromJSON (builtins.readFile "${fetchSources "https://github.com/sameerasw/my-internet"}/styles.json");
    };
  });
}
