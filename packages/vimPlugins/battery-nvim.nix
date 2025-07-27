fetchSources:

{ acpi
, lua51Packages
, neovimUtils
, writeText
}:

neovimUtils.buildNeovimPlugin {
  luaAttr = lua51Packages.buildLuarocksPackage rec {
    pname = "battery.nvim";
    version = "scm-1";
    src = fetchSources "https://github.com/justinhj/battery.nvim";
    propagatedBuildInputs = with lua51Packages; [ plenary-nvim nvim-web-devicons ];
    buildInputs = [ acpi ];
    disabled = lua51Packages.lua.luaversion != "5.1";
    knownRockspec = writeText "${pname}-${version}.rockspec" ''
      package = "${pname}"
      version = "${version}"
      source = {
        url = ""
      }
      dependencies = {
        "lua == 5.1",
        "plenary.nvim",
        "nvim-web-devicons",
      }
      build = {
        type = "builtin",
        modules = {
          battery = "lua/battery/battery.lua",
        },
        copy_directories = {
          "doc",
          "plugin",
        }
      }
    '';
  };
  nvimRequiredCheck = "battery";
}
