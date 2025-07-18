lib:

{
  evalBinds = mainMod: modifiers: binds: (
    builtins.map (bind: (
      mainMod + (
        if (lib.foldl (acc: mod: acc || (lib.hasPrefix mod bind)) false modifiers) then " " else ", "
      ) + bind)
    ) binds
  );
}
