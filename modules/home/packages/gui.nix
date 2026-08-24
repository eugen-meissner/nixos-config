{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chromium
    ledger-live-desktop
    linux-wallpaperengine
    mupen64plus
    obs-studio
    prismlauncher
    rpcs3
    (retroarch.withCores (cores: with cores; [ ppsspp ]))
    teamspeak6-client
    transmission_4-gtk
    thunderbird
  ];

  xdg.configFile."retroarch/system/PPSSPP/assets".source = "${pkgs.ppsspp}/share/ppsspp/assets";
}
