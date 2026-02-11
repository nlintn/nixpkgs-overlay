fetchSources: _:

{
  lib,
  vimPlugins,
  vimUtils,
}:

vimUtils.buildVimPlugin {
  pname = "battery.nvim";
  version = "latest";
  src = fetchSources "https://github.com/justinhj/battery.nvim";
  dependencies = with vimPlugins; [
    plenary-nvim
  ];
  meta = {
    description = "Neovim plugin to detect and view battery information";
    homepage = "https://github.com/justinhj/battery.nvim";
    license = lib.licenses.mit;
  };
}
