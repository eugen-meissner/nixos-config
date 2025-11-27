{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc
    gdb

    nodePackages_latest.nodejs

    python3
    python312Packages.ipython

    dotnetCorePackages.sdk_8_0-bin
    dotnetCorePackages.sdk_10_0-bin
    terraform
  ];
}
