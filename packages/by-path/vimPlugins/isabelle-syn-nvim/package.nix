fetchSources: _:

{
  lib,
  vimUtils,
}:

vimUtils.buildVimPlugin {
  pname = "isabelle-syn.nvim";
  version = "latest";
  src = fetchSources "https://github.com/Treeniks/isabelle-syn.nvim";
  meta = {
    homepage = "https://github.com/Treeniks/isabelle-syn.nvim";
    license = lib.licenses.mit;
  };
}
