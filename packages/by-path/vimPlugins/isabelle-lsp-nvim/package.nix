fetchSources: _:

{
  lib,
  vimUtils,
}:

vimUtils.buildVimPlugin {
  pname = "isabelle-lsp.nvim";
  version = "latest";
  src = fetchSources "https://github.com/nlintn/isabelle-lsp.nvim";
  meta = {
    homepage = "https://github.com/nlintn/isabelle-lsp.nvim";
    license = lib.licenses.mit;
  };
}
