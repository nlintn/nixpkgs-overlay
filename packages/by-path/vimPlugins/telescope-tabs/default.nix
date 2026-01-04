fetchSources:
_:

{ lua51Packages
, neovimUtils
, writeText
}:

neovimUtils.buildNeovimPlugin rec {
  name = "telescope-tabs";
  luaAttr = lua51Packages.buildLuarocksPackage rec {
    pname = name;
    version = "scm-1";
    src = fetchSources "https://github.com/LukasPietzschmann/telescope-tabs";
    propagatedBuildInputs = with lua51Packages; [ telescope-nvim ];
    disabled = lua51Packages.lua.luaversion != "5.1";
    knownRockspec = writeText "${pname}-${version}.rockspec" ''
      package = "${pname}"
      version = "${version}"
      source = {
        url = ""
      }
      dependencies = {
        "lua == 5.1",
        "telescope.nvim",
      }
      build = {
        type = "builtin",
        modules = {
          ["telescope-tabs"] = "lua/telescope-tabs.lua",
        },
      }
    '';
  };
  nvimRequiredCheck = "telescope-tabs";
}
