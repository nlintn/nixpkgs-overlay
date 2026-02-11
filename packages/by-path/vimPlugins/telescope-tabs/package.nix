fetchSources: _:

{
  lib,
  vimPlugins,
  vimUtils,
}:

vimUtils.buildVimPlugin {
  pname = "telescope-tabs";
  version = "latest";
  src = fetchSources "https://github.com/LukasPietzschmann/telescope-tabs";
  dependencies = with vimPlugins; [
    plenary-nvim
    telescope-nvim
  ];
  meta = {
    description = "Fly through your tabs in NeoVim ✈️";
    homepage = "https://github.com/LukasPietzschmann/telescope-tabs";
    license = lib.licenses.bsd3;
  };
}
