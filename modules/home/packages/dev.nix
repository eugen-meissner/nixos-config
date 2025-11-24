{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc
    gdb

    nodePackages_latest.nodejs

    python3
    python312Packages.ipython
  ];
}
