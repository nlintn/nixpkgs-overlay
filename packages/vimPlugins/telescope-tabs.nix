{ fetchFromGitHub
, lua51Packages
, neovimUtils
, writeText
}:

neovimUtils.buildNeovimPlugin {
  luaAttr = lua51Packages.buildLuarocksPackage rec {
    pname = "telescope-tabs";
    version = "scm-1";
    src = fetchFromGitHub {
      owner = "LukasPietzschmann";
      repo = "telescope-tabs";
      rev = "9ca0800d4e9c2610d5cac4d121cde0d9fbd89a64";
      sha256 = "sha256-++iTyrjl6IX2GmwljbgcwiYvZ3ghsX732VWMcyu1ciw=";
    };
    propagatedBuildInputs = with lua51Packages; [ telescope-nvim ];
    knownRockspec = writeText "${pname}-${version}.rockspec" ''
      package = "${pname}"
      version = "${version}"
      source = {
        url = "git://github.com/${src.owner}/${src.repo}.git",
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
