fetchSources: prev:

{ }:

prev.vimPlugins.isabelle-lsp-nvim.overrideAttrs {
  src = fetchSources "https://github.com/nlintn/isabelle-lsp.nvim";
}
