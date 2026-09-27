lib:

rec {
  evalBinds =
    mainMod: modifiers: binds:
    (lib.map (
      bind:
      (
        mainMod
        + (if (lib.foldl (acc: mod: acc || (lib.hasPrefix mod bind)) false modifiers) then " " else ", ")
        + bind
      )
    ) binds);

  mkBinds = lib.map (
    {
      keys,
      dispatcher,
      flags ? { },
    }:
    {
      _args = [
        keys
        (lib.generators.mkLuaInline dispatcher)
        flags
      ];
    }
  );
  mkBindsExec =
    binds:
    mkBinds (
      lib.mapAttrsToList (n: v: {
        keys = n;
        dispatcher = "hl.dsp.exec_cmd(\"${v}\")";
      }) binds
    );

  mkEnv = lib.mapAttrsToList (
    n: v: {
      _args = [
        n
        v
      ];
    }
  );
}
