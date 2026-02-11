fetchSources: _:

{
  lib,
  vimPlugins,
  vimUtils,
}:

vimUtils.buildVimPlugin {
  pname = "compile-mode.nvim";
  version = "latest";
  src = fetchSources "https://github.com/ej-shafran/compile-mode.nvim";
  dependencies = with vimPlugins; [
    plenary-nvim
  ];
  meta = {
    description = "A plugin for Neovim inspired by Emacs' Compilation Mode";
    homepage = "https://github.com/ej-shafran/compile-mode.nvim";
    license = lib.licenses.unlicense;
  };
}
