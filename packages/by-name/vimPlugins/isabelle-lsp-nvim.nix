fetchSources:

{ lua51Packages
, neovimUtils
, writeText
}:

neovimUtils.buildNeovimPlugin rec {
  name = "isabelle-lsp.nvim";
  luaAttr = lua51Packages.buildLuarocksPackage rec {
    pname = name;
    version = "scm-1";
    src = fetchSources "https://github.com/Treeniks/isabelle-lsp.nvim";
    disabled = lua51Packages.lua.luaversion != "5.1";
    knownRockspec = writeText "isabelle-lsp.nvim-scm-1.rockspec" ''
      package = "${pname}"
      version = "${version}"
      source = {
        url = ""
      }
      dependencies = {
        "lua == 5.1",
      }
      build = {
        type = "builtin",
        modules = {
          ["isabelle-lsp"] = "lua/isabelle-lsp.lua",
        },
      }
    '';
  };
  nvimRequiredCheck = "isabelle-lsp";
}
