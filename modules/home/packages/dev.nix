{ pkgs, ... }:

let
  dotnetCombined = pkgs.dotnetCorePackages.combinePackages [
    pkgs.dotnetCorePackages.sdk_8_0
    pkgs.dotnetCorePackages.sdk_9_0
    pkgs.dotnetCorePackages.sdk_10_0
  ];
in {
  home.packages = with pkgs; [
    gcc
    gdb
    gnumake
    nodePackages_latest.nodejs
    yarn
    python3
    python312Packages.ipython
    dotnetCombined
    netcoredbg
    terraform
    redisinsight
  ];

  home.sessionVariables = {
    DOTNET_ROOT    = "${dotnetCombined}/share/dotnet";
    DOTNET_ROOT_X64 = "${dotnetCombined}/share/dotnet";
  };
}
