{ lib, ... }:

{
  imports = lib.filesystem.listFilesRecursive ./imports;
}
