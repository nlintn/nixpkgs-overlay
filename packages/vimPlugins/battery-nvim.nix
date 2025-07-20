{ acpi
, fetchFromGitHub
, lua51Packages
, neovimUtils
, writeText
}:

neovimUtils.buildNeovimPlugin {
  luaAttr = lua51Packages.buildLuarocksPackage rec {
    pname = "battery.nvim";
    version = "scm-1";
    src = fetchFromGitHub {
      owner = "justinhj";
      repo = "battery.nvim";
      rev = "1dd2a2bd6958166d3b9ace93cff76251ad4c09b8";
      sha256 = "sha256-Om85x/F84u8yTFXOnjZLtUG7LgLXcf12EWO1sk+ul0c=";
    };
    propagatedBuildInputs = with lua51Packages; [ plenary-nvim nvim-web-devicons ];
    buildInputs = [ acpi ];
    knownRockspec = writeText "${pname}-${version}.rockspec" ''
      package = "${pname}"
      version = "${version}"
      source = {
        url = "git://github.com/${src.owner}/${src.repo}.git",
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
