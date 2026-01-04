fetchSources:
prev:

{}:

prev.vimPlugins.nvim-treesitter-textobjects.overrideAttrs {
  src = fetchSources "https://github.com/nvim-treesitter/nvim-treesitter-textobjects";
}
