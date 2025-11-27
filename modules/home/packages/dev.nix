{ pkgs, ... }:

let
  dotnetCombined = pkgs.dotnetCorePackages.combinePackages [
    pkgs.dotnetCorePackages.sdk_8_0
    pkgs.dotnetCorePackages.sdk_10_0
  ];
in {
  home.packages = with pkgs; [
    gcc
    gdb

    nodePackages_latest.nodejs

    python3
    python312Packages.ipython

    dotnetCombined
    terraform
  ];
}

