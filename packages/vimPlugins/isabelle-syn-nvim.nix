fetchSources:

{ vimUtils
}:

vimUtils.buildVimPlugin {
  name = "isabelle-syn.nvim";
  src = fetchSources "https://github.com/Treeniks/isabelle-syn.nvim";
}
