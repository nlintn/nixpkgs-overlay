fetchSources: _:

{
  lua51Packages,
  neovimUtils,
  writeText,
}:

neovimUtils.buildNeovimPlugin rec {
  name = "compile-mode.nvim";
  luaAttr = lua51Packages.buildLuarocksPackage rec {
    pname = name;
    version = "scm-1";
    src = fetchSources "https://github.com/ej-shafran/compile-mode.nvim";
    disabled = lua51Packages.lua.luaversion != "5.1";
    knownRockspec = writeText "${pname}-${version}.rockspec" ''
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
          ["compile-mode"] = "lua/compile-mode/init.lua",
        },
        copy_directories = {
          "doc",
          "ftplugin",
          "plugin",
        }
      }
    '';
  };
  nvimRequiredCheck = "compile-mode";
}
